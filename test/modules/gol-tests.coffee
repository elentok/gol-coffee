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

test "evolve_cell empty cell with 5 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  world.add_living_at([-1,0])
  world.add_living_at([-1,-1])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

# Live cell

test "evolve_cell live cell with 0 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,0])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve_cell live cell with 1 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,0])
  world.add_living_at([0,1])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve_cell live cell with 2 surrounding living should return True", ->
  world = new World()
  world.add_living_at([0,0])
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  next_step = world.evolve_cell [0,0]
  ok next_step

test "evolve_cell live cell with 3 surrounding living should return True", ->
  world = new World()
  world.add_living_at([0,0])
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  next_step = world.evolve_cell [0,0]
  ok next_step

test "evolve_cell live cell with 4 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,0])
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  world.add_living_at([-1,0])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve_cell live cell with 5 surrounding living should return False", ->
  world = new World()
  world.add_living_at([0,0])
  world.add_living_at([0,1])
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  world.add_living_at([-1,0])
  world.add_living_at([-1,-1])
  next_step = world.evolve_cell [0,0]
  strictEqual next_step, false

test "evolve horizontal blinker becomes vertical blinker", ->
  world = new World()
  world.add_living_at([1,0])
  world.add_living_at([1,1])
  world.add_living_at([1,2])
  world.evolve()
  expected = ["0,1", "1,1", "2,1"]
  deepEqual world.get_all_living(), expected

test "evolve vertical blinker becomes horizontal blinker", ->
  world = new World()
  world.add_living_at([0,1])
  world.add_living_at([1,1])
  world.add_living_at([2,1])
  world.evolve()
  expected = ["1,0", "1,1", "1,2"]
  deepEqual world.get_all_living(), expected

test "evolve block remains block", ->
  world = new World()
  world.add_living_at([1,1])
  world.add_living_at([1,2])
  world.add_living_at([2,1])
  world.add_living_at([2,2])
  world.evolve()
  expected = ["1,1", "1,2", "2,1", "2,2"]
  deepEqual world.get_all_living(), expected

test "evolve toad #1 becomes toad #2", ->
  world = new World()
  world.add_living_at([2,2])
  world.add_living_at([2,3])
  world.add_living_at([2,4])
  world.add_living_at([3,1])
  world.add_living_at([3,2])
  world.add_living_at([3,3])
  world.evolve()
  expected = ["1,3", "2,1", "3,1", "2,4", "3,4", "4,2"]
  deepEqual world.get_all_living(), expected

test "evolve toad #2 becomes toad #1", ->
  world = new World()
  world.add_living_at([1,3])
  world.add_living_at([2,1])
  world.add_living_at([3,1])
  world.add_living_at([2,4])
  world.add_living_at([3,4])
  world.add_living_at([4,2])
  world.evolve()
  expected = ["2,2", "2,3", "2,4", "3,1", "3,2", "3,3"]
  deepEqual world.get_all_living(), expected

