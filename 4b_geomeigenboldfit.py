#!/usr/bin/env python

import pickle
import numpy as np
import os
import nibabel as nib
import sys
import matplotlib.pyplot as plt
#from nilearn import plotting
#from nilearn import surface

#Usage: 4b_geomeigenboldfit.py <subject> <pre or post> #e.g if subject is sub-001, <subject> must only be 001
#define directories

SUB = 'sub-'+sys.argv[1]
PRE_POST = sys.argv[2]
FUNC = os.path.join('out',SUB,'ses-'+PRE_POST,'func')

#load bold
lh_bold_gii_name = os.path.join(FUNC,SUB+'_ses-'+PRE_POST+'_task-rest_hemi-'+'L'+'_space-fsaverage5_bold.func.gii')
lh_bold_gii = nib.load(lh_bold_gii_name)
lh_bold = lh_bold_gii.agg_data()
rh_bold_gii_name = os.path.join(FUNC,SUB+'_ses-'+PRE_POST+'_task-rest_hemi-'+'R'+'_space-fsaverage5_bold.func.gii')
rh_bold_gii = nib.load(rh_bold_gii_name)
rh_bold = rh_bold_gii.agg_data()
bold_data = np.concatenate([lh_bold,rh_bold], axis=0)

l_emodes = np.loadtxt(os.path.join('geomeigenmodes2',SUB,'lh.pial_emodes.txt'))
r_emodes = np.loadtxt(os.path.join('geomeigenmodes2',SUB,'rh.pial_emodes.txt'))
emodes = np.concatenate([l_emodes,r_emodes],axis=0)
emodes = emodes.T
#normalize data across all vertices, all timepoints
bold_data_normalized = (bold_data - np.mean(bold_data))/np.std(bold_data)

GED = emodes @ bold_data_normalized #200xnoTR, rows are timepoints, columns are harmonic contributions
GED_filename = os.path.join('GED',SUB+'_ses-'+PRE_POST+'_GED.pkl')

#save it
with open(GED_filename,'wb') as f:
    pickle.dump(GED,f)

print("Saved GED for "+SUB+' '+PRE_POST)
