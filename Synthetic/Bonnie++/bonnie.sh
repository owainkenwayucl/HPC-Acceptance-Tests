#!/bin/bash

export I_MPI_FABRICS=shm:tmi ; mpirun -n 1 -ppn 1 -hostfile /home/ccaathj/node-list-accross_CUs.txt   -iface ib0 /home/ccaathj/bonnie++-1.03a/bonnie++ -f -s1g -d /scratch/scratch/ccaathj/
