name 'mpi'
description 'computing node'
run_list(
  'recipe[apt]',
  'recipe[git]',
  'recipe[gitconfig]',
  'recipe[openmpi]',
  'recipe[mpispec]'
)
