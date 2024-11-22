#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg


study=NEMO
subjs=$@ # uncomment for processing all subjects
subjs=(01) # uncomment for processing selected subjects EX: subjs=(05 06 07)

# SET THIS TO BE THE PATH TO YOUR BIDS DIRECTORY
EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study


# uncomment these lines below to grab all subjects


pushd $EXPDIR
list_sub=($(ls sub-* -d | cut -d'-' -f 2 ))
popd
pushd $EXPDIR/derivatives/Osprey
list_subd=($(ls sub-*/Reports -d | cut -d'-' -f 2 | cut -d'_' -f 1))
popd
for i in ${list_subd[@]}
do
	list_sub=(${list_sub[@]/$i}) 
done


for sub in ${list_sub[@]}
do
	# voxel L
	mkdir -p $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL
	Osprey_json_template=$EXPDIR/derivatives/Osprey/OspreyJob.json
	cp $Osprey_json_template $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/.

	new_path_filesL=$(echo /Volumes/groupdata/MRI_BIDS_DATABANK/NEMO/sourcedata/sub-${sub}/ses-01/spectro/MrSpec_NEMO_sub-${sub}_ses-01_CPF-L.rda)
	new_path_files_refL=$(echo /Volumes/groupdata/MRI_BIDS_DATABANK/NEMO/sourcedata/sub-${sub}/ses-01/spectro/MrSpec_NEMO_sub-${sub}_ses-01_CPF-L_ssWS.rda)
	new_path_files_nii=$(echo /Volumes/groupdata/MRI_BIDS_DATABANK/NEMO/sub-${sub}/ses-01/anat/sub-${sub}_ses-01_T1w.nii.gz)
	new_path_outputFolderL=$(echo /Volumes/groupdata/MRI_BIDS_DATABANK/NEMO/derivatives/Osprey/sub-${sub}_CPFL)

	

	jq --arg new_path_filesL $new_path_filesL '.files =  [$new_path_filesL]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json
	jq --arg new_path_files_refL $new_path_files_refL '.files_ref =  [$new_path_files_refL]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json
	 jq --arg new_path_files_nii $new_path_files_nii '.files_nii =  [$new_path_files_nii]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json
	 jq --arg new_path_outputFolderL $new_path_outputFolderL '.outputFolder =  [$new_path_outputFolderL]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFL/OspreyJob.json

	 # voxel R
	mkdir -p $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR
	cp $Osprey_json_template $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/.

	new_path_filesR=$(echo /Volumes/groupdata/MRI_BIDS_DATABANK/NEMO/sourcedata/sub-${sub}/ses-01/spectro/MrSpec_NEMO_sub-${sub}_ses-01_CPF-R.rda)
	new_path_files_refR=$(echo /Volumes/groupdata/MRI_BIDS_DATABANK/NEMO/sourcedata/sub-${sub}/ses-01/spectro/MrSpec_NEMO_sub-${sub}_ses-01_CPF-R_ssWS.rda)
	new_path_outputFolderR=$(echo /Volumes/groupdata/MRI_BIDS_DATABANK/NEMO/derivatives/Osprey/sub-${sub}_CPFR)

	jq --arg new_path_filesR $new_path_filesR '.files =  [$new_path_filesR]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json
	jq --arg new_path_files_refR $new_path_files_refR '.files_ref =  [$new_path_files_refR]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json
	 jq --arg new_path_files_nii $new_path_files_nii '.files_nii =  [$new_path_files_nii]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json
	 jq --arg new_path_outputFolderR $new_path_outputFolderR '.outputFolder =  [$new_path_outputFolderR]' $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json \
	 > "tmp.$$.json" && mv  "tmp.$$.json" $EXPDIR/derivatives/Osprey/sub-${sub}_CPFR/OspreyJob.json

done
