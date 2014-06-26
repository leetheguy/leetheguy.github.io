initSplash1 = ->
  splash = new cjs.Container()
  bg = new cjs.Shape()
  bg.graphics.f("#00f").r(0, 0, 320, 480)
  txt = new cjs.Text("Fooshun Games\nProudly Presents", "20px Arial", "#fff")
  txt.textAlign = "center"
  txt.textBaseline = "middle"
  txt.x = 160
  txt.y = 240
  splash.addChild bg
  splash.addChild txt
  splash

initSplash2 = ->
  splash = new cjs.Container()
  bg = new cjs.Shape()
  bg.graphics.f("#00f").r(0, 0, 320, 480)
  txt = new cjs.Text("Ternion", "20px Arial", "#fff")
  txt.textAlign = "center"
  txt.textBaseline = "middle"
  txt.x = 160
  txt.y = 240
  splash.addChild bg
  splash.addChild txt
  splash
