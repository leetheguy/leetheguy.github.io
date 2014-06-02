Grid =
  # requires that the element be instantiated with only a new point
  populate: (size, content) ->
    grid = []
    for i in [0...size]
      grid[i] = []
      for j in [0...size]
        grid[i][j] = new content(new cjs.Point(i, j))

    grid

