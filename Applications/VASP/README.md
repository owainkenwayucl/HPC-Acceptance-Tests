# VASP Benchmark

This provides a calculation intended to demonstrate approximate performance and scaling relative to known clusters for the VASP application.


## Instructions for Use

1. Because of licensing issues, we may not be able to provide a `POTCAR` input file. Download VASP's PW91 PSP bundle, `potpaw_GGA.tar.gz`, unpack it into a directory, and run `./build-potcar.sh` in the benchmark directory to prepare the `POTCAR` file for the benchmark. (NB: `potpaw_GGA.tar.gz` is a tar-bomb.)
1. Make a copy of the `INCAR.template` file, replacing the `NCORE` value with the number of cores per node. You may also wish to increase the value of `NSW` (from 10) to give a longer sample -- output values are based on time per iteration so it shouldn't affect the results.
1. Prepare a job script to run VASP. If you call it `job.sh`, you can use the `run.sh` script to prepare a labelled sub-directory with copies of that and the VASP input files in. `job.grace.sh` contains an example which runs on the Grace cluster and was used to prepare the data below.
1. Run VASP on a range of core counts.
1. Run `prepare_output.sh` passing every `OUTCAR` file as an argument -- it prints a CSV to stdout.

Warning: `prepare_output.sh` will only accept one OUTCAR per core count -- subsequent entries for the same core count will be overwritten.

All timings are in seconds. 

Example data taken from our Grace cluster:

cores|cores\_per\_band|total\_time|mean\_el\_loop\_time|total\_el\_steps|mean\_geo\_loop\_time|total\_geo\_steps|min\_el\_loop\_time|max\_el\_loop\_time|last\_energy
-----|----------------|-----------|--------------------|----------------|---------------------|-----------------|-------------------|-------------------|------------
64|16|28107.986|391.006|57|1034.35|10|265.5471|557.1389|-9641.90580032
128|16|14712.256|202.873|57|1436.65|10|138.8446|286.2712|-9641.90580034
256|16|8310.697|114.131|57|797.559|10|82.0328|154.9972|-9641.90580037
512|16|6006.947|83.6594|57|560.664|10|56.6392|135.3589|-9641.90580037
1024|16|4917.756|64.4961|56|418.48|10|54.1285|75.6296|-9641.90580036

At UCL, the most recent version of VASP deployed on our services is 5.4.4.