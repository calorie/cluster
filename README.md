cluster
=======

```
$ export DOCKER_HOST=tcp://127.0.0.1:4243
$ export VAGRANT_DEFAULT_PROVIDER=docker
$ curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
$ chmod 600 insecure_key
$ bundle install --path vendor/bundle --binstubs .bundle/bin
$ cd mpi_client/chef-repo
$ berks vendor cookbooks
$ cd ../..
$ vagrant up mpi_client --provider=docker
```
