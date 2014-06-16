// Generated by CoffeeScript 1.7.1
var Architecture, Door, Wall,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Architecture = {
  spawnFloor: function(level) {
    var floor, style;
    floor = Math.floor(level / 10);
    style = _.random(1);
    return app.assets.floors[floor][style];
  },
  spawnWall: function(level) {
    var floor;
    floor = Math.floor(level / 10);
    return app.assets.walls[floor][0];
  }
};

Wall = (function(_super) {
  __extends(Wall, _super);

  function Wall() {
    return Wall.__super__.constructor.apply(this, arguments);
  }

  return Wall;

})(Architecture);

Door = (function(_super) {
  __extends(Door, _super);

  function Door() {
    return Door.__super__.constructor.apply(this, arguments);
  }

  return Door;

})(Architecture);

//# sourceMappingURL=Architecture.map