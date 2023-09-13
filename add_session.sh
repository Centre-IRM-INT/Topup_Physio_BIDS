#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

ses=01 # name of session to create

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
EXPDIR=~/disks/meso_scratch/jsein/BIDS/$study
pushd $EXPDIR
list_sub=$(ls -d sub-*)
popd
for sub in $list_sub
do

	echo -----starting subject $sub------
	SUBDIR=$EXPDIR/$sub

	if [[ -n $(find $EXPDIR/$sub  -type d -name "ses-*" 2>/dev/null) ]]
		then echo "#### There is ses: Do nothing ####"
	else
		echo "#### There is no ses: Create session: ses-${ses} ####"
		mkdir -p $EXPDIR/$sub/ses-${ses}
		mv $SUBDIR/anat $SUBDIR/fmap $SUBDIR/dwi $SUBDIR/func  $EXPDIR/$sub/ses-${ses}/.
		find "${SUBDIR}"/ses-${ses}/*/. -name 'sub*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_ses-'"$ses"'_"}' -- {} \;
		###for sourcedata: comment if not needed
		#mkdir -p $EXPDIR/sourcedata/$sub/ses-${ses}
		#mv $EXPDIR/sourcedata/$sub/*  $EXPDIR/sourcedata/$sub/ses-${ses}/.
		#find $EXPDIR/sourcedata/$sub/ses-${ses}/. -name '*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_ses-'"$ses"'_}' -- {} \;
	fi

done

