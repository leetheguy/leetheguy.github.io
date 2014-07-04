// Generated by CoffeeScript 1.7.1
var initBoard;

initBoard = function() {
  var board;
  board = new cjs.Container();
  board = _.extend(board, {
    level: 0,
    spawnLevel: function() {
      this.despawnLevel();
      this.level += 1;
      this.buildMap();
      this.buildRoomArray();
      this.buildTileArray();
      this.plotPaths();
      this.mapArchitecture();
      this.renderTiles();
      return this;
    },
    despawnLevel: function() {
      this.map = [];
      this.tiles = [];
      return this.rooms = [];
    },
    buildMap: function() {
      var _i, _results;
      _results = [];
      for (_i = 0; _i < 23; _i++) {
        _results.push(this.map.push(_.map(_.range(0, 23), function() {
          return 1;
        })));
      }
      return _results;
    },
    buildRoomArray: function() {
      var hallCount, i, pointer, roomArray, roomCount, _i, _j;
      this.rooms = Grid.populate(5, Room);
      roomCount = _.random(5, 9);
      hallCount = 23 - roomCount;
      pointer = 2;
      roomArray = _.chain(this.rooms).flatten().shuffle().value();
      roomArray[0].name = "entry";
      roomArray[1].name = "exit";
      roomArray[1].connected = true;
      for (i = _i = 1; 1 <= roomCount ? _i <= roomCount : _i >= roomCount; i = 1 <= roomCount ? ++_i : --_i) {
        roomArray[pointer].name = "room";
        pointer += 1;
      }
      for (i = _j = 1; 1 <= hallCount ? _j <= hallCount : _j >= hallCount; i = 1 <= hallCount ? ++_j : --_j) {
        roomArray[pointer].name = "hall";
        pointer += 1;
      }
    },
    buildTileArray: function() {
      return this.tiles = Grid.populate(21, Tile);
    },
    plotPaths: function() {
      var room, unmapped, _i, _len, _ref;
      while (true) {
        unmapped = 0;
        _ref = _.flatten(this.rooms);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          room = _ref[_i];
          if (!room.connected && !(room.name === "empty")) {
            unmapped += 1;
            this.createPathFrom(room);
          }
        }
        if (unmapped === 0) {
          break;
        }
      }
      return null;
    },
    createPathFrom: function(start) {
      var current, escapes, next, path, room, _i, _j, _len, _len1;
      if (!start.connected) {
        start.seeking = true;
      }
      path = [start];
      while (!(_.last(path).connected || _.isEmpty(this.findEscapes(_.last(path))))) {
        current = _.last(path);
        escapes = this.findEscapes(current);
        if (!_.isEmpty(escapes)) {
          next = this.getNextRoom(current);
          this.attachExits(current, next);
          path.push(next);
        }
      }
      if (_.last(path).connected) {
        for (_i = 0, _len = path.length; _i < _len; _i++) {
          room = path[_i];
          room.connected = true;
        }
        for (_j = 0, _len1 = path.length; _j < _len1; _j++) {
          room = path[_j];
          room.seeking = false;
        }
      }
      return path;
    },
    attachExits: function(current, next) {
      if (next.coords.y < current.coords.y) {
        current.exits.north = next;
        next.exits.south = current;
      }
      if (next.coords.x > current.coords.x) {
        current.exits.east = next;
        next.exits.west = current;
      }
      if (next.coords.y > current.coords.y) {
        current.exits.south = next;
        next.exits.north = current;
      }
      if (next.coords.x < current.coords.x) {
        current.exits.west = next;
        return next.exits.east = current;
      }
    },
    findEscapes: function(room) {
      var east, escapes, north, south, west;
      escapes = {};
      if (room.coords.y > 0) {
        north = this.rooms[room.coords.x][room.coords.y - 1];
        if (!north.seeking && !(north.name === "empty")) {
          escapes.north = this.rooms[room.coords.x][room.coords.y - 1];
        }
      }
      if (room.coords.x < this.rooms.length - 1) {
        east = this.rooms[room.coords.x + 1][room.coords.y];
        if (!east.seeking && !(east.name === "empty")) {
          escapes.east = this.rooms[room.coords.x + 1][room.coords.y];
        }
      }
      if (room.coords.y < this.rooms.length - 1) {
        south = this.rooms[room.coords.x][room.coords.y + 1];
        if (!south.seeking && !(south.name === "empty")) {
          escapes.south = this.rooms[room.coords.x][room.coords.y + 1];
        }
      }
      if (room.coords.x > 0) {
        west = this.rooms[room.coords.x - 1][room.coords.y];
        if (!west.seeking && !(west.name === "empty")) {
          escapes.west = this.rooms[room.coords.x - 1][room.coords.y];
        }
      }
      return escapes;
    },
    getNextRoom: function(current) {
      var room;
      room = _.sample(this.findEscapes(current));
      room.seeking = true;
      return room;
    },
    mapArchitecture: function() {
      var room, _i, _len, _ref;
      _ref = _.flatten(this.rooms);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        room = _ref[_i];
        switch (room.name) {
          case "entry":
            this.renderEntry(room);
            break;
          case "exit":
            this.renderExit(room);
            break;
          case "empty":
            this.renderEmpty(room);
            break;
          case "room":
            this.renderRoom(room);
            break;
          case "hall":
            this.renderHall(room);
        }
      }
    },
    renderRoom: function(room) {
      var structure;
      structure = [[0, 0, 0, 1], [0, 0, 0, 1], [0, 0, 0, 1], [1, 1, 1, 1]];
      if (!(typeof room.exits.east === "undefined")) {
        structure[3][1] = 0;
      }
      if (!(typeof room.exits.south === "undefined")) {
        structure[1][3] = 0;
      }
      return this.roomToMap(room, structure);
    },
    renderEntry: function(room) {
      var structure;
      structure = [[0, 0, 0, 1], [0, 'h', 0, 1], [0, 0, 0, 1], [1, 1, 1, 1]];
      if (!(typeof room.exits.east === "undefined")) {
        structure[3][1] = 0;
      }
      if (!(typeof room.exits.south === "undefined")) {
        structure[1][3] = 0;
      }
      return this.roomToMap(room, structure);
    },
    renderExit: function(room) {
      var structure;
      structure = [[0, 0, 0, 1], [0, 0, 0, 1], [0, 0, 0, 1], [1, 1, 1, 1]];
      if (!(typeof room.exits.east === "undefined")) {
        structure[3][1] = 0;
      }
      if (!(typeof room.exits.south === "undefined")) {
        structure[1][3] = 0;
      }
      return this.roomToMap(room, structure);
    },
    renderEmpty: function(room) {
      var structure;
      structure = [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]];
      return this.roomToMap(room, structure);
    },
    renderHall: function(room) {
      var structure;
      structure = [[1, 1, 1, 1], [1, 0, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]];
      if (!(typeof room.exits.north === "undefined")) {
        structure[1][0] = 0;
      }
      if (!(typeof room.exits.east === "undefined")) {
        structure[3][1] = 0;
        structure[2][1] = 0;
      }
      if (!(typeof room.exits.south === "undefined")) {
        structure[1][3] = 0;
        structure[1][2] = 0;
      }
      if (!(typeof room.exits.west === "undefined")) {
        structure[0][1] = 0;
        structure[1][1] = 0;
      }
      return this.roomToMap(room, structure);
    },
    roomToMap: function(room, structure) {
      var i, j, x_base, y_base, _i, _j;
      x_base = (room.coords.x * 4) + 2;
      y_base = (room.coords.y * 4) + 2;
      for (i = _i = 0; _i < 4; i = ++_i) {
        for (j = _j = 0; _j < 4; j = ++_j) {
          this.map[x_base + i][y_base + j] = structure[i][j];
        }
      }
      return this.map;
    },
    renderTiles: function() {
      var element, elements, i, j, tile, _i, _results;
      _results = [];
      for (i = _i = 1; _i <= 21; i = ++_i) {
        _results.push((function() {
          var _j, _k, _len, _results1;
          _results1 = [];
          for (j = _j = 1; _j <= 21; j = ++_j) {
            elements = [];
            switch (this.map[i][j]) {
              case 0:
                elements.push(Floor.spawn(this.level, this.mapPointSurroundings(i, j)));
                break;
              case 1:
                elements.push(Wall.spawn(this.level, this.mapPointSurroundings(i, j)));
                break;
              case 2:
                elements.push(Architecture.spawnFloor(this.level, this.mapPointSurroundings(i, j)));
                break;
              case 'h':
                elements.push(Floor.spawn(this.level, this.mapPointSurroundings(i, j)));
                elements.push(app.hero);
            }
            tile = this.tiles[i - 1][j - 1];
            for (_k = 0, _len = elements.length; _k < _len; _k++) {
              element = elements[_k];
              tile.addChild(element);
            }
            _results1.push(this.addChild(tile));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    },
    mapPointSurroundings: function(x, y) {
      var i, j, s, surroundings, _i, _j, _ref, _ref1, _ref2, _ref3;
      if (x === 0 || x === this.map.length - 1 || y === 0 || y === this.map.length - 1) {
        return null;
      } else {
        surroundings = [];
        for (i = _i = _ref = x - 1, _ref1 = x + 1; _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; i = _ref <= _ref1 ? ++_i : --_i) {
          surroundings.push([]);
          for (j = _j = _ref2 = y - 1, _ref3 = y + 1; _ref2 <= _ref3 ? _j <= _ref3 : _j >= _ref3; j = _ref2 <= _ref3 ? ++_j : --_j) {
            s = this.map[i][j];
            s = s !== 0 && s !== 1 ? 0 : s;
            _.last(surroundings).push(s);
          }
        }
        return surroundings;
      }
    }
  });
  return board.spawnLevel();
};

//# sourceMappingURL=Board.map
