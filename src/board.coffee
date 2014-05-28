initBoard = ->
  board = new cjs.Container()
  board = _.extend board,
    level: 0
    tiles: []
    rooms: []

# give each room a name / purpose
# create a 11x11 array of tiles
# add walls to tiles
# add items to tiles based on rooms
# make every room accessible
# add doors and remaining walls
# hide all rooms except start
    spawnLevel: ->
      @level += 1
      @populateRooms()
      @buildTileArray()


    buildTileArray: ->
      for i in [0...12]
        @tiles[i] = []
        for j in [0...12]
          tile = new Tile(new cjs.Point(i,j), @level)
          @tiles[i].push tile

    populateRooms: ->

    populateStaticTiles: ->

    populateRoomTiles: ->

    plotPaths: ->

    populateDoors: ->

    hideRooms: ->

  board.spawnLevel()

  board