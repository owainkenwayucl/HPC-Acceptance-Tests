#!/bin/bash

set -e

url="http://www.hecbiosim.ac.uk/lammps-benchmarks/send/2-software/10-lammps-bench"

md5="65c3b50b77688611e92fcff330e27e48"
sha1="0d520e86fda2886a5faca4e1d1171a666a35fe4c"

wget "$url"

md5sum -c <<< "$md5 10-lammps-bench" 
sha1sum -c <<< "$sha1 10-lammps-bench"

tar xvf 10-lammps-bench

