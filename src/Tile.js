// Generated by CoffeeScript 1.7.1
var Tile;

Tile = function(point, grid) {
  var addArchitecture;
  cjs.Container.call(this);
  this.grid = grid;
  this.coords = new cjs.Point(point.x, point.y);
  this.width = 32;
  this.height = 32;
  this.x = this.coords.x * this.width;
  this.y = this.coords.y * this.height;
  addArchitecture = function(level) {};
};

Tile.prototype = Object.create(cjs.Container.prototype);

Tile.prototype.constructor = Tile;

//# sourceMappingURL=Tile.map
