Architecture =
  spawnFloor: (level) ->
    level = Math.floor(level / 10)
    style = _.random(5)
    style = if style is 1 then 0 else 1
    return app.assets.floors[level][style]

  spawnWall: (level, surroundings) ->
    #console.info surroundings
    #console.info @surroundingsToBinary surroundings
    level = Math.floor(level / 10)

    n = parseInt @surroundingsToBinary(surroundings), 2

    ul = switch
      when (n & 193) is 193 then 5
      when (n & 192) is 192 then 2
      when (n & 129) is 129 then 8
      when (n & 128) is 128 then 0
      when (n & 65 ) is 65  then 20
      when (n & 64 ) is 64  then 2
      when (n & 1  ) is 1   then 8
      else 0

    ur = switch
      when (n & 7) is 7 then 6
      when (n & 6) is 6 then 1
      when (n & 5) is 5 then 21
      when (n & 4) is 4 then 1
      when (n & 3) is 3 then 11
      when (n & 2) is 2 then 3
      when (n & 1) is 1 then 11
      else 3

    lr = switch
      when (n & 28) is 28 then 10
      when (n & 24) is 24 then 7
      when (n & 20) is 20 then 11
      when (n & 16) is 16 then 7
      when (n & 12) is 12 then 17
      when (n & 8)  is 8  then 19
      when (n & 4)  is 4  then 17
      else 19

    ll = switch
      when (n & 112) is 112 then 9
      when (n & 96)  is 96  then 18
      when (n & 80)  is 80  then 4
      when (n & 64)  is 64  then 18
      when (n & 48)  is 48  then 4
      when (n & 32)  is 32  then 16
      when (n & 16)  is 16  then 4
      else 16


    wall = new cjs.Container
    ul = _.clone(app.assets.wallParts[level][ul])
    ur = _.clone(app.assets.wallParts[level][ur])
    ur.x = 16
    ll = _.clone(app.assets.wallParts[level][ll])
    ll.y = 16
    lr = _.clone(app.assets.wallParts[level][lr])
    lr.x = 16
    lr.y = 16
    
    wall.addChild ul
    wall.addChild ur
    wall.addChild ll
    wall.addChild lr

    wall

  surroundingsToBinary: (s) ->
    '' + s[0][0] + s[0][1] + s[0][2] + s[1][2] + s[2][2] + s[2][1] + s[2][0] + s[1][0]

class Wall  extends Architecture

class Door  extends Architecture

