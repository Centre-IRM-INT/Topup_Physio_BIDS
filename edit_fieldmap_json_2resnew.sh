#!/bin/bash

source ../Topup_Physio_BIDS/subjects_to_process.cfg

EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
res1=1p75mm
res2=2mm

for sub in $list_sub
do
	sub=sub-${sub}
	echo -----starting subject $sub------
	OUTDIR=$EXPDIR/derivatives/$sub
	SUBDIR=$EXPDIR/$sub/
	mkdir -p $OUTDIR

    jq 'del(.Units)' "${SUBDIR}/"fmap/"${sub}_acq-${res1}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res1}_fieldmap.json"
    jq 'del(.Units)' "${SUBDIR}/"fmap/"${sub}_acq-${res2}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res2}_fieldmap.json"
	jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_acq-${res2}_fieldmap.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/fmap/${sub}_acq-${res2}_fieldmap.json"
	jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_acq-${res1}_fieldmap.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/fmap/${sub}_acq-${res1}_fieldmap.json"

	jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_acq-${res1}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res1}_dir-AP_epi.json"
	jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_acq-${res1}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res1}_dir-PA_epi.json"
	jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_acq-${res1}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res1}_fieldmap.json"

	jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_acq-${res2}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res2}_dir-AP_epi.json"
	jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_acq-${res2}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res2}_dir-PA_epi.json"
	jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_acq-${res2}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_acq-${res2}_fieldmap.json"

	shim1=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_acq-${res1}_dir-AP_epi.json")	
	shim2=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_acq-${res2}_dir-AP_epi.json")

	list=$(ls "${SUBDIR}func/"*bold.nii.gz)

	for func in $list
	do
		shim3=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
		funci=${func//$SUBDIR/}
	 	if [ "$shim3" = "$shim1" ]
	 	then
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_acq-${res1}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_acq-${res1}_dir-AP_epi.json"
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_acq-${res1}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_acq-${res1}_dir-PA_epi.json"
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_acq-${res1}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_acq-${res1}_fieldmap.json"
	 	elif [ "$shim3" = "$shim2" ]
	 	then
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_acq-${res2}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_acq-${res2}_dir-AP_epi.json"
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_acq-${res2}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_acq-${res2}_dir-PA_epi.json"
	 		jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_acq-${res2}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_acq-${res2}_fieldmap.json"
	 	fi
	done

done
