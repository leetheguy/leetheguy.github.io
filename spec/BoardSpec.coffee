describe "Board", ->
  describe "buildMap", ->
    it "creates a 21x21 array as a map", ->
      expect(app.board.map.length).toEqual(21)
      expect(app.board.map[15].length).toEqual(21)
      expect(app.board.map[20].length).toEqual(21)

  describe "initialization", ->
    it "creates a new board at level 1", ->
      expect(app.board.level).toEqual(1)

    it "removes existing children", ->
      child = app.board.addChild(new cjs.Shape())
      app.board = initBoard()
      expect(app.board.contains(child)).toBe(false)

  describe "buildRoomArray", ->
    it "creates a 5x5 array of rooms", ->
      expect(app.board.rooms.length).toEqual(5)
      expect(app.board.rooms[0].length).toEqual(5)

    it "assigns 1 room as entry", ->
      entries = _.chain(app.board.rooms)
        .flatten().filter (room) -> room.name is "entry"
        .value().length
      expect(entries).toEqual(1)

    it "assigns 1 room as exit", ->
      entries = _.chain(app.board.rooms)
        .flatten().filter (room) -> room.name is "exit"
        .value().length
      expect(entries).toEqual(1)

    it "makes exit room connected", ->
      exit = _.chain(app.board.rooms)
        .flatten().filter (room) -> room.name is "exit"
        .last().value()
      expect(exit.connected).toBeTruthy()

    it "assigns 3..4 rooms as empty", ->
      entries = _.chain(app.board.rooms)
        .flatten().filter (room) -> room.name is "empty"
        .value().length
      expect(entries).toBeLessThan(5)
      expect(entries).toBeGreaterThan(2)

    it "assigns 7..11 rooms as room", ->
      entries = _.chain(app.board.rooms)
        .flatten().filter (room) -> room.name is "room"
        .value().length
      expect(entries).toBeLessThan(12)
      expect(entries).toBeGreaterThan(6)

    it "assigns 8..15 rooms as hall", ->
      entries = _.chain(app.board.rooms)
        .flatten().filter (room) -> room.name is "hall"
        .value().length
      expect(entries).toBeLessThan(16)
      expect(entries).toBeGreaterThan(7)

  describe "buildTileArray", ->
    it "creates a 21x21 array", ->
      expect(app.board.tiles.length).toEqual(21)
      expect(app.board.tiles[20].length).toEqual(21)

    it "has a Tile Container in each place", ->
      expect(app.board.tiles[0][0]).toEqual(jasmine.any(Tile))
      expect(app.board.tiles[4][2]).toEqual(jasmine.any(Tile))
      expect(app.board.tiles[18][18]).toEqual(jasmine.any(Tile))

  describe "plotPaths", ->
    it "makes every room connected", ->
      connectedRooms = _.filter(_.flatten(app.board.rooms), (room) -> room.connected)
      expect(connectedRooms.length).toEqual(25)

    xit "intermittently fails: makes every non-empty room have an exit", ->
      exitableRooms = _.filter(_.flatten(app.board.rooms), (room) ->
        not _.isEmpty(room.exits) or room.name is "empty"
      )
      expect(exitableRooms.length).toEqual(25)

   describe "createPathFrom", ->
     it "returns an array of rooms that ends in a connected room or a dead end", ->
       entry = _.where(_.flatten(app.board.rooms), name: "entry")[0]
       path  = app.board.createPathFrom(entry)
       last  = _.last(path)

       expect(last.connected or _.isEmpty(app.board.findEscapes(last))).toBeTruthy()

     it "marks each room as connected if the last room is an exit", ->
       exit  = _.where(_.flatten(app.board.rooms), name: "exit")[0]
       spyOn(app.board, 'getNextRoom').and.returnValue(exit)

       entry = _.where(_.flatten(app.board.rooms), name: "entry")[0]
       path  = app.board.createPathFrom(entry)

       expect(path[0].connected).toBeTruthy()

     it "recursively creates paths until all are connected", ->
       entry = _.where(_.flatten(app.board.rooms), name: "entry")[0]
       exit  = _.where(_.flatten(app.board.rooms), name: "exit")[0]
       path  = app.board.createPathFrom(entry)
       expect(path[0].connected).toBeTruthy()


   describe "findEscapes", ->

     it "returns escapes", ->
       emptyBoard()
       room = app.board.rooms[3][3]
       expect(_.isEmpty(app.board.findEscapes(room))).toBeFalsy()

     it "doesn't return an exit past the top edge", ->
       room = app.board.rooms[1][0]
       escapes = app.board.findEscapes(room)
       expect(escapes.north).toBe(undefined)

     it "doesn't return an exit past the right edge", ->
       room = app.board.rooms[4][1]
       escapes = app.board.findEscapes(room)
       expect(escapes.east).toBe(undefined)

     it "doesn't return an exit past the bottom edge", ->
       room = app.board.rooms[1][4]
       escapes = app.board.findEscapes(room)
       expect(escapes.south).toBe(undefined)

     it "doesn't return an exit past the left edge", ->
       room = app.board.rooms[0][1]
       escapes = app.board.findEscapes(room)
       expect(escapes.west).toBe(undefined)

     it "doesn't return a seeking room above this one", ->
       app.board.rooms[3][3].seeking = true
       room = app.board.rooms[3][4]
       escapes = app.board.findEscapes(room)
       expect(escapes.north).toBe(undefined)

     it "doesn't return a seeking room to the right of this one", ->
       app.board.rooms[3][3].seeking = true
       room = app.board.rooms[2][3]
       escapes = app.board.findEscapes(room)
       expect(escapes.east).toBe(undefined)


     it "doesn't return a seeking room below this one", ->
       app.board.rooms[3][3].seeking = true
       room = app.board.rooms[3][2]
       escapes = app.board.findEscapes(room)
       expect(escapes.south).toBe(undefined)


     it "doesn't return a seeking room to the left of this one", ->
       app.board.rooms[3][3].name = "empty"
       room = app.board.rooms[4][3]
       escapes = app.board.findEscapes(room)
       expect(escapes.west).toBe(undefined)

     it "doesn't return an empty room above this one", ->
       app.board.rooms[3][3].name = "empty"
       room = app.board.rooms[3][4]
       escapes = app.board.findEscapes(room)
       expect(escapes.north).toBe(undefined)

     it "doesn't return an empty room to the right of this one", ->
       app.board.rooms[3][3].name = "empty"
       room = app.board.rooms[2][3]
       escapes = app.board.findEscapes(room)
       expect(escapes.east).toBe(undefined)


     it "doesn't return an empty room below this one", ->
       app.board.rooms[3][3].name = "empty"
       room = app.board.rooms[3][2]
       escapes = app.board.findEscapes(room)
       expect(escapes.south).toBe(undefined)


     it "doesn't return an empty room to the left of this one", ->
       app.board.rooms[3][3].seeking = true
       room = app.board.rooms[4][3]
       escapes = app.board.findEscapes(room)
       expect(escapes.west).toBe(undefined)

  describe "getNextRoom", ->
    room = null
    next = null

    beforeEach ->
      emptyBoard()
      room = app.board.rooms[0][0]
      next = app.board.getNextRoom room

    it "returns a room that can be exited to", ->
      expect((next.coords.x is 1 and next.coords.y is 0) or (next.coords.x is 0 and next.coords.y is 1)).toBeTruthy()

    it "makes the next room seeking", ->
      expect(next.seeking).toBeTruthy()

  describe "mapArchitecture", ->
    room = null

    beforeEach ->
      emptyBoard()
      room = new Room(new cjs.Point(2,2))

    it "places rooms accurately on the map", ->
      app.board.renderRoom room
      expect(app.board.map[9][9]).toEqual(0)
      expect(app.board.map[11][11]).toEqual(0)
      expect(app.board.map[12][12]).toEqual(1)

    describe "standard room doors", ->
      it "are placed to the east",  ->
        room.exits.east = true
        app.board.renderRoom room
        expect(app.board.map[12][10]).toEqual(2)

      it "are placed to the south", ->
        room.exits.south = true
        app.board.renderRoom room
        expect(app.board.map[10][12]).toEqual(2)

    describe "halls", ->
      it "can have a north passage", ->
        room.exits.north = true
        app.board.renderHall room
        expect(app.board.map[10][9]).toEqual(0)

      it "are placed to the east",  ->
        room.exits.east = true
        app.board.renderHall room
        expect(app.board.map[12][10]).toEqual(0)
        expect(app.board.map[11][10]).toEqual(0)

      it "are placed to the south", ->
        room.exits.south = true
        app.board.renderHall room
        expect(app.board.map[10][12]).toEqual(0)
        expect(app.board.map[10][11]).toEqual(0)

      it "are placed to the west",  ->
        room.exits.west = true
        app.board.renderHall room
        expect(app.board.map[9][10]).toEqual(0)

    it "renders empties", ->
      room.name = "empty"
      app.board.renderEmpty room
      expect(app.board.map[10][9]).toEqual(1)
      expect(app.board.map[11][10]).toEqual(1)
      expect(app.board.map[10][11]).toEqual(1)
      expect(app.board.map[9][10]).toEqual(1)
      expect(app.board.map[10][10]).toEqual(1)

  describe "mapPointSurroundings", ->
    it "returns null if point is on top edge of map", ->
      expect(app.board.mapPointSurroundings(13,0)).toBe(null)

    it "returns null if point is on right edge of map", ->
      expect(app.board.mapPointSurroundings(20,13)).toBe(null)

    it "returns null if point is on bottom edge of map", ->
      expect(app.board.mapPointSurroundings(13,20)).toBe(null)

    it "returns null if point is on left edge of map", ->
      expect(app.board.mapPointSurroundings(0,13)).toBe(null)

    it "returns a 3x3 array", ->
      expect(app.board.mapPointSurroundings(1,1).length).toEqual(3)
      expect(app.board.mapPointSurroundings(1,1)[0].length).toEqual(3)
    it "returns a subsection of the map", ->
      surroundings = app.board.mapPointSurroundings(1,1)
      expect(surroundings[1][0]).toEqual(1)
      expect(surroundings[2][1]).toEqual(app.board.map[2][1])
      expect(surroundings[1][2]).toEqual(app.board.map[1][2])
      expect(surroundings[0][1]).toEqual(1)

