#!/bin/bash -l
#$-pe mpi 32
#$-cwd
#$-l h_rt=12:00:00
#$-l memory=3700M
module purge
module load gcc-libs/4.9.2
module load compilers/intel/2017/update4
module load mpi/intel/2017/update3/intel
module load vasp/5.4.4-18apr2017/intel-2017-update1

cat >"vasp_wrapper.$JOB_ID" <<EOF
#!/bin/bash

# This is required to work around stack size limit on our clusters
# VASP appears to allocate vast arrays on the stack so if you have
#  a stack size limit it'll probably segfault
ulimit -s unlimited
exec vasp_gam
EOF

chmod +x "vasp_wrapper.$JOB_ID"

gerun "./vasp_wrapper.$JOB_ID"
