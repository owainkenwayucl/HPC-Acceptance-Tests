#!/usr/bin/env bash

# Script to submit multiple jobs to fill the machine,
# Invoke with ./fill.sh <jobscript> <number>

if [ $# -ne 2 ] 
then
  echo "Invoke with ./fill.sh <jobscript> <number>"
  exit 1
fi

for a in $( seq 1 $2 )
do
  qsub $1
done
