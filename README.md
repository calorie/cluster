cluster
=======

[WIP]

## Requirements

- Vagrant
- Docker
- VirtualBox
- ruby, bundler
- pdsh

## Setup

```
$ bundle install
$ cluster init
```

## Usage

```
$ cluster up
$ vagrant ssh mpi0
$ cp /usr/local/src/mpispec/sample /data/
$ cd /data/sample
$ mpispec -np 3 --allow-run-as-root --hostfile /data/hostfile
```

```
$ cluster halt
```
