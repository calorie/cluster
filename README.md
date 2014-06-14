cluster
=======

[WIP]

## Requirements

- Vagrant
- Docker
- VirtualBox
- ruby, bundler
- curl
- pdsh

## Setup

```
$ . ./script/bootstrap
$ vagrant up nfs --provider=virtualbox
$ vagrant up mpi0 mpi1 --provider=docker
$ ./script/setup_network.sh
```

## Usage

```
$ vagrant ssh mpi0
$ cp /usr/local/src/mpispec/sample /data/
$ cd /data/sample
$ mpispec -np 3 --allow-run-as-root --hostfile /data/hostfile
```
