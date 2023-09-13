#!/bin/bash

shopt -s expand_aliases
source ~/.bashrc
source ~/.bash_profile

source ../Topup_Physio_BIDS/subjects_to_process.cfg

EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Users/jsein/Documents/Centre_IRMf/DATA/BIDS/$study
#DICOMFOLDER=/Volumes/groupdata/STORE/$study
DICOMFOLDER=/Users/jsein/Documents/Centre_IRMf/DATA/DICOM/$study
OUTDIR=$DICOMFOLDER/physio
mkdir -p $OUTDIR
OUTDIR=\'$OUTDIR\';


#list_sub=$(basename $(ls -d $EXPDIR/sub-??))

for sub in $list_sub
do
	sub=sub-${sub}
	ses=$list_ses


	if [ -z $ses ]; then
		##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------
		OUTSOURCEDIR=$EXPDIR/sourcedata/$sub
		FUNCDIR=$EXPDIR/$sub/func
		SOURCEDIR=$DICOMFOLDER/$sub/dicom
		mkdir -p $OUTSOURCEDIR

		pushd $SOURCEDIR
		list_physio=$(ls -d *PhysioLog*)
		popd

		#OUTDIR=/Users/jsein/Documents/Centre_IRMf/DATA/DICOM/test_phys;
		OUTDIR=\'$OUTDIR\';

		for physio in $list_physio
		do
			file=\'$(ls $SOURCEDIR/$physio/secondary/*.dcm)\';echo $file;matlab -r "extractCMRRPhysio($file,$OUTDIR);exit"
		done 

	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		#OUTSOURCEDIR=$EXPDIR/sourcedata/$sub/$ses
		#FUNCDIR=$EXPDIR/$sub/$ses/func
		#SOURCEDIR=$DICOMFOLDER/${sub}_${ses}/dicom
		SOURCEDIR=$DICOMFOLDER/${sub}_${ses}/scans
		mkdir -p $OUTSOURCEDIR

		pushd $SOURCEDIR
		list_physio=$(ls -d *PhysioLog*)
		popd


		for physio in $list_physio
		do
			file=\'$(ls $SOURCEDIR/$physio/secondary/*.dcm)\'
			echo $file
			matlab -r "extractCMRRPhysio($file,$OUTDIR);exit"
		done 
	fi
done




