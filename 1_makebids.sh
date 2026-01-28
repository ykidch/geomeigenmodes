#!/bin/bash

# select the highest number (if they're 6, 7, select 7)
# if there are more than 2, they probably come in pairs e.g. 6,7,28,29 - select
# the highest number of the lowest pair

# T1
for subj in $(ls -d raw/T1/UNI* | cut -d'/' -f3); do

	file=sub-${subj}
	newfile=$(echo $file | sed -E 's/([0-9]{3})_([0-9]{8})/\1\2/')

# make bids directory for the subject if not there
	if [ ! -d bids/${newfile} ]; then
		mkdir -p bids/${newfile}/anat;
		mkdir -p bids/${newfile}/ses-pre/func;
		mkdir -p bids/${newfile}/ses-post/func;
	fi
	num=$(ls -d raw/T1/${subj}/*/ | cut -d'/' -f4 | sort -n | sed -n '2p')
	echo "Copying sub-${subj}_T1w.nii"
	cp raw/T1/${subj}/${num}/DICOM/*[0-9].nii bids/${newfile}/anat/${newfile}_T1w.nii                                
	cp raw/T1/${subj}/${num}/DICOM/*[0-9].json bids/${newfile}/anat/${newfile}_T1w.json
done

#T2
for subj in $(ls -d raw/T2/UNI* | cut -d'/' -f3); do
	file=sub-${subj}
	newfile=$(echo $file | sed -E 's/([0-9]{3})_([0-9]{8})/\1\2/')

# make bids directory for the subject if not there
	if [ ! -d bids/${newfile} ]; then
		mkdir -p bids/${newfile}/anat;
		mkdir -p bids/${newfile}/ses-pre/func;
		mkdir -p bids/${newfile}/ses-post/func;
	fi
	num=$(ls -d raw/T2/${subj}/*/ | cut -d'/' -f4 | sort -n | sed -n '2p')	
	echo "Copying sub-${subj}_T2w.nii"
	cp raw/T2/${subj}/${num}/DICOM/*[0-9].nii bids/${newfile}/anat/${newfile}_T2w.nii                                
	cp raw/T2/${subj}/${num}/DICOM/*[0-9].json bids/${newfile}/anat/${newfile}_T2w.json
done

#fMRI_PRE
for subj in $(ls -d raw/fMRI_PRE/UNI* | cut -d'/' -f3); do
	file=sub-${subj}
	newfile=$(echo $file | sed -E 's/([0-9]{3})_([0-9]{8})/\1\2/')
# make bids directory for the subject if not there
	if [ ! -d bids/${newfile} ]; then
		mkdir -p bids/${newfile}/anat;
		mkdir -p bids/${newfile}/ses-pre/func;
		mkdir -p bids/${newfile}/ses-post/func;
	fi
	echo "Copying sub-${subj}_ses-pre_task-rest_bold.nii"
	cp raw/fMRI_PRE/${subj}/*/DICOM/*[0-9].nii bids/${newfile}/ses-pre/func/${newfile}_ses-pre_task-rest_bold.nii                                	
	cp raw/fMRI_PRE/${subj}/*/DICOM/*[0-9].json bids/${newfile}/ses-pre/func/${newfile}_ses-pre_task-rest_bold.json                                
done

#fMRI_POST
for subj in $(ls -d raw/fMRI_POST/UNI* | cut -d'/' -f3); do
	file=sub-${subj}
	newfile=$(echo $file | sed -E 's/([0-9]{3})_([0-9]{8})/\1\2/')
# make bids directory for the subject if not there
	if [ ! -d bids/${newfile} ]; then
		mkdir -p bids/${newfile}/anat;
		mkdir -p bids/${newfile}/ses-pre/func;
		mkdir -p bids/${newfile}/ses-post/func;
	fi
	echo "Copying sub-${subj}_ses-post_task-rest_bold.nii"
	cp raw/fMRI_POST/${subj}/*/DICOM/*[0-9].nii bids/${newfile}/ses-post/func/${newfile}_ses-post_task-rest_bold.nii                                	
	cp raw/fMRI_POST/${subj}/*/DICOM/*[0-9].json bids/${newfile}/ses-post/func/${newfile}_ses-post_task-rest_bold.json                                
done
                                                                  
