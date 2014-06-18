initBoard = ->
  board = new cjs.Container()
  board = _.extend board,
    level: 0

    #TODO find out why room spawning intermittently leaves an unattached room
    spawnLevel: ->
      @despawnLevel()
      @level += 1

      @buildMap()          # creates a map used for level construction
      @buildRoomArray()    # give each room a name and purpose
      @buildTileArray()    # create an array of tiles
      @plotPaths()         # connect all rooms to the exit
      @mapArchitecture()   # populates architecture map
      @renderTiles()

      this

    despawnLevel: ->
      @map = []
      @tiles = []
      @rooms = []

    buildMap: ->
      for [0...23]
        @map.push _.map(_.range(0, 23), -> 1)

    buildRoomArray: ->
      @rooms = Grid.populate(5, Room)
      
      emptyCount = 0 #_.random(4,6)
      roomCount  = _.random(5,9)
      hallCount  = 23 - (emptyCount + roomCount)

      pointer    = 2
      roomArray  = _.chain(@rooms).flatten().shuffle().value()

      roomArray[0].name = "entry"

      roomArray[1].name = "exit"
      roomArray[1].connected = true

      #for i in [1..emptyCount]
      #  roomArray[pointer].name = "empty"
      #  pointer += 1

      for i in [1..roomCount]
        roomArray[pointer].name = "room"
        pointer += 1

      for i in [1..hallCount]
        roomArray[pointer].name = "hall"
        pointer += 1

      return

    buildTileArray: ->
      @tiles = Grid.populate(21, Tile)

    plotPaths: ->
      while true
        unmapped = 0
        for room in _.flatten(@rooms)
          if not room.connected and not (room.name is "empty")
            unmapped += 1
            @createPathFrom room

        break if unmapped is 0
      null

    createPathFrom: (start) ->
      if not start.connected
        start.seeking = true
      path = [start]

      # keep adding random rooms to the path until a connected room or a dead end is found
      until _.last(path).connected or _.isEmpty(@findEscapes(_.last(path)))
        current = _.last(path)
        escapes = @findEscapes(current)

        if not _.isEmpty(escapes)
          next = @getNextRoom(current)
          @attachExits current, next
          path.push(next)

      # if the last room is connected make this path connected
      if _.last(path).connected
        room.connected = true for room in path
        room.seeking = false for room in path

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

    mapArchitecture: ->
      for room in _.flatten(@rooms)
        switch room.name
          when "entry"
            @renderEntry room
          when "exit"
            @renderExit  room
          when "empty"
            @renderEmpty room
          when "room"
            @renderRoom  room
          when "hall"
            @renderHall  room

      return

    # key:
    # 0: floor
    # 1: wall
    # 2: door

    renderRoom: (room) ->
      structure = [[0,0,0,1],
                   [0,0,0,1],
                   [0,0,0,1],
                   [1,1,1,1]]

      structure[3][1] = 0 if not (typeof room.exits.east  is "undefined")
      structure[1][3] = 0 if not (typeof room.exits.south is "undefined")

      @roomToMap room, structure

    renderEntry: (room) ->
      @renderRoom(room)
      #someTile.spawnPlayer()

    renderExit: (room) ->
      structure = [[0,0,0,1],
                   [0,0,0,1],
                   [0,0,0,1],
                   [1,1,1,1]]

      structure[3][1] = 0 if not (typeof room.exits.east  is "undefined")
      structure[1][3] = 0 if not (typeof room.exits.south is "undefined")

      @roomToMap room, structure

      #@renderRoom(room)
      #someTile.spawnStairs()

    renderEmpty: (room) ->
      structure = [[1,1,1,1],
                   [1,1,1,1],
                   [1,1,1,1],
                   [1,1,1,1]]

      @roomToMap room, structure

    renderHall: (room) ->
      structure = [[1,1,1,1],
                   [1,0,1,1],
                   [1,1,1,1],
                   [1,1,1,1]]

      if not (typeof room.exits.north is "undefined")
        structure[1][0] = 0
      if not (typeof room.exits.east  is "undefined")
        structure[3][1] = 0
        structure[2][1] = 0
      if not (typeof room.exits.south is "undefined")
        structure[1][3] = 0
        structure[1][2] = 0
      if not (typeof room.exits.west  is "undefined")
        structure[0][1] = 0
        structure[1][1] = 0

      @roomToMap room, structure

    roomToMap: (room, structure) ->
      x_base = (room.coords.x * 4) + 2
      y_base = (room.coords.y * 4) + 2

      for i in [0...4]
        for j in [0...4]
          @map[x_base+i][y_base+j] = structure[i][j]

      @map

    renderTiles: ->
      for i in [1..21]
        for j in [1..21]
          switch @map[i][j]
            when 0
              element = Architecture.spawnFloor @level, @mapPointSurroundings(i, j)
            when 1
              element = Architecture.spawnWall  @level, @mapPointSurroundings(i, j)
            when 2
              element = Architecture.spawnFloor @level, @mapPointSurroundings(i, j)
          tile = @tiles[i-1][j-1]
          tile.children.push element
          @addChild tile

     mapPointSurroundings: (x,y) ->
       if x is 0 or x is @map.length - 1 or y is 0 or y is @map.length - 1
         return null
       else
         surroundings = []
         for i in [x-1..x+1]
           surroundings.push []
           for j in [y-1..y+1]
             _.last(surroundings).push @map[i][j]

         return surroundings

  board.spawnLevel()

