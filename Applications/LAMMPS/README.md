# LAMMPS acceptance test

**NOTE** - The following files in this directory are provided under the GPL (see `GPL`) as they are part of or derivatives of part of LAMMPS:

 * `data.rhodo` - LAMMPS rhodospin benchmark data
 * `in.rhodo` - LAMMPS rhodospin benchmark input file
 * `in.rhodo.scaled` - example LAMMPS rhodospin benchmark input file
 * `in.rhodo.at` - example scaled for running single node on Myriad
 * `GPL` - the license
 * `README.md` - this document

The goals of this acceptance test are:

 1. The service must successfully run LAMMPS.
 
 2. To provide a specimen code to run across the whole cluster to estimate power consumption under a normal load.

## Instructions

Clone this repo.

In the folder there are a bunch of files called `in.*`.  The ones we care about are `in.rhodo.scaled`.  Copy this and take a look at it:

```
# Rhodopsin model

variable	x index 1
variable	y index 1
variable	z index 1

units           real  
neigh_modify    delay 5 every 1   

atom_style      full  
atom_modify	map hash
bond_style      harmonic 
angle_style     charmm 
dihedral_style  charmm 
improper_style  harmonic 
pair_style      lj/charmm/coul/long 8.0 10.0 
pair_modify     mix arithmetic 
kspace_style    pppm 1e-4 

read_data       data.rhodo

replicate	$x $y $z

fix             1 all shake 0.0001 5 0 m 1.0 a 232
fix             2 all npt temp 300.0 300.0 100.0 &
		z 0.0 0.0 1000.0 mtk no pchain 0 tchain 1

special_bonds   charmm
 
thermo          50
thermo_style    multi 
timestep        2.0

run		100
```

There are four lines we want to adjust to select how big the job is in both size (number of atoms) and time-steps, and therefore scaling and time.

These are:

```
variable	x index 1
variable	y index 1
variable	z index 1
```

And:

```
run		100
```

The x,y,z variables set how many times the benchmark set of atoms is replicated in the x,y,z directions.  The run line selects how many time-steps the job runs for.

So, for example,

```
variable	x index 2
variable	y index 1
variable	z index 1
```

Replicates the system in the x direction and, making it double the size of the default system.  If we modify the `run 100` line to `run 200` it will run for 200 time-steps instead of 100.

The goal is to construct a test for a particular machine so that it creates approximately 12 hour jobs at a sensible size for the service model, fill up the service with them for 24 hours and make sure they all run properly (and also on the datacentre side measure power drain if that's an acceptence test).

**For Myriad, this should be one node per job!**

The job script looks for Grace like this (adjust number of cores for Myriad):

```bash
#!/bin/bash -l
#$ -S /bin/bash
#$ -l h_rt=12:0:0
#$ -l mem=1G
#$ -N lammps-12hr
#$ -cwd
#$ -pe mpi 64

# Assuming you have the default modules loaded!
module load lammps/16Mar18/basic/intel-2018

gerun lmp_default -in in.rhodo.12h -log 12.log.$JOB_ID
```

For 64 cores on Grace, appropriate values are:

| Variable | Value |
| ------- | ----- |
| x        | 10   |
| y        | 10   |
| z        | 5     |
| run | 120000 |

If you look at the files `at.sh` and `in.rhodo.at` you will see a suitable example for Myriad.

Time per timestep should relatively constant so you can estimate how many time-steps you need to run for to fill the 12 hours from a shorter job.
