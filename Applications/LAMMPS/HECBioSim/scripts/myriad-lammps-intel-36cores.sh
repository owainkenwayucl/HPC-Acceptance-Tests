#!/bin/bash -l

#$ -l h_rt=6:00:00
#$ -l mem=4000M
#$ -cwd
#$ -pe mpi 36

module load default-modules/2018
module load lammps/7Aug19/userintel/intel-2018

export KMP_BLOCKTIME=0
gerun `which lmp_myriad` -pk intel 0 omp 1 -sf intel -in benchmark.in.intel
