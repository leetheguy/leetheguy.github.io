// Generated by CoffeeScript 1.7.1
describe("Board", function() {
  describe("initialization", function() {
    it("creates a new board at level 1", function() {
      return expect(app.board.level).toEqual(1);
    });
    return it("removes existing children", function() {
      app.board.addChild(new cjs.Shape());
      app.board = initBoard();
      return expect(app.board.getNumChildren()).toEqual(0);
    });
  });
  describe("buildRoomArray", function() {
    it("creates a 5x5 array of rooms", function() {
      expect(app.board.rooms.length).toEqual(5);
      return expect(app.board.rooms[0].length).toEqual(5);
    });
    it("assigns 1      room  as entry", function() {
      var entries;
      entries = _.chain(app.board.rooms).flatten().filter(function(room) {
        return room.name === "entry";
      }).value().length;
      return expect(entries).toEqual(1);
    });
    it("assigns 1 room  as exit", function() {
      var entries;
      entries = _.chain(app.board.rooms).flatten().filter(function(room) {
        return room.name === "exit";
      }).value().length;
      return expect(entries).toEqual(1);
    });
    it("assigns 3..4 rooms as empty", function() {
      var entries;
      entries = _.chain(app.board.rooms).flatten().filter(function(room) {
        return room.name === "empty";
      }).value().length;
      expect(entries).toBeLessThan(5);
      return expect(entries).toBeGreaterThan(2);
    });
    it("assigns 7..11 rooms as room", function() {
      var entries;
      entries = _.chain(app.board.rooms).flatten().filter(function(room) {
        return room.name === "room";
      }).value().length;
      expect(entries).toBeLessThan(12);
      return expect(entries).toBeGreaterThan(6);
    });
    return it("assigns 8..15 rooms as hall", function() {
      var entries;
      entries = _.chain(app.board.rooms).flatten().filter(function(room) {
        return room.name === "hall";
      }).value().length;
      expect(entries).toBeLessThan(16);
      return expect(entries).toBeGreaterThan(7);
    });
  });
  describe("buildTileArray", function() {
    it("creates a 27x27 array", function() {
      expect(app.board.tiles.length).toEqual(27);
      return expect(app.board.tiles[26].length).toEqual(27);
    });
    return it("has a Tile Container in each place", function() {
      expect(app.board.tiles[0][0]).toEqual(jasmine.any(Tile));
      expect(app.board.tiles[4][2]).toEqual(jasmine.any(Tile));
      return expect(app.board.tiles[26][26]).toEqual(jasmine.any(Tile));
    });
  });
  describe("plotPaths", function() {
    xit("makes every room connected", function() {
      var connectedRooms;
      connectedRooms = _.filter(_.flatten(app.board.rooms), function(room) {
        return room.connected;
      });
      return expect(connectedRooms.length).toEqual(25);
    });
    return xit("makes every non-empty room have an exit", function() {
      var exitableRooms;
      exitableRooms = _.filter(_.flatten(app.board.rooms), function(room) {
        return room.exits.length > 0 || room.name === "empty";
      });
      return expect(exitableRooms.length).toEqual(25);
    });
  });
  describe("createPathFrom", function() {
    return it("returns an array of rooms that ends in a connected room or a dead end", function() {
      var entry, last, path;
      entry = _.where(_.flatten(app.board.rooms), {
        name: "entry"
      })[0];
      path = app.board.createPathFrom(entry);
      last = _.last(path);
      return expect(last.connected || _.isEmpty(app.board.findEscapes(last))).toBeTruthy();
    });
  });
  describe("findEscapes", function() {
    it("returns escapes", function() {
      var room;
      room = app.board.rooms[3][3];
      return expect(_.isEmpty(app.board.findEscapes(room))).toBeFalsy();
    });
    it("doesn't return an exit past the top edge", function() {
      var escapes, room;
      room = app.board.rooms[1][0];
      escapes = app.board.findEscapes(room);
      return expect(escapes.north).toBe(void 0);
    });
    it("doesn't return an exit past the right edge", function() {
      var escapes, room;
      room = app.board.rooms[4][1];
      escapes = app.board.findEscapes(room);
      return expect(escapes.east).toBe(void 0);
    });
    it("doesn't return an exit past the bottom edge", function() {
      var escapes, room;
      room = app.board.rooms[1][4];
      escapes = app.board.findEscapes(room);
      return expect(escapes.south).toBe(void 0);
    });
    it("doesn't return an exit past the left edge", function() {
      var escapes, room;
      room = app.board.rooms[0][1];
      escapes = app.board.findEscapes(room);
      return expect(escapes.west).toBe(void 0);
    });
    it("doesn't return a seeking room above this one", function() {
      var escapes, room;
      app.board.rooms[3][3].seeking = true;
      room = app.board.rooms[3][4];
      escapes = app.board.findEscapes(room);
      return expect(escapes.north).toBe(void 0);
    });
    it("doesn't return a seeking room to the right of this one", function() {
      var escapes, room;
      app.board.rooms[3][3].seeking = true;
      room = app.board.rooms[2][3];
      escapes = app.board.findEscapes(room);
      return expect(escapes.east).toBe(void 0);
    });
    it("doesn't return a seeking room below this one", function() {
      var escapes, room;
      app.board.rooms[3][3].seeking = true;
      room = app.board.rooms[3][2];
      escapes = app.board.findEscapes(room);
      return expect(escapes.south).toBe(void 0);
    });
    it("doesn't return a seeking room to the left of this one", function() {
      var escapes, room;
      app.board.rooms[3][3].name = "empty";
      room = app.board.rooms[4][3];
      escapes = app.board.findEscapes(room);
      return expect(escapes.west).toBe(void 0);
    });
    it("doesn't return an empty room above this one", function() {
      var escapes, room;
      app.board.rooms[3][3].name = "empty";
      room = app.board.rooms[3][4];
      escapes = app.board.findEscapes(room);
      return expect(escapes.north).toBe(void 0);
    });
    it("doesn't return an empty room to the right of this one", function() {
      var escapes, room;
      app.board.rooms[3][3].name = "empty";
      room = app.board.rooms[2][3];
      escapes = app.board.findEscapes(room);
      return expect(escapes.east).toBe(void 0);
    });
    it("doesn't return an empty room below this one", function() {
      var escapes, room;
      app.board.rooms[3][3].name = "empty";
      room = app.board.rooms[3][2];
      escapes = app.board.findEscapes(room);
      return expect(escapes.south).toBe(void 0);
    });
    return it("doesn't return an empty room to the left of this one", function() {
      var escapes, room;
      app.board.rooms[3][3].seeking = true;
      room = app.board.rooms[4][3];
      escapes = app.board.findEscapes(room);
      return expect(escapes.west).toBe(void 0);
    });
  });
  return describe("getNextRoom", function() {
    var next, room;
    room = null;
    next = null;
    beforeEach(function() {
      room = app.board.rooms[0][0];
      return next = app.board.getNextRoom(room);
    });
    it("returns a room that can be exited to", function() {
      return expect((next.coords.x === 1 && next.coords.y === 0) || (next.coords.x === 0 && next.coords.y === 1)).toBeTruthy();
    });
    return it("makes the next room seeking", function() {
      return expect(next.seeking).toBeTruthy();
    });
  });
});

//# sourceMappingURL=BoardSpec.map