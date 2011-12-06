class World
  constructor: ->
    @living = {}
    
  #coord example: 1,2
  add_living_at: (coord) ->
    @living[coord] = true
    
  is_living_at: (coord) ->
    @living[coord]?
    
  evolve_cell: (coord) ->
    living = @_count_surrounding_living(coord)
    (living is 3) or (living is 2 and @is_living_at(coord))
    
  _count_surrounding_living: (coord) ->
    living_count = 0
    for x in [-1..1]
      for y in [-1..1]
        continue if x is 0 and y is 0
        living_count += 1 if @is_living_at([x,y])
    living_count
        
        
#w = new World()
#w.add_living_at([1,1])
#alert(w._count_surrounding_living([1,1]))

#w.add_living_at([1,2])
#w.add_living_at([2,1])
#w.add_living_at([2,2])
#alert(w._count_surrounding_living([1,1]))

    
    
    
  
  
