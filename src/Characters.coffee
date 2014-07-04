Hero = ->
  _.extend this, app.assets.hero

Hero.prototype = Object.create cjs.Sprite.prototype
