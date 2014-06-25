cjs   = createjs
app   = null

initGame = ->
  app = new cjs.Stage("ternion")

  app.assets      = loadAssets()
  app.board       = initBoard()
  app.dispatcher  = initDispatcher()

  cjs.Ticker.addEventListener "tick", tick
  return

tick = (event) ->
  app.update()
  return
