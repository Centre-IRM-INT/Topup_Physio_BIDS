#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
SOURCEDATA_DIR=/Volumes/Stimulation_2024/MANIP_${study}/sourcedata
BIDS_DIR=/Volumes/data3/MRI_BIDS_DATABANK/$study


for sub in $list_sub
do
	sub=sub-${sub}
	ses=$list_ses
	

	if [ -z $ses ]; then
		##### case with no "ses-" ###########
		echo "Problème !!!! there is no session in the config file!"


	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		pushd cd $SOURCEDATA_DIR/$sub
		rename 's/sub-01/sub-01_ses-01/' *
		mkdir -p ${OUTDIR_RAW}
		mkdir -p ${OUTDIR_RDA}
		mkdir -p ${OUTDIR_DICOM}


		cp -f ${RAWDIR}/MrSpec_${study}_${sub}* $OUTDIR/.

	fi


done
