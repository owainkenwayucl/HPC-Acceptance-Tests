#!/bin/bash -l

#$ -N OpenMM_Bench
#$ -cwd
#$ -pe smp 4
#$ -l mem=10G
#$ -l h_rt=48:00:00

module load python/3.6.3
module load compilers/gnu/4.9.2
module load swig/3.0.5/gnu-4.9.2
module load fftw/3.3.4-threads/gnu-4.9.2
module load openmm/7.3.1/gnu-4.9.2
module load parmed/3.2.0

export OPENMM_CPU_THREADS=$OMP_NUM_THREADS

echo "$OPENMM_CPU_THREADS threads."

date

python3 openmm-bench.py

date
