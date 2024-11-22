#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

ses=01 # name of session to create

EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=~/disks/meso_scratch/jsein/BIDS/$study
pushd $EXPDIR
list_sub=$(ls -d sub-*)
popd
for sub in $list_sub
do

	echo -----starting subject $sub------
	SUBDIR=$EXPDIR/$sub


	find $SUBDIR/ses-${ses}/func/. -name 'sub*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_ses-'"$ses"'_}' -- {} \;
	#find $EXPDIR/sourcedata/$sub/ses-${ses}/. -name '*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_ses-'"$ses"'_ses-'"$ses"'/'"$sub"'_ses-'"$ses"'}' -- {} \;



done