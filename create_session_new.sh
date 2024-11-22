#!/bin/bash

source ../Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
pushd $EXPDIR
list_sub=$(ls -d sub-*_ses*)
popd
for subi in $list_sub
do
echo -----starting subject $subi------

sub=$(echo $subi | cut -d '_' -f 1)
ses=$(echo $subi | cut -d '_' -f 2)

echo -----starting subject $sub, session $ses------

SUBDIR=$EXPDIR/$sub


mkdir -p $EXPDIR/$sub/$ses


mv $EXPDIR/${sub}_${ses}/anat $EXPDIR/${sub}_${ses}/fmap $EXPDIR/${sub}_${ses}/dwi $EXPDIR/${sub}_${ses}/func  $EXPDIR/$sub/$ses/.
rm -r $EXPDIR/${sub}_${ses}




#find "${SUBDIR}"/ses-pre/* -name 'sub*' -type f -exec bash -c 'mv "$1" ${1/sub-??_/"sub-'"${sub:4:5}"'_ses-pre_"}' -- {} \;


done

pushd $EXPDIR/sourcedata
list_sub=$(ls -d sub-*_ses*)
popd

for subi in $list_sub
do

echo -----starting sourcedata: subject $subi------

sub=$(echo $subi | cut -d '_' -f 1)
ses=$(echo $subi | cut -d '_' -f 2)

echo -----starting sourcedata: subject $sub, session $ses------


mkdir -p $EXPDIR/sourcedata/$sub/$ses

mv $EXPDIR/sourcedata/${sub}_${ses}/*  $EXPDIR/sourcedata/$sub/$ses/.
rm -r $EXPDIR/sourcedata/${sub}_${ses}

done
