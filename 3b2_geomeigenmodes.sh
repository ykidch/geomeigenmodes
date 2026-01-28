#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: ./3b2_geomeigenmodes.sh <subj> #e.g. if subject is sub-001, write sub-001 as input"
else

	N=200 #number of eigenmodes
	outdir=geomeigenmodes2/$1
	mkdir -p ${outdir}
	python surface_eigenmodes.py surf2/$1/surf/lh.fsavg5.pial.surf.vtk ${outdir}/lh.pial_evals.txt ${outdir}/lh.pial_emodes.txt -N ${N} -is_mask 0 #change the is_mask later!
	python surface_eigenmodes.py surf2/$1/surf/rh.fsavg5.pial.surf.vtk ${outdir}/rh.pial_evals.txt ${outdir}/rh.pial_emodes.txt -N ${N} -is_mask 0 


fi
