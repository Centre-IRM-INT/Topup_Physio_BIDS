#!/bin/bash

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
if [ $study = "AlcAddict" ];then 
	STIMFOLDER=/Volumes/MANIP_DrugAddict
else
	STIMFOLDER=/Volumes/${STIM}/MANIP_$study
fi


#list_sub=$(basename $(ls -d $EXPDIR/sub-??))

for sub in $list_sub
do
	sub=sub-${sub}
	ses=$list_ses
	if [ $study = "NEMO" ];then 
	ses=01
	fi


	if [ -z $ses ]; then
		##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------
		OUTDIR=$EXPDIR/sourcedata/$sub
		FUNCDIR=$EXPDIR/$sub/func
		mkdir -p $OUTDIR


		#cp ${STIMFOLDER}/sourcedata/$sub/sub*.tsv $FUNCDIR/
		#cp ${STIMFOLDER}/sourcedata/$sub/*.txt $OUTDIR/
		#cp ${STIMFOLDER}/sourcedata/$sub/sub*.tsv $OUTDIR/
		#cp ${STIMFOLDER}/sourcedata/$sub/sub*.edf $OUTDIR/
		#cp -f ${STIMFOLDER}/sourcedata/$sub/*.wav $OUTDIR/
		#cp -f ${STIMFOLDER}/sourcedata/$sub/*.lvm $OUTDIR/
		cp -f ${STIMFOLDER}/sourcedata/${sub}/* $OUTDIR/

	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		OUTDIR=$EXPDIR/sourcedata/$sub/$ses
		FUNCDIR=$EXPDIR/$sub/$ses/func
		mkdir -p ${OUTDIR}

		if [ $study = "NEMO" ];then 
			mv ${STIMFOLDER}/sourcedata/$sub ${STIMFOLDER}/sourcedata/${sub}_${ses}
			pushd ${STIMFOLDER}/sourcedata/${sub}_${ses}
			find . -name 'sub*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_'"$ses"'_}' -- {} \;
			popd
		elif [ $study = "AlcAddict" ];then 
			mv ${STIMFOLDER}/sourcedata/$sub ${STIMFOLDER}/sourcedata/${sub}_${ses}
			pushd ${STIMFOLDER}/sourcedata/${sub}_${ses}
			find . -name 'sub*' -type f -exec bash -c 'mv "$1" ${1/'"$sub"'_/'"$sub"'_'"$ses"'_}' -- {} \;
			popd
		fi


		#cp ${STIMFOLDER}/sourcedata/${sub}_${ses}/sub*.tsv $FUNCDIR/
		#cp ${STIMFOLDER}/sourcedata/$sub/*.txt $OUTDIR/
		#cp ${STIMFOLDER}/sourcedata/$sub/sub*.tsv $OUTDIR/
		#cp ${STIMFOLDER}/sourcedata/$sub/sub*.edf $OUTDIR/
		#cp -f ${STIMFOLDER}/sourcedata/$sub/*.wav $OUTDIR/
		#cp -f ${STIMFOLDER}/sourcedata/$sub/*.lvm $OUTDIR/
		if [ $STIM = "Stimulation_2024" ];then
		cp -f ${STIMFOLDER}/sourcedata/${sub}/${ses}/* $OUTDIR/
		else
		cp -f ${STIMFOLDER}/sourcedata/${sub}_${ses}/* $OUTDIR/

		fi
	fi


done
