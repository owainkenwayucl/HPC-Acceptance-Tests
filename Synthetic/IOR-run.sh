#!/bin/bash

# Simple script to run IOR increasing the number of nodes and block size:
echo "BLOCK 16G:"
for NN in 1 2 4 8 12 20 24 28 32 36 40 44 48 52 56 60 64 68; do export I_MPI_FABRICS=shm:tmi ; mpirun -n $NN -ppn 2 -hostfile /home/ccaathj/node-list-accross_CUs.txt   -iface ib0 /home/ccaathj/IOR/IOR -a POSIX -r -w -b16g -t 1m -o /scratch/scratch/ccaathj/io-test -v -i 1 -F | tee -a /home/ccaathj/iozone_report.txt; done

echo "BLOCK 32G:"
for NN in 1 2 4 8 12 20 24 28 32 36 40 44 48 52 56 60 64 68; do export I_MPI_FABRICS=shm:tmi ; mpirun -n $NN -ppn 2 -hostfile /home/ccaathj/node-list-accross_CUs.txt   -iface ib0 /home/ccaathj/IOR/IOR -a POSIX -r -w -b32g -t 1m -o /scratch/scratch/ccaathj/io-test -v -i 1 -F | tee -a /home/ccaathj/iozone_report.txt; done

echo "BLOCK 64G:"
for NN in 1 2 4 8 12 20 24 28 32 36 40 44 48 52 56 60 64 68; do export I_MPI_FABRICS=shm:tmi ; mpirun -n $NN -ppn 2 -hostfile /home/ccaathj/node-list-accross_CUs.txt   -iface ib0 /home/ccaathj/IOR/IOR -a POSIX -r -w -b64g -t 1m -o /scratch/scratch/ccaathj/io-test -v -i 1 -F | tee -a /home/ccaathj/iozone_report.txt; done
