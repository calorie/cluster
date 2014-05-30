name 'mpi_client'
description 'mpi client'
run_list(
  'recipe[apt]',
  'recipe[git]',
  'recipe[gitconfig]',
  'recipe[openmpi]',
  'recipe[mpispec]'
)
