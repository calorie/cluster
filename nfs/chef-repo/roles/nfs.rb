name 'nfs'
description 'nfs server'
run_list(
  'recipe[apt]',
  'recipe[sudo]',
  'recipe[nfs_server]'
)
