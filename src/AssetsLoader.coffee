# H   A   B
#
#
#
# G



spriteSheet = null

loadAssets = ->
  sprites =
    images: ["assets/images/architecture.png"]
    frames:
      width: 32
      height: 32

  spriteSheet = new cjs.SpriteSheet(sprites)

  stairs = newTile(6)

  floors = [
    [newTile(0), newTile(16)],
    [newTile(1), newTile(17)],
    [newTile(2), newTile(18)],
    [newTile(3), newTile(19)],
    [newTile(4), newTile(20)]
  ]

  walls = [
    [newTile(32), newTile(48), newTile(64), newTile(80), newTile(96),  newTile(112), newTile(128), newTile(144), newTile(160), newTile(176), newTile(208)],
    [newTile(33), newTile(49), newTile(65), newTile(81), newTile(97),  newTile(113), newTile(129), newTile(145), newTile(161), newTile(177)],
    [newTile(34), newTile(50), newTile(66), newTile(82), newTile(98),  newTile(114), newTile(130), newTile(146), newTile(162), newTile(178)],
    [newTile(35), newTile(51), newTile(67), newTile(83), newTile(99),  newTile(115), newTile(131), newTile(147), newTile(163), newTile(179)],
    [newTile(36), newTile(52), newTile(68), newTile(84), newTile(100), newTile(116), newTile(132), newTile(148), newTile(164), newTile(180)]
  ]

  floor_decor = [
    [newTile(6),  newTile(22)],
    [newTile(7),  newTile(23)],
    [newTile(8),  newTile(24)],
    [newTile(9),  newTile(25)],
    [newTile(10), newTile(26)]
  ]

  wall_decor = [
    [newTile(38), newTile(54)],
    [newTile(39), newTile(55)],
    [newTile(40), newTile(56)],
    [newTile(41), newTile(57)],
    [newTile(42), newTile(58)]
  ]

  return {stairs: stairs, floors: floors, walls: walls, floor_decor: floor_decor, wall_decor: wall_decor}

newTile = (x) ->
  tile = new cjs.Sprite(spriteSheet)
  tile.gotoAndStop(x)
  tile
