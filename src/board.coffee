initBoard = ->
  board = new cjs.Container()
  board = _.extend board, {level: 0, tiles: [], rooms: []}

  board.spawnLevel = ->
    @level += 1

  board