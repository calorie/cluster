name 'mpi_client'
description 'mpi client'
run_list(
  'recipe[apt]',
  'recipe[openmpi]',
  'recipe[mpispec]'
)
