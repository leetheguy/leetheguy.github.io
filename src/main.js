// Generated by CoffeeScript 1.7.1

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
var app, cjs, init, stage, tick;

cjs = createjs;

stage = null;

app = {};

init = function() {
  stage = new cjs.Stage("ternion");
  app.assets = loadAssets();
  app.board = initBoard();
  cjs.Ticker.addEventListener("tick", tick);
};

tick = function(event) {
  stage.update();
};

//# sourceMappingURL=main.map
