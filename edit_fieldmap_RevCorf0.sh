#!/bin/sh

source ../Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/home/seinj/mygpdata/MRI_BIDS_DATABANK/$study
#EXPDIR=~/Documents/Centre_IRMf/DATA/BIDS/$study
#EXPDIR=~/disks/meso_scratch/BIDS/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study

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


	
	ses=ses-${ses}
	echo -----starting subject ${sub}_${ses}------
	OUTDIR=$EXPDIR/derivatives/topup/$sub/$ses
	SUBDIR=$EXPDIR/$sub/
	mkdir -p ${OUTDIR}
	pushd  ${SUBDIR}$ses/fmap
    epi=$(ls sub-*dir-AP*epi*.nii.gz)
    popd
    num=$(echo $epi | wc -w)

    for i in $(seq 1 $num);
    do


		jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"
		jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"
		jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"
		jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"
	#	jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"


		shim=$(jq .ShimSetting "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_run-${i}_epi.json")	

		B0arg="B0map${i}${ses//es-/}"

		#jq --arg B0arg $B0arg '.B0FieldIdentifier |= .+ $B0arg' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"
		#jq --arg B0arg $B0arg '.B0FieldIdentifier |= .+ $B0arg' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"

		if [[ $i -eq 1 ]]
		then
			list=$(echo "${SUBDIR}$ses/func/${sub}_${ses}_task-Localizer_run-01_bold.nii.gz" "${SUBDIR}$ses/func/${sub}_${ses}_task-Localizer_run-02_bold.nii.gz" "${SUBDIR}$ses/func/${sub}_${ses}_task-RCF0Pilot_run-01_bold.nii.gz")
			for func in $list
			do
				shimX=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        		funci=${func//$SUBDIR/}
        		if [ "$shimX" = "$shim" ]; then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					#jq --arg B0arg $B0arg '.B0FieldSource |= .+ $B0arg' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
				fi
			done
		else
			list=$(echo "${SUBDIR}$ses/func/${sub}_${ses}_task-RCF0Pilot_run-0${i}_bold.nii.gz")
			for func in $list
			do
				shimX=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        		funci=${func//$SUBDIR/}
        		if [ "$shimX" = "$shim" ]; then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-${i}_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-${i}_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					#jq --arg B0arg $B0arg '.B0FieldSource |= .+ $B0arg' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
				fi
			done
		fi
	done
done


