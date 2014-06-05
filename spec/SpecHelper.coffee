beforeEach ->
  initGame()

emptyBoard = ->
  app.board.level = 0
  spyOn(app.board, 'plotPaths')
  app.board.spawnLevel()
