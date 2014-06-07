Tile = (point, grid) ->
  cjs.Container.call(this)
  @grid   = grid
  @coords = new cjs.Point(point.x, point.y)
  @width  = 32
  @height = 32
  @x = (@coords.x * @width)
  @y = (@coords.y * @height)

  addArchitecture = (level) ->
  #floor = Math.floor(level / 10)
  #style = _.random(1)
  #@children.push(app.assets.floors[floor][style])

  return

Tile.prototype = Object.create(cjs.Container.prototype)
Tile.prototype.constructor = Tile
