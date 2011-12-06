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

  draw: (canvasId) ->
    canvas = document.getElementById canvasId
    canvas.width = canvas.width
    context = canvas.getContext '2d'

    context.fillStyle = '#444'
    context.strokeStyle = 'black'
    context.lineWidth = '1'
    cell_height = 10
    cell_width = 10

    min_row = 0
    min_col = 0
    max_row = 0
    max_col = 0

    for coord of @living
      [row, col] = @living[coord]
      min_row = row if row < min_row
      min_col = col if col < min_col
      max_row = row if row > max_row
      max_col = col if col > max_col

    for coord of @living
      [row, col] = @living[coord]
      console.log "drawing (#{row}, #{col})"
      context.beginPath()
      context.rect((row-min_row)*cell_height, (col-min_col)*cell_width, cell_width, cell_height)
      context.fill()
      context.stroke()

  randomize: (living_cells = 50)->
    for _ in [0..living_cells]
      row = parseInt(Math.random() * 20)
      col = parseInt(Math.random() * 20)
      @add_living_at([row, col])
        
#w = new World()
#w.add_living_at([1,1])
#alert(w._count_surrounding_living([1,1]))

#w.add_living_at([1,2])
#w.add_living_at([2,1])
#w.add_living_at([2,2])
#alert(w._count_surrounding_living([1,1]))

    
    
    
  
  
