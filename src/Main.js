/*
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
 */
var app, cjs, initGame, tick;

cjs = createjs;

app = null;

initGame = function() {
  var column, tile, _i, _j, _len, _len1, _ref;
  app = new cjs.Stage("ternion");
  app.assets = loadAssets();
  app.board = initBoard();
  _ref = app.board.tiles;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    column = _ref[_i];
    for (_j = 0, _len1 = column.length; _j < _len1; _j++) {
      tile = column[_j];
      app.addChild(tile);
    }
  }
  cjs.Ticker.addEventListener("tick", tick);
};

tick = function(event) {
  app.update();
};

//# sourceMappingURL=Main.map
