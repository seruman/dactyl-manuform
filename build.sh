#!/bin/bash
set -e
set -x
OPENSCADBIN="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

 __build() {
    local scad_files=$(ls things/*.scad)

    for filename in $scad_files; do
        local base=$(basename $filename)
        local name="${base%.*}"
        local stfilepath=stlfiles/$name.stl
        echo "Exporting $filename to $stfilepath"
        $OPENSCADBIN -o $stfilepath $filename &
    done
    wait < <(jobs -p)
}

__build
