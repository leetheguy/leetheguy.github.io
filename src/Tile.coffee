spawnTile = (point) ->
  tile = new cjs.Container()
  tile = _.extend tile,
    point: new Point(point.x, point.y)
