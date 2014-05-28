describe "Board", ->
  describe "initialization", ->
    it "creates a new board at level 1", ->
      expect(app.board.level).toEqual(1)

    it "has no children", ->
      app.board.addChild(new cjs.Shape())
      app.board = initBoard()
      expect(app.board.getNumChildren()).toEqual(0)

  describe "build tile array", ->
    it "creates a 12x12 array", ->
      expect(app.board.tiles.length).toEqual(12)
      expect(app.board.tiles[11].length).toEqual(12)

    it "has a Tile Container in each place", ->
      expect(app.board.tiles[0][0]).toEqual(jasmine.any(Tile))
#      console.info(app.board.tiles[0][0])
