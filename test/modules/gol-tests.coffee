module "gol"

test "_count_surrounding_living with 3 surrounding living should return 3", ->
  world = new World()
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  living = world._count_surrounding_living [0,0]
  strictEqual living, 3

test "evolve_cell empty cell with 0 surrounding living should return False", ->
  world = new World()
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve_cell empty cell with 1 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,1])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve_cell empty cell with 2 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve_cell empty cell with 3 surrounding living should return True", ->
  world = new World()
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  next_step = world.evolve_cell [0,0]
  ok next_step

test "evolve_cell empty cell with 4 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  world.add_living_at([-1,0])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve_cell empty cell with 4 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  world.add_living_at([-1,0])
  world.add_living_at([-1,-1])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false
