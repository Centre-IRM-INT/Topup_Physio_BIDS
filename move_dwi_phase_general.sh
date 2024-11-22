#!/bin/sh

source ../Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/home/seinj/mygpdata/MRI_BIDS_DATABANK/$study
#EXPDIR=~/Documents/Centre_IRMf/DATA/BIDS/$study
#EXPDIR=~/disks/meso_scratch/BIDS/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study


for sub in $list_sub
do
	sub=sub-${sub}
	ses=$list_ses

	if [ -z $ses ]; then
	##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------
		find $EXPDIR/$sub/dwi/. -name 'sub*' -type f -exec bash -c 'mv "$1" "${1//part-phase_dir-AP/dir-AP_part-phase}"' -- {} \; 
		find $EXPDIR/$sub/dwi/. -name 'sub*' -type f -exec bash -c 'mv "$1" "${1//part-phase_dir-PA/dir-PA_part-phase}"' -- {} \;
 		mkdir -p $EXPDIR/sourcedata/$sub/dwi
 		mv $EXPDIR/$sub/dwi/*part-phase* $EXPDIR/sourcedata/$sub/dwi/.

	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		find $EXPDIR/$sub/$ses/dwi/. -name 'sub*' -type f -exec bash -c 'mv "$1" "${1//part-phase_dir-AP/dir-AP_part-phase}"' -- {} \; 
		find $EXPDIR/$sub/$ses/dwi/. -name 'sub*' -type f -exec bash -c 'mv "$1" "${1//part-phase_dir-PA/dir-PA_part-phase}"' -- {} \;
 		mkdir -p $EXPDIR/sourcedata/$sub/$ses/dwi
 		mv $EXPDIR/$sub/$ses/dwi/*part-phase* $EXPDIR/sourcedata/$sub/$ses/dwi/.
 	fi
 done
