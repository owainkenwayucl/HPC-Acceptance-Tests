#!/bin/bash

read -p "Enter label: " label
rundir="run.$label"
mkdir "$rundir"

date +%s>"$rundir/submit.timestamp"
date    >"$rundir/submit.humantime"

cp {INCAR,KPOINTS,POTCAR,POSCAR,job.sh} "$rundir/"
cd "$rundir" && qsub job.sh
