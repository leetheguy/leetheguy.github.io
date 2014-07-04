Tile = (point, grid) ->
  cjs.Container.call(this)
  @grid   = grid
  @coords = new cjs.Point(point.x, point.y)
  @width  = 32
  @height = 32
  @x = (@coords.x * @width)
  @y = (@coords.y * @height)

  @clickHandler = (event) ->
    app.dispatcher.dispatch new Command("player requests move", {fromPt: app.hero.parent.coords, toPt: @coords})

  @playerRequestsMove = (command) ->
    if command.toX == @coords.x and command.toY == @coords.y
      console.info @coords

  @on "click", @clickHandler, this

  app.dispatcher.on "player requests move", @playerRequestsMove, this

  this

Tile.prototype = Object.create cjs.Container.prototype
Tile.prototype.constructor = Tile
