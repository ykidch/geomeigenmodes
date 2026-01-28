#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: ./register_3.sh <subject no.> <lh or rh>"
	exit 1
else
	SUBJ=$1
	HEMI=$2

	FSFOLDER=$SUBJ/T1w/$SUBJ
	DWFOLDER=$SUBJ/T1w/Diffusion



	# will need to do this locally!

	# register sphere to fsaverage5 (will still have original no of vertices)
	# surfer.nmr.mgh.harvard.edu/fswiki/SurfaceRegAndTemplates
	mris_register -curv $FSFOLDER/surf/$HEMI.sphere fsaverage5/$HEMI.reg.template.tif $SUBJ/derivatives/$HEMI.sphere.reg.fsaverage5

	# convert spheres to gii for wb_command use
	mris_convert $FSFOLDER/surf/$HEMI.sphere $SUBJ/derivatives/$HEMI.sphere.gii
	mris_convert $SUBJ/derivatives/$HEMI.sphere.reg.fsaverage5 $SUBJ/derivatives/$HEMI.sphere.reg.fsaverage5.gii
	mris_convert fsaverage5/surf/$HEMI.sphere fsaverage5/surf/$HEMI.sphere.gii

	# downsample the surface
	wb_command -surface-resample $FSFOLDER/surf/$HEMI.white.surf.gii $SUBJ/derivatives/$HEMI.sphere.reg.fsaverage5.gii fsaverage5/surf/$HEMI.sphere.gii BARYCENTRIC $SUBJ/derivatives/$HEMI.fsavg5.white.surf.gii
fi

