cjs   = createjs
app   = null

initGame = ->
  app = new cjs.Stage("ternion")

  app.dispatcher  = dispatcher
  cjs.EventDispatcher.initialize app.dispatcher

  app.assets      = loadAssets()
  app.hero        = new Hero()
  app.board       = initBoard()

  app.dispatcher.init()

  cjs.Ticker.addEventListener "tick", tick
  return

tick = (event) ->
  app.update()
  return
