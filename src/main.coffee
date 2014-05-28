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

cjs   = createjs
app   = null

initGame = ->
  app = new cjs.Stage("ternion")

  app.assets = loadAssets()
  app.board  = initBoard()

  for column in app.board.tiles
    for tile in column
      app.addChild tile

  cjs.Ticker.addEventListener "tick", tick
  return

tick = (event) ->
  app.update()
  return

