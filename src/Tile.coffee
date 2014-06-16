Tile = (point, grid) ->
  cjs.Container.call(this)
  @grid   = grid
  @coords = new cjs.Point(point.x, point.y)
  @width  = 32
  @height = 32
  @x = (@coords.x * @width)
  @y = (@coords.y * @height)

Tile.prototype = Object.create(cjs.Container.prototype)
Tile.prototype.constructor = Tile
