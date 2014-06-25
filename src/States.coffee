initDispatcher = ->
  State = (@navList, @eventList, @screen) ->
    load = ->
      @beforeState()
      @duringState()

    beforeState = ->
      @addScreen()
      null

    addScreen = ->
      app.addChild @screen
      null

    duringState = ->
      null

    filterCommands = ->
      null
    
    unload = ->
      @afterState()
      null

    afterState = ->
      @removeScreen()
      null

    removeScreen = ->
      app.removeChild @screen
      null


  dispatcher =
    initScreens: ->
      @screens =
        board: app.board

    initStates: ->
      @states =
        #splash1: new State [], [], screens.splash1
        #splash2: new State [], [], screens.splash2
        board: new State([], [], dispatcher.screens.board)

    init: ->
      @initScreens()
      @initStates()
      @states.board.load
      this

  dispatcher.init()
