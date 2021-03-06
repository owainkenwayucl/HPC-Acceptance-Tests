#!/bin/bash

set -e

url="http://www.hecbiosim.ac.uk/lammps-benchmarks/send/2-software/10-lammps-bench"

md5="65c3b50b77688611e92fcff330e27e48"
sha1="0d520e86fda2886a5faca4e1d1171a666a35fe4c"

if [ -f downloads/10-lammps-bench ]; then
   echo ">>> Existing download found - using. <<<"
else
   mkdir downloads
   cd downloads

   wget "$url"

   md5sum -c <<< "$md5 10-lammps-bench" 
   sha1sum -c <<< "$sha1 10-lammps-bench"

   cd ..
fi

rm -rf lammps

tar xvf downloads/10-lammps-bench
cp lammps/1400k-atoms/benchmark.in lammps/1400k-atoms/benchmark.in.intel
cd lammps/1400k-atoms

patch < ../../patches/benchmark.in.intel.patch

cp ../../scripts/*.sh .

cd ../..
