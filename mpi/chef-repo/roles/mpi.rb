name 'mpi'
description 'computing node'
run_list(
  'recipe[apt]',
  'recipe[openmpi]'
)
