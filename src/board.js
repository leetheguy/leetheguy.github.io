// Generated by CoffeeScript 1.7.1
var initBoard;

initBoard = function() {
  var board;
  board = new cjs.Container();
  board = _.extend(board, {
    level: 0,
    tiles: [],
    rooms: []
  });
  board.spawnLevel = function() {
    return this.level += 1;
  };
  return board;
};

//# sourceMappingURL=board.map
