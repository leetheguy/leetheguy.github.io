describe "Room", ->
  point = null
  room  = null

  beforeEach ->
    point = new cjs.Point(4,2)
    room = new Room(point)
    
  it "creates a new point", ->
    expect(room.coords).toEqual(jasmine.any(cjs.Point))
    expect(room.coords).not.toBe(point)

