#!/bin/sh

source ../Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/home/seinj/mygpdata/MRI_BIDS_DATABANK/$study
#EXPDIR=~/Documents/Centre_IRMf/DATA/BIDS/$study
#EXPDIR=~/disks/meso_scratch/BIDS/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
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


	if [ -z $ses ]; then
		##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------

		SUBDIR=$EXPDIR/$sub/

     	list_json=$(ls $SUBDIR/*/sub-*.json)

     	for json in $list_json
     	do
     		jq 'del(.AcquisitionDuration)' "$json"  > "tmp.$$.json" && mv  "tmp.$$.json" "$json"

	 	done
	 	
	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}------
		SUBDIR=$EXPDIR/$sub/

		list_json=$(ls $SUBDIR/ses*/sub-*.json)
		for json in $list_json
     	do
     		jq 'del(.AcquisitionDuration)' "$json"  > "tmp.$$.json" && mv  "tmp.$$.json" "$json"

	 	done
		
	fi
done


