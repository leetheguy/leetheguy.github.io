State = (@navList, @eventList, @screen) ->
  @load = ->
    @beforeLoad()
    @addScreen()
    @afterLoad()
    @duringState()
    this

  @beforeLoad = ->
    null

  @addScreen = ->
    app.addChild @screen
    null

  @afterLoad = ->
    null

  @duringState = ->
    null

  @unload = ->
    @beforeUnload()
    @removeScreen()
    @afterUnload()
    null

  @filterCommands = ->
    null
  
  @beforeUnload = ->
    null

  @removeScreen = ->
    app.removeChild @screen
    null

  @afterUnload = ->
    null

  this

Command = (@type, args) ->
  cjs.Event.call this, @type

  @fromPt  = args.fromPt
  @fromPt ?= {x: -1, y: -1}
  @fromPt  = new cjs.Point(@fromPt.x, @fromPt.y)
  @fromX   = @fromPt.x
  @fromY   = @fromPt.y

  @toPt    = args.toPt
  @toPt   ?= {x: -1, y: -1}
  @toPt    = new cjs.Point(@toPt.x, @toPt.y)
  @toX     = @toPt.x
  @toY     = @toPt.y

  @fromEnt = args.fromEntity ? null
  @toEnt   = args.toEntity   ? null

  @message = args.message    ? ""



Command.prototype = Object.create cjs.Event.prototype

dispatcher =
  initScreens: ->
    @screens =
      splash1: initSplash1()
      splash2: initSplash2()
      board:   app.board

  initStates: ->
    splash1 = new State {nextSplash: "splash2"}, [], @screens.splash1
    splash1.duringState = ->
      new cjs.Tween().wait(300).call(app.dispatcher.dispatch, [new cjs.Event("nextSplash")], app.dispatcher)
    splash2 = new State {nextSplash: "board"}, [], @screens.splash2
    splash2.duringState = ->
      new cjs.Tween().wait(300).call(app.dispatcher.dispatch, [new cjs.Event("nextSplash")], app.dispatcher)

    @states =
      splash1: splash1
      splash2: splash2
      board: new State {}, ["player requests move"], @screens.board

  init: ->
    @initScreens()
    @initStates()
    @current_state = @states.splash1.load()
    this

  dispatch: (event) ->
    if @current_state.navList[event.type] != undefined
      @current_state.unload()
      @current_state = @states[@current_state.navList[event.type]].load()

    else if @current_state.eventList.indexOf(event.type) >= 0
      @dispatchEvent event

    null

