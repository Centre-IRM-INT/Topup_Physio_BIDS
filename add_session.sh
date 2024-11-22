#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

ses=$(echo $list_ses) # name of session to create

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
#EXPDIR=~/disks/meso_scratch/jsein/BIDS/$study

## To do all participants of the study, uncomment this:
#pushd $EXPDIR
#list_sub=$(ls -d sub-*)
#list_sub=${list_sub//sub-/}
#popd

for sub in $list_sub
do
	if [ -z $ses ]; then
	##### case with no "ses-" ###########
	echo "there is no "ses" requested: nothing to do"
	else

	   sub=sub-${sub}
	   echo -----starting subject $sub------
	   SUBDIR=$EXPDIR/$sub
	   ses=$list_ses
	   ses=ses-${ses}
	
		if [[ -n $(find $EXPDIR/${sub}_${ses} -d -name "anat" 2>/dev/null) ]]
			then echo " there is one session to reorganize"

			mkdir -p $EXPDIR/$sub/$ses
			mv $EXPDIR/${sub}_${ses}/* $EXPDIR/$sub/$ses/.
			rm -r $EXPDIR/${sub}_${ses}


		else
			echo "#### There is no ses: Create session: ${ses} ####"
			mkdir -p $EXPDIR/$sub/${ses}
			mv $SUBDIR/anat $SUBDIR/fmap $SUBDIR/dwi $SUBDIR/func  $EXPDIR/$sub/${ses}/.
			find "${SUBDIR}"/${ses}/*/. -name 'sub*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_'"$ses"'_}' -- {} \;
		fi


		if [[ -n $(find $EXPDIR/sourcedata/$sub  -type d -name "ses-*" 2>/dev/null) ]]
			then echo "#### There is ses in sourcedata: Do nothing ####"
		else
			echo "#### There is no ses in sourcedata: Create session: ${ses} ####"
			mkdir -p $EXPDIR/sourcedata/$sub/${ses}
			mv $EXPDIR/sourcedata/$sub/*  $EXPDIR/sourcedata/$sub/${ses}/.
			find $EXPDIR/sourcedata/$sub/${ses}/. -name '*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_'"$ses"'_}' -- {} \;
		fi

		if [[ -n $(find $EXPDIR/sourcedata/$sub/${ses}/spectro/   -name "*ses-*" 2>/dev/null) ]]
			then echo "#### There is ses in spectro RDA files: Do nothing ####"
		else
			echo "#### There is no ses in spectro RDA files : add session: ${ses} ####"
			list_spectra=$(ls $EXPDIR/sourcedata/$sub/${ses}/spectro/*.rda)
			find $EXPDIR/sourcedata/$sub/${ses}/spectro/. -name '*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_'"$ses"'_}' -- {} \;
		
		fi
	fi



done

