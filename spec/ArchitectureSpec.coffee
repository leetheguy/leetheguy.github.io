describe "Architecture", ->

describe "Wall", ->
  describe "surroundingsToBinary", ->
    it "returns a binary digit from a 3x3 array", ->
      arr = [[0,0,0],[0,0,0],[0,1,0]]
      expect(Architecture.surroundingsToBinary(arr)).toEqual("00000100")
      expect(parseInt(Architecture.surroundingsToBinary(arr), 2) & 4).toEqual(4)


