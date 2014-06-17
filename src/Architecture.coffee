Architecture =
  spawnFloor: (level) ->
    floor = Math.floor(level / 10)
    style = _.random(1)
    return app.assets.floors[floor][style]

  spawnWall: (level) ->
    floor = Math.floor(level / 10)
    return app.assets.walls[floor][4]

class Wall  extends Architecture

class Door  extends Architecture

