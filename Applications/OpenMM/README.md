# OpenMM benchmark

This OpenMM benchmark is based on the same benchmark as the 1400k atom HPC-UK GROMACS benchmark.

## Instructions

1. Install OpenMM.

2. Get the NAMD version of the benchmark here: http://www.hecbiosim.ac.uk/benchmarks.

3. Copy the files from the 1400k folder into this one.

4. Get the CHARMM27 topology file from the MacKerell labs website (http://mackerell.umaryland.edu/charmm_ff.shtml).  The version you want is in  `toppar_c35b2_c36a2.tgz`.

5. Run `python3 openmm-bench.py` or `python3 openmm-bench-gpu.py` for GPU benchmarks (or submit the equivalent job scripts).