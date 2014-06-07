initBoard = ->
  board = new cjs.Container()
  board = _.extend board,
    level: 0

    #TODO find out why room spawning intermittently leaves an unattached room
    spawnLevel: ->
      @despawnLevel()
      @level += 1

      @buildRoomArray()    # give each room a name and purpose
      @buildTileArray()    # create an array of tiles
      @plotPaths()         # connect all rooms to the exit
      #@populateTiles()     # populates tiles with architecture

    despawnLevel: ->
      map:   []
      tiles: []
      rooms: []

    buildRoomArray: ->
      @rooms = Grid.populate(5, Room)
      
      emptyCount = _.random(3,4)
      roomCount  = _.random(7,11)
      hallCount  = 23 - (emptyCount + roomCount)

      pointer    = 2
      roomArray  = _.chain(@rooms).flatten().shuffle().value()

      roomArray[0].name = "entry"

      roomArray[1].name = "exit"
      roomArray[1].connected = true

      for i in [1..emptyCount]
        roomArray[pointer].name = "empty"
        pointer += 1

      for i in [1..roomCount]
        roomArray[pointer].name = "room"
        pointer += 1

      for i in [1..hallCount]
        roomArray[pointer].name = "hall"
        pointer += 1

      return

    buildTileArray: ->
      @tiles = Grid.populate(25, Tile)

    plotPaths: ->
      for column in @rooms
        for room in column
          if not room.connected
            @createPathFrom room

      null

    createPathFrom: (start) ->
      if not start.connected
        start.seeking = true
      path = [start]

      until _.last(path).connected or _.isEmpty(@findEscapes(_.last(path)))
        current = _.last(path)
        escapes = @findEscapes(current)

        if not _.isEmpty(escapes)
          next = @getNextRoom(current)
          @attachExits current, next
          path.push(next)

      # if this path isn't connected
      # recursively call this method on each room in this path
      # until a connected path is created
      if not _.last(path).connected
        for room in path
          if not _.isEmpty(@findEscapes(room)) and @createPathFrom(room)[0].connected
              break

      room.connected = true for room in path

      path

    attachExits: (current, next) ->
      if next.coords.y < current.coords.y
        current.exits.north = next
        next.exits.south    = current
      if next.coords.x > current.coords.x
        current.exits.east  = next
        next.exits.west     = current
      if next.coords.y > current.coords.y
        current.exits.south = next
        next.exits.north    = current
      if next.coords.x < current.coords.x
        current.exits.west  = next
        next.exits.east     = current

    findEscapes: (room) ->
      escapes = {}

      if room.coords.y > 0
        north = @rooms[room.coords.x][room.coords.y - 1]
        if not north.seeking and not (north.name is "empty")
          escapes.north = @rooms[room.coords.x][room.coords.y - 1]

      if room.coords.x < @rooms.length - 1
        east  = @rooms[room.coords.x + 1][room.coords.y]
        if not east.seeking and not (east.name is "empty")
          escapes.east  = @rooms[room.coords.x + 1][room.coords.y]

      if room.coords.y < @rooms.length - 1
        south = @rooms[room.coords.x][room.coords.y + 1]
        if not south.seeking and not (south.name is "empty")
          escapes.south = @rooms[room.coords.x][room.coords.y + 1]

      if room.coords.x > 0
        west  = @rooms[room.coords.x - 1][room.coords.y]
        if not west.seeking and not (west.name is "empty")
          escapes.west  = @rooms[room.coords.x - 1][room.coords.y]

      escapes

    getNextRoom: (current) ->
      room = _.sample(@findEscapes(current))
      room.seeking = true
      room

    populateTiles: ->
      for room in _.flatten(rooms)
        switch room.name
          when "entry"
            renderEntry room
          when "exit"
            renderExit room
          when "empty"
            renderEmpty room
          when "room"
            renderRoom room
          when "hall"
            renderHall room

      return

    renderEntry: (room) ->
      renderRoom(room)
      #someTile.spawnPlayer()

    renderExit: (room) ->
      renderRoom(room)
      #someTile.spawnStairs()

    renderEmpty: (room) ->
      #allTiles.spawnWall()

    renderRoom: (room) ->
      #allTiles.spawnWall()

    renderHall: (room) ->
      #allTiles.spawnWall()

  board.spawnLevel()

  board
