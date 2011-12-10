class World

  defaults = {
    size: 50,
    fgColor: '#00c618',
    cellSize: 10,
    initialDensity: 0.2,
    canvas: 'life-canvas',
    resize: true
  }

  constructor: (options) ->
    @options = $.extend {}, defaults, options
    if @options.resize
      $(window).resize =>
        @resize()
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
        other_row = coord_row + row
        continue if other_row < 0 or other_row >= @options.size
        for col in [-1..1]
          other_col = coord_col + col
          continue if other_col < 0 or other_col >= @options.size
          other_coord = [coord_row+row,coord_col+col]
          all_coords[other_coord] = other_coord
    all_coords

  get_all_living: ->
    living_list = []
    for coord of @living
      living_list.push(coord)
    living_list

  draw: ->
    canvas = document.getElementById @options.canvasId
    canvas.width = canvas.width
    context = canvas.getContext '2d'

    context.fillStyle = @options.fgColor

    cellSize = 1.0 * canvas.width / @options.size
    for coord of @living
      [row, col] = @living[coord]
      context.beginPath()
      context.rect(row*cellSize, col*cellSize, cellSize, cellSize)
      context.fill()

  randomize: ->
    living_cells = parseInt(@options.size * @options.size * @options.initialDensity)
    @living = {}
    for _ in [0..living_cells]
      row = parseInt(Math.random() * @options.size)
      col = parseInt(Math.random() * @options.size)
      @add_living_at([row, col])

  start: ->
    @resize()
    @randomize()
    @draw()

    window.setInterval ->
      world.evolve()
      world.draw()
    , 500

  resize: ->
    canvas = document.getElementById @options.canvasId
    $canvas = $(canvas)
    width = Math.min window.innerWidth - 20, 500

    topPadding = $canvas.offset().top + 10
    height = Math.min window.innerHeight - topPadding, 500
    size = Math.min width, height

    canvas.width = size
    canvas.height = size
    @draw()
