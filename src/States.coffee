State = (@navList, @eventList, @screen) ->
  @load = ->
    @beforeState()
    @duringState()
    this

  @beforeState = ->
    @addScreen()
    null

  @addScreen = ->
    app.addChild @screen
    null

  @duringState = ->
    null

  @filterCommands = ->
    null
  
  @unload = ->
    @afterState()
    null

  @afterState = ->
    @removeScreen()
    null

  @removeScreen = ->
    app.removeChild @screen
    null

  this

dispatcher =
  initScreens: ->
    @screens =
      splash1: initSplash1()
      board:   app.board

  initStates: ->
    splash1 = new State {}, [], @screens.splash1
    splash1.duringState = ->
      #new Tween.call(app.dispatcher.dispatch(new cjs.Event("foo")))
    splash2 = new State {}, [], @screens.splash2

    @states =
      splash1: splash1
      splash2: splash2
      board: new State {}, [], @screens.board

  init: ->
    cjs.EventDispatcher.initialize this
    @initScreens()
    @initStates()
    @current_state = @states.splash1.load()
    this

  dispatch: (event) ->
    console.info "yo"
    #if @current_state.navList[event.type] != undefined
    #  @current_state.unload()
    #  @current_state = @states[@current_state.navList[event.type]].load()

    #else if @current_state.eventList.indexOf(event.type) >= 0
    #  @dispatchEvent event

    null

