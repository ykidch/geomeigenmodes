#subj_list = xml from XNAT download images
cat subj_list | grep -oP 'label: \K[^"]+' | sort > subj_list_UNI #all subjects in XNAT
ls bids | grep sub |  sed 's/sub-\(UNI[0-9]*\)\([0-9]\{8\}\)/\1_\2/' > subj_list_UNI_ls #subjects currently in bids folder

comm subj_list-UNI subj_list_UNI_ls #compare both lists, column 1 subjects not in bids but in XNAT, column 2 subjects in bids but not in XNAT (probably error in XNAT file), column 3 subjects in both

# UNI105_20240829 - no T1 acquired
# UNI128_20241217 - no DICOM, only NIFTI
# UNI131_20241204 - no DICOM, only NIFTI

# UNI053_20231010 - no T2?

ls bids/*/anat/*T1w.nii | sed -n 's|.*sub-\(UNI[0-9]\{3\}\)\([0-9]\{8\}\).*|\1_\2|p' > subj_list_UNI_T1
ls bids/*/anat/*T2w.nii | sed -n 's|.*sub-\(UNI[0-9]\{3\}\)\([0-9]\{8\}\).*|\1_\2|p' > subj_list_UNI_T2
ls bids/*/ses-pre/func/*bold.nii | sed -n 's|.*sub-\(UNI[0-9]\{3\}\)\([0-9]\{8\}\).*|\1_\2|p' > subj_list_UNI_PRE
ls bids/*/ses-post/func/*bold.nii | sed -n 's|.*sub-\(UNI[0-9]\{3\}\)\([0-9]\{8\}\).*|\1_\2|p' > subj_list_UNI_POST
ls -d out/sub*/ |  sed -E 's|.*/sub-(UNI[0-9]{3})([0-9]{8})/|\1_\2|' > subj_list_UNI_fs #completed freesurfer preprocessing
comm subj_list_UNI_PRE subj_list_UNI_fs | cut -f1 | sed '/^$/d' | sed 's/_//'  > subj_list_UNI_needfs  #get subjects which have fMRIPRE but no entry in out/ (missing freesurfer preprocessing)

ls geomeigenmodes/ | sed 's/^sub-//' > subj_list_UNI_geomeigenmodes
comm subj_list_UNI_shformat subj_list_UNI_geomeigenmodes | cut -f1 | sed '/^$/d' > subj_list_UNI_geomeigenmodes_missing

ls GED/ | sed -n 's/^sub-\(UNI[0-9]\{11\}\)_.*$/\1/p' | sort -u > subj_list_UNI_GED
comm subj_list_UNI_shformat subj_list_UNI_GED | cut -f1 | sed '/^$/d' > subj_list_UNI_GED_missing


