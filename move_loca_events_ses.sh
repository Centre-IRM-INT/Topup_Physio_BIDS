#!/bin/bash

source ../Topup_Physio_BIDS/subjects_to_process.cfg

EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study

#list_sub=$(basename $(ls -d $EXPDIR/sub-??))

for sub in $list_sub
do
	for ses in $list_ses
do
	sub=sub-${sub}
	ses=ses-${ses}
echo -----starting subject ${sub}_${ses}------
OUTDIR=$EXPDIR/sourcedata/$sub/$ses/
#OUTDIR=$EXPDIR/export_edf/$sub
FUNCDIR=$EXPDIR/$sub/$ses/func
SUBDIR=$EXPDIR/$sub/$ses
mkdir -p $OUTDIR

#cp /Volumes/Stimulation_2017/MANIP_MorphoSem/sourcedata/$sub/*localizer*.tsv $SUBDIR/func/${sub}_task-localizerpinel_events.tsv

#cp /Volumes/Stimulation_2017/MANIP_MorphoSem/sourcedata/$sub/*localizer*.txt $OUTDIR/.

#cp /Volumes/Stimulation_2017/MANIP_Slip/sourcedata/$sub/*.wav $OUTDIR/

#cp /Volumes/Stimulation_2017/MANIP_PNH_ProtIsPrim/sourcedata/$sub/*.txt $OUTDIR/
#cp /Volumes/Stimulation_2017/MANIP_PNH_ProtIsPrim/sourcedata/$sub/*.tsv $FUNCDIR/

#find $FUNCDIR/. -name '*task*.tsv' -type f -exec bash -c 'mv "$1" "${1/vib16/stim-S2}"' -- {} \;

#cp /Volumes/Stimulation_2017/"MANIP_${study}"/sourcedata/$sub/l* $OUTDIR/
#cp /Volumes/Stimulation_2017/"MANIP_${study}"/sourcedata/$sub/r* $OUTDIR/
##Bigraphe:
#cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/"${sub}"/*.txt $OUTDIR/
#cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/"${sub}"/*.edf $OUTDIR/

#cp /Volumes/Stimulation_2017/"MANIP_${study}"/sourcedata/$sub/c* $OUTDIR/
### Convers
#cp /Volumes/Stimulation_2017/"MANIP_${study}"/sourcedata/$sub/sub*.tsv $SUBDIR/func/
#cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/$sub/*.edf $OUTDIR/
#cp /Volumes/Stimulation_2017/"MANIP_${study}"/sourcedata/$sub/*.avi $OUTDIR/
#cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/$sub/*.wav $OUTDIR/
#cp /Volumes/Archives/Stimulation_2017/"MANIP_${study}"/sourcedata/$sub/*.txt $OUTDIR/
#mv "$SUBDIR/func/"*rest_physio* /Volumes/groupdata/MRI_BIDS_DATABANK/InterTVA_extra/

cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/${sub}_${ses}/sub*.tsv $FUNCDIR/
cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/${sub}_${ses}/*.txt $OUTDIR/
cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/${sub}_${ses}/sub*.tsv $OUTDIR/
#cp /Volumes/Stimulation/"MANIP_${study}"/sourcedata/$sub/sub*.edf $OUTDIR/
cp -f /Volumes/Stimulation/"MANIP_${study}"/sourcedata/${sub}_${ses}/*.wav $OUTDIR/
#cp -f /Volumes/Stimulation/"MANIP_${study}"/sourcedata/$sub/*.lvm $OUTDIR/

done
done
