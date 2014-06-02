describe "Grid", ->
  grid = null

  describe "populate", ->
    beforeEach ->
      grid = Grid.populate(3, String)

    it "can create a multidimensional array based on size", ->
      expect(grid.length).toEqual(3)
      expect(grid[2].length).toEqual(3)

    it "creates a grid with a length 1 less than size", ->
      expect(grid[2]).not.toBe(undefined)
      expect(grid[3]).toBe(undefined)

    it "populates the array with content", ->
      expect(grid[1][1]).toEqual(jasmine.any(String))

