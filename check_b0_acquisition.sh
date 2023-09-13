#!/bin/sh

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg


EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
list_sub=$(ls -d $EXPDIR/sub*)
list_sub=${list_sub//$EXPDIR\//}

for sub in $list_sub
do

	if [[ -n $(find $EXPDIR/$sub  -type d -name "ses-*" 2>/dev/null) ]]
		then echo "there is ses"
		list_ses=$(ls -d $EXPDIR/$sub/ses-*)
		for ses in $list_ses
		do
			ses="${ses//$EXPDIR\/$sub\/}"
			echo -----starting subject ${sub}_${ses}------
			SUBDIR=$EXPDIR/$sub/$ses
			OUTDIR=/$EXPDIR/derivatives/TEMP
			mkdir -p $OUTDIR


			nvol_AP=$(fslinfo $SUBDIR/dwi/${sub}_${ses}_dir-AP_dwi.nii.gz | grep '^dim4' | cut  -f 3)
			nvol_PA=$(fslinfo $SUBDIR/dwi/${sub}_${ses}_dir-PA_dwi.nii.gz | grep '^dim4' | cut  -f 3)
			if [ "$nvol_AP" = "$nvol_PA" ]
			then 
				echo "the acquisition appears to be HCP-style"
			else
				echo 'there is a short b0 acquistion'
				echo "${sub}_${ses}" >> list_b0_dwi_acq.txt
			fi
		done




	##### case with no "ses-" ###########
	else echo "there is no session"
		echo -----starting subject $sub------
		SUBDIR=$EXPDIR/$sub
		OUTDIR=/$EXPDIR/derivatives/TEMP
		mkdir -p $OUTDIR
		
		nvol_AP=$(fslinfo $SUBDIR/dwi/${sub}_dir-AP_dwi.nii.gz | grep '^dim4' | cut  -f 3)
		nvol_PA=$(fslinfo $SUBDIR/dwi/${sub}_dir-PA_dwi.nii.gz | grep '^dim4' | cut  -f 3)
		if [ "$nvol_AP" = "$nvol_AP" ]
		then echo "the acquisition appears to be HCP-style" 
		else
			echo 'there is a short b0 acquistion in AP'
			echo "${sub}" >> list_b0_dwi_acq.txt
		fi

	fi
done


