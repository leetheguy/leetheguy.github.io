###
    Copyright (C) 2014  Lee Nathan
    https://github.com/leetheguy/ternion

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

init = ->
  stage = new cjs.Stage("demoCanvas")
  cjs.Ticker.addEventListener "tick", tick
  sprites =
    images: ["./assets/images/architecture.png"]
    frames:
      width: 32
      height: 32

    animations:
      dirt_1: 0
      rock: 1
      dirt_2: 16

  architectureTiles = new cjs.SpriteSheet(sprites)
  dirt_1 = new cjs.Sprite(architectureTiles, "dirt_1")
  dirt_2 = new cjs.Sprite(architectureTiles, "dirt_2")
  rock = new cjs.Sprite(architectureTiles, "rock")
  dirt_2.x = 32
  rock.x = 64
  stage.addChild dirt_1, dirt_2, rock
  return

tick = (event) ->
  stage.update()
  return

cjs = createjs
