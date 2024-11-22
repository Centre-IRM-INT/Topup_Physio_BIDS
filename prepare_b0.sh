#!/bin/sh

# Usage:
## bash prepare_b0.sh

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/home/seinj/mygpdata/MRI_BIDS_DATABANK/$study
#EXPDIR=~/Documents/Centre_IRMf/DATA/BIDS/$study
#EXPDIR=~/disks/meso_scratch/BIDS/$study
EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study

### For all subjects######
#pushd $EXPDIR
#list_sub=$(ls -d sub*)
#list_sub=${list_sub//sub-/}
#popd
###################


for sub in $list_sub
do
	sub=sub-${sub}
	ses=$list_ses


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
				if [ "$nvol_AP" = '8' ]
				then echo 'there is a short b0 acquistion'
					fslroi $SUBDIR/dwi/${sub}_${ses}_dir-AP_dwi.nii.gz $SUBDIR/dwi/${sub}_${ses}_dir-AP_dwi.nii.gz 0 7
					cut -d' ' -f1-7 $SUBDIR/dwi/${sub}_${ses}_dir-AP_dwi.bval > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json"  $SUBDIR/dwi/${sub}_${ses}_dir-AP_dwi.bval
					cut -d' ' -f1-7 $SUBDIR/dwi/${sub}_${ses}_dir-AP_dwi.bvec > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" $SUBDIR/dwi/${sub}_${ses}_dir-AP_dwi.bvec
				else
					echo "the acquisition appears to be HCP-style"
				fi
			done

	else
		##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------
		OUTDIR=/$EXPDIR/derivatives/TEMP
		SUBDIR=$EXPDIR/$sub
		
		nvol_AP=$(fslinfo $SUBDIR/dwi/${sub}_dir-AP_dwi.nii.gz | grep '^dim4' | cut  -f 3)
		nvol_PA=$(fslinfo $SUBDIR/dwi/${sub}_dir-PA_dwi.nii.gz | grep '^dim4' | cut  -f 3)
		if [ "$nvol_AP" = '8' ]
		then echo 'there is a short b0 acquistion in AP'
		fslroi $SUBDIR/dwi/${sub}_dir-AP_dwi.nii.gz $SUBDIR/dwi/${sub}_dir-AP_dwi.nii.gz 0 7
		cut -d' ' -f1-7 $SUBDIR/dwi/${sub}_dir-AP_dwi.bval > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json"  $SUBDIR/dwi/${sub}_dir-AP_dwi.bval
		cut -d' ' -f1-7 $SUBDIR/dwi/${sub}_dir-AP_dwi.bvec > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" $SUBDIR/dwi/${sub}_dir-AP_dwi.bvec
		else
			echo "the acquisition appears to be HCP-style"
		fi
	fi
done


