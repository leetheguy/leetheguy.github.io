loadAssets = ->
  architectureImage =
    images: ["assets/images/architecture.png"]
    frames:
      width: 32
      height: 32

  a = new cjs.SpriteSheet(architectureImage)

  stairs = newSprite(6, a)

  floors = [
    [newSprite(0,a), newSprite(16,a)],
    [newSprite(1,a), newSprite(17,a)],
    [newSprite(2,a), newSprite(18,a)],
    [newSprite(3,a), newSprite(19,a)],
    [newSprite(4,a), newSprite(20,a)]
  ]

  floorDecor = [
    [newSprite(6,a),  newSprite(22,a)],
    [newSprite(7,a),  newSprite(23,a)],
    [newSprite(8,a),  newSprite(24,a)],
    [newSprite(9,a),  newSprite(25,a)],
    [newSprite(10,a), newSprite(26,a)]
  ]

  wallDecor = [
    [newSprite(38,a), newSprite(54,a)],
    [newSprite(39,a), newSprite(55,a)],
    [newSprite(40,a), newSprite(56,a)],
    [newSprite(41,a), newSprite(57,a)],
    [newSprite(42,a), newSprite(58,a)]
  ]

  wallImage =
    images: ["assets/images/walls.png"]
    frames:
      width: 16
      height: 16
  
  w = new cjs.SpriteSheet(wallImage)

  wallParts = []
  for i in [0...5]
    wallParts[i] = []
    for j in [0...24]
      n = (Math.floor(j / 4) * 32) + j % 4 + (i * 4)
      wallParts[i][j] = newSprite(n, w)

  heroImage =
    images: ["assets/images/wizard.gif"]
    frames:
      width: 32
      height: 32
  
  h = new cjs.SpriteSheet(heroImage)

  hero = newSprite(0, h)

  return {stairs: stairs, floors: floors, wallParts: wallParts, floorDecor: floorDecor, wallDecor: wallDecor, hero: hero}

newSprite = (x, sheet) ->
  sprite = new cjs.Sprite(sheet)
  sprite.gotoAndStop(x)
  sprite
