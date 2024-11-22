#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
RAWDIR=/Volumes/data/SpectroRDA/$study
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
		OUTDIR=$EXPDIR/sourcedata/$sub/spectro/RDA
		OUTDIR_DAT=$EXPDIR/sourcedata/$sub/spectro/RAW
		mkdir -p $OUTDIR $OUTDIR_DAT


		cp -f ${RAWDIR}/*${sub}* $OUTDIR/.
		cp -f ${RAWDIR_DAT}/${sub}/* $OUTDIR_DAT/.

	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		OUTDIR=$EXPDIR/sourcedata/$sub/$ses/spectro/RDA
		OUTDIR_DAT=$EXPDIR/sourcedata/$sub/$ses/spectro/RAW
		mkdir -p ${OUTDIR} $OUTDIR_DAT


		cp -f ${RAWDIR}/*${sub}* $OUTDIR/.
		cp -f ${RAWDIR_DAT}/${sub}/* $OUTDIR_DAT/.

	fi


done
