#!/bin/bash -l

# Job script for running LAMMPS as an acceptance test on UCL software stack.
# Owain Kenway

#$ -S /bin/bash

#$ -l h_rt=12:0:0

#$ -l mem=1G

#$ -N lammps-12hr

#$ -cwd

# Modify following according to what is suitable for this architecture.
#$ -pe mpi 160

#$ -l threads=1

# You need to amend the next two lines for your account.
#$ -A Test_allocation 
#$ -P Free

module load rcps-core/1.0.0
module load compilers/intel/2018
module load mpi/intel/2018
# module load lammps/7Aug19/userintel/intel-2018
module load lammps/7Aug19/userintel/intel-2018 # Intel optimised alternative

export OMP_NUM_THREADS=2

#gerun  lmp_default -in in.rhodo.at.kathleen -log log.at.$JOB_ID
gerun  lmp_default -sf intel -in in.rhodo.at.kathleen -log log.at.$JOB_ID # Intel optimised alternative
