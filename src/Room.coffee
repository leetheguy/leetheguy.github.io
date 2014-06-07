Room = (point) ->
  @coords    = new cjs.Point(point.x, point.y)
  @name      = ""
  @connected = false
  @seeking   = false
  @exits     = {}
  @contents  = []

  return
