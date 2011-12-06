class World
  constructor: ->
    @living = {}
    
  #coord example: 1,2
  add_living_at: (coord) ->
    @living[coord] = coord
    
  is_living_at: (coord) ->
    @living[coord]?
    
  evolve_cell: (coord) ->
    living = @_count_surrounding_living(coord)
    (living is 3) or (living is 2 and @is_living_at(coord))
    
  _count_surrounding_living: (coord) ->
    [coord_row, coord_col] = coord
    living_count = 0
    for row in [-1..1]
      for col in [-1..1]
        continue if row is 0 and col is 0
        living_count += 1 if @is_living_at([coord_row + row, coord_col + col])
    living_count
        
  evolve: ->
    next_living = {}
    all_coords = @_get_all_coords_to_test()
    for coord of all_coords
      c = all_coords[coord]
      next_living[c] = c if @evolve_cell(c)
    @living = next_living

  _get_all_coords_to_test: ->
    all_coords = {}
    for coord of @living
      [coord_row, coord_col] = @living[coord]
      for row in [-1..1]
        for col in [-1..1]
          test_coord = [coord_row+row,coord_col+col]
          all_coords[test_coord] = test_coord
    all_coords

  get_all_living: ->
    living_list = []
    for coord of @living
      living_list.push(coord)
    living_list
        
#w = new World()
#w.add_living_at([1,1])
#alert(w._count_surrounding_living([1,1]))

#w.add_living_at([1,2])
#w.add_living_at([2,1])
#w.add_living_at([2,2])
#alert(w._count_surrounding_living([1,1]))

    
    
    
  
  
