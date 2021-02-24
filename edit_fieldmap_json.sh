#!/bin/bash

source ../Topup_Physio_BIDS/subjects_to_process.cfg


EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=~/Documents/Centre_IRMf/BIDS/$study

#list_sub=$(ls $EXPDIR)
#list_sub=$(echo "${list_sub//sourcedata}")
#list_sub=$(echo "${list_sub//Pilote-02}")
#list_sub=$(echo "${list_sub//participants.tsv}")
#list_sub=$(echo "${list_sub//dataset_description.json}")
#list_sub=$(echo "${list_sub//derivatives}")
#list_sub=$(echo "${list_sub//README}")
#list_sub=$(basename $(ls -d $EXPDIR/sub-??))
for sub in $list_sub
do
	sub=sub-${sub}
echo -----starting subject $sub------
OUTDIR=$EXPDIR//derivatives/$sub
SUBDIR=$EXPDIR/$sub/
mkdir -p $OUTDIR


jq '. + { "Units": "Hz"}' "${SUBDIR}fmap/${sub}_acq-topup_dir-01_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}fmap/${sub}_acq-topup_fieldmap.json"

jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_epi.json"
jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_epi.json"
jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_fieldmap.json"

shim1=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_epi.json")	

list=$(ls "${SUBDIR}func/"*bold.nii.gz)

	for func in $list
	do
		shim2=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
		funci=${func//$SUBDIR/}
	 	if [ "$shim2" = "$shim1" ]
	 	then
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_epi.json"
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_epi.json"
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_fieldmap.json"
	 	fi
	 done

done
