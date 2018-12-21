#!/bin/bash -l

set -o errexit \
    -o nounset \
    -o pipefail

if [[ "$#" -eq 0 ]]; then
    echo "Please supply one or more OUTCAR files as arguments." >&2
    exit 3
fi

if [[ "$#" -eq 1 ]] && [[ "$1" == "-h" ]]; then
   echo "Usage: $0 [outcar file [outcar file]]"
   echo ""
   echo "Prepares CSV output from one or more OUTCAR files."
   echo ""
   exit 0
fi

gawk '
    BEGIN {
        # Print the CSV header
        print ("cores,cores_per_band,total_time,mean_el_loop_time,total_el_steps,mean_geo_loop_time,total_geo_steps,min_el_loop_time,max_el_loop_time,last_energy")
    }

    BEGINFILE {
        # Reset all the per-file variables
        cores = 0
        cores_per_band = 0
        total_time = 0
        mean_el_loop_time_sum = 0
        mean_geo_loop_time_sum = 0
        total_el_steps = 0
        total_geo_steps = 0
        max_el_loop_time = 0
        min_el_loop_time = 1e16
        last_energy = 0
    }

    ENDFILE {
        # Work out means from sum and loop count
        mean_el_loop_time = mean_el_loop_time_sum / total_el_steps
        mean_geo_loop_time = mean_geo_loop_time_sum / total_geo_steps

        # Copy the per-file stats to a buffer so we can sort them by core count at the end
        sort_buffer[cores] = ( cores "," cores_per_band "," total_time "," mean_el_loop_time "," total_el_steps "," mean_geo_loop_time "," total_geo_steps "," min_el_loop_time "," max_el_loop_time "," last_energy )
    }

    END {
        num_entries = asorti(sort_buffer, sorted_indices, "@ind_num_asc")
        for (i=1;i<=num_entries;i++) {
            print(sort_buffer[sorted_indices[i]])
        }
    }

    /running on  *[0-9][0-9]* total cores/ {
        cores = $3
    }

    /distr:  one band on NCORES_PER_BAND=/ {
        # Example line:
        #  distr:  one band on NCORES_PER_BAND=  16 cores,   64 groups
        cores_per_band = $6
    }

    /Iteration      / {
        geo_step = $3
        el_step = $4
    }

    /LOOP:  cpu time/ {
        # After each electronic relaxation step
        # Example:
        # LOOP:  cpu time   17.9179: real time   18.0743
        total_el_steps++
        el_time = $7
        mean_el_loop_time_sum += el_time
        if (el_time < min_el_loop_time) {
            min_el_loop_time = el_time
        }
        if (el_time > max_el_loop_time) {
            max_el_loop_time = el_time
        }
    }

    /LOOP[+]:  cpu time/ {
        # After each ionic geometry relaxation step
        # Example:
        # LOOP+:  cpu time   53.6613: real time   54.1013
        total_geo_steps++
        geo_time = $7
        mean_geo_loop_time_sum += geo_time
    }

    /Total CPU time used/ {
        # Final timing output
        # Example
        # Total CPU time used (sec):     1480.406
        total_time = $6
    }

    /free  energy   TOTEN  =/ {
        # Energy result for cursory sanity check
        # Example
        # free  energy   TOTEN  =     -4820.80869428 eV
        last_energy = $5
    }

#
#    POTLOK:  cpu time    0.2718: real time    0.2820
#    SETDIJ:  cpu time    0.0564: real time    0.0564
#    EDDIAG:  cpu time   11.7947: real time   11.9195
#  RMM-DIIS:  cpu time    3.3654: real time    3.3678
#    ORTHCH:  cpu time    3.0310: real time    3.0329
#       DOS:  cpu time    0.0011: real time    0.0015
#    --------------------------------------------
#      LOOP:  cpu time   18.5204: real time   18.6600
' "$@"
