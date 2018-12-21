#!/bin/bash

if [[ "$#" -gt 0 ]]; then
    cat <<EOF
Usage: ./build-potcar.sh

Puts together a POTCAR file for this benchmark

Requires the top level directory of the VASP PW91 PSPs

This can be set as the env variable VASP_PSP_PW91_DIR or
 supplied to stdin at runtime.

EOF
exit 1
fi


set -o errexit \
    -o nounset \
    -o pipefail

function error () {
    echo "Error: $2" >&2
    exit "$1"
}

# An array of the psps we need
psp_list=("Ti_pv" "O")

# Check for a POTCAR file, if there isn't one we have to make it
if [[ ! -s "POTCAR" ]]; then
    if [[ -z "${VASP_PSP_PW91_DIR:-}" ]]; then
        echo "Variable VASP_PSP_PW91_DIR not set."
        read -p "Please enter path to the VASP PW91 pseudopotentials directory (%=cwd): " psps_dir
        psps_dir="${psps_dir//%/$(pwd)}"
    else
        psps_dir="$VASP_POTCAR_PW91_DIR"
    fi

    if [[ ! -r "$psps_dir/Ti_pv/POTCAR.Z" ]] || [[ ! -r "$psps_dir/O/POTCAR.Z" ]]; then
        error 3 "Could not find pseudopotentials in specified directory: $psps_dir" >&2
    else
        :>POTCAR
        for psp in "${psp_list[@]}"; do
            zcat "$psps_dir/$psp/POTCAR" >>POTCAR
        done
    fi
fi
