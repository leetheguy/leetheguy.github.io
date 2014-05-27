describe "Board", ->
  player = undefined

  beforeEach ->
    initGame()

  describe "initialization", ->
    it "creates a new board at level 1", ->
      expect(app.board.level).toEqual(1)

    it "has no children", ->
      app.board.addChild(new cjs.Shape())
      app.board = initBoard()
      expect(app.board.getNumChildren()).toEqual(0)

  describe "room population", ->


#  it "should be able to play a Song", ->
#    player.play song
#    expect(player.currentlyPlayingSong).toEqual song
#
#    #demonstrates use of custom matcher
#    expect(player).toBePlaying song
#    return
#
#  describe "when song has been paused", ->
#    beforeEach ->
#      player.play song
#      player.pause()
#      return
#
#    it "should indicate that the song is currently paused", ->
#      expect(player.isPlaying).toBeFalsy()
#
#      # demonstrates use of 'not' with a custom matcher
#      expect(player).not.toBePlaying song
#      return
#
#    it "should be possible to resume", ->
#      player.resume()
#      expect(player.isPlaying).toBeTruthy()
#      expect(player.currentlyPlayingSong).toEqual song
#      return
#
#    return
#
#
#  # demonstrates use of spies to intercept and test method calls
#  it "tells the current song if the user has made it a favorite", ->
#    spyOn song, "persistFavoriteStatus"
#    player.play song
#    player.makeFavorite()
#    expect(song.persistFavoriteStatus).toHaveBeenCalledWith true
#    return
#
#
#  #demonstrates use of expected exceptions
#  describe "#resume", ->
#    it "should throw an exception if song is already playing", ->
#      player.play song
#      expect(->
#        player.resume()
#        return
#      ).toThrowError "song is already playing"
#      return
#
#    return
#
#  return
