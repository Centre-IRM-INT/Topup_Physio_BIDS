#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
RAWDIR_RDA=/Volumes/data/SpectroRDA/$study
RAWDIR_DAT=/Volumes/data/RAW/$study

#pushd $EXPDIR
#list_sub=$(ls -d sub*)
#list_sub=${list_sub//sub-/}
#popd

for sub in $list_sub
do
	sub=sub-${sub}
	ses=$list_ses
	

	if [ -z $ses ]; then
		##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------
			OUTDIR_RAW=$EXPDIR/sourcedata/$sub/spectro/RAW
			OUTDIR_RDA=$EXPDIR/sourcedata/$sub/spectro/RDA
			OUTDIR_DICOM=$EXPDIR/sourcedata/$sub/spectro/DICOM
			mkdir -p $OUTDIR_RAW
			mkdir -p $OUTDIR_RDA
			mkdir -p $OUTDIR_DICOM
			cp -f ${RAWDIR_RDA}/*${sub}* $OUTDIR_RDA/.
			cp -f ${RAWDIR_DAT}/${sub}/* $OUTDIR_RAW/.

	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		if [ $study = "NEMO" ];then 
			OUTDIR_RDA=$EXPDIR/sourcedata/$sub/$ses/spectro
			mkdir -p $OUTDIR_RDA
			cp -f ${RAWDIR_RDA}/*${sub}* $OUTDIR_RDA/.
        else
			OUTDIR_RAW=$EXPDIR/sourcedata/$sub/$ses/spectro/RAW
			OUTDIR_RDA=$EXPDIR/sourcedata/$sub/$ses/spectro/RDA
			OUTDIR_DICOM=$EXPDIR/sourcedata/$sub/$ses/spectro/DICOM
			mkdir -p $OUTDIR_RAW
			mkdir -p $OUTDIR_RDA
			mkdir -p $OUTDIR_DICOM
			cp -f ${RAWDIR_RDA}/*${sub}* $OUTDIR_RDA/.
			cp -f ${RAWDIR_DAT}/${sub}/* $OUTDIR_RAW/.
		fi

	fi


done
