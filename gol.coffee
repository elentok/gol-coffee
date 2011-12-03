class World
  constructor: ->
    @living = {}
    
  #coord example: 1,2
  add_living_at: (coord) ->
    @living[coord] = true
    
  is_living_at: (coord) ->
    @living[coord]
    
  evolve_cell: (coord) ->
    living = _get_surrounding_living(coord)
    (living == 3) or (living == 2 and is_living_at(coord))
    
  _get_surrounding_living: (coord) ->
    surrounding = @_get_surrounding_coords(coord)
    living_count = 0
    for cell_coord in surrounding
      living_count += 1 if @is_living_at(coord)
    living_count
    
  _get_surrounding_coords: (coord) ->
    coords = []
    for x in [-1..1]
      for y in [-1..1]
        coords.push([x,y]) if (x != 0 and y != 0)
        
        
w = new World()
w.add_living_at([1,1])
alert(w._get_surrounding_living([1,1]))

w.add_living_at([1,2])
w.add_living_at([2,1])
w.add_living_at([2,2])
alert(w._get_surrounding_living([1,1]))

    
    
    
  
  