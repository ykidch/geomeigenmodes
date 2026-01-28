#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: ./1_fmriprep.sh <subj>  #e.g. if subject is sub-001, write only 001 as input"
else
	subj=$1
	module load load_rhel7_apps
	module load singularity/4.1.0
	singularity run --cleanenv fmriprepv24.1.1_singv4.1.0.simg --output-spaces MNI152NLin6Asym fsaverage5 --fs-license-file freesurfer_license.txt bids/ out/ participant --participant-label $subj -w work/
fi

