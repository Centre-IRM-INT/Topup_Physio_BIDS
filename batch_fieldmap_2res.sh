#!/bin/sh

source ../Topup_Physio_BIDS/subjects_to_process.cfg

res1=1p75mm
res2=2p5mm

EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
mkdir -p /Volumes/groupdata/MRI_BIDS_DATABANK/$study/derivatives

for sub in $list_sub
do
	sub=sub-${sub}
echo -----starting subject $sub------
OUTDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study/derivatives/$sub
SUBDIR=$EXPDIR/$sub/
mkdir -p /Volumes/groupdata/MRI_BIDS_DATABANK/$study/derivatives
mkdir -p ${OUTDIR}
mkdir -p ${OUTDIR}/topup

fslmerge -t "${OUTDIR}/topup/${sub}_Fieldmap${res1}AP_PA"  "${SUBDIR}fmap/${sub}_acq-${res1}_dir-AP_epi.nii.gz" "${SUBDIR}fmap/${sub}_acq-${res1}_dir-PA_epi.nii.gz"
fslmerge -t "${OUTDIR}/topup/${sub}_Fieldmap${res2}AP_PA"  "${SUBDIR}fmap/${sub}_acq-${res2}_dir-AP_epi.nii.gz" "${SUBDIR}fmap/${sub}_acq-${res2}_dir-PA_epi.nii.gz"

RT_res2=$(jq .TotalReadoutTime "${SUBDIR}fmap/${sub}_acq-${res2}_dir-AP_epi.json")
RT_res1=$(jq .TotalReadoutTime "${SUBDIR}fmap/${sub}_acq-${res1}_dir-AP_epi.json")

direction1_res2=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_acq-${res2}_dir-AP_epi.json")
direction2_res2=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_acq-${res2}_dir-PA_epi.json")
if [ "$direction1_res2" = '"j-"' ]; then
    phase1='0 -1 0'
elif [ "$direction1_res2" = '"j"' ]; then
    phase1='0 1 0'
fi;
if [ "$direction2_res2" = '"j-"' ]; then
phase2='0 -1 0'
elif [ "$direction2_res2" = '"j"' ]; then
phase2='0 1 0'
fi;
echo   "$phase1 $RT_res2\n$phase1 $RT_res2\n$phase1 $RT_res2\n$phase2 $RT_res2\n$phase2 $RT_res2\n$phase2 $RT_res2" > ${OUTDIR}/topup/${sub}_acqparamsAP_PA_${res2}.txt

direction1_res1=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_acq-${res1}_dir-AP_epi.json")
direction2_res1=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_acq-${res1}_dir-PA_epi.json")
if [ "$direction1_res1" = '"j-"' ]; then
phase1='0 -1 0'
elif [ "$direction1_res1" = '"j"' ]; then
phase1='0 1 0'
fi;
if [ "$direction2_res1" = '"j-"' ]; then
phase2='0 -1 0'
elif [ "$direction2_res1" = '"j"' ]; then
phase2='0 1 0'
fi;
echo   "$phase1 $RT_res1\n$phase1 $RT_res1\n$phase1 $RT_res1\n$phase2 $RT_res1\n$phase2 $RT_res1\n$phase2 $RT_res1" > ${OUTDIR}/topup/${sub}_acqparamsAP_PA_${res1}.txt

topup --imain="${OUTDIR}/topup/${sub}_Fieldmap${res2}AP_PA" --datain="${OUTDIR}/topup/${sub}_acqparamsAP_PA_${res2}.txt" --config=b02b0.cnf --out="${OUTDIR}/topup/${sub}_my_topup_results_${res2}" --fout="${SUBDIR}fmap/${sub}_acq-${res2}_fieldmap" --iout="${OUTDIR}/topup/${sub}_acq-${res2}_my_unwarped_images"

topup --imain="${OUTDIR}/topup/${sub}_Fieldmap${res1}AP_PA" --datain="${OUTDIR}/topup/${sub}_acqparamsAP_PA_${res1}.txt" --config=b02b0.cnf --out="${OUTDIR}/topup/${sub}_my_topup_results_${res1}" --fout="${SUBDIR}fmap/${sub}_acq-${res1}_fieldmap" --iout="${OUTDIR}/topup/${sub}_acq-${res1}_my_unwarped_images"


# new line to extract first volume
fslroi "${SUBDIR}fmap/${sub}_acq-${res1}_fieldmap" "${SUBDIR}fmap/${sub}_acq-${res1}_fieldmap" 0 1
fslroi "${SUBDIR}fmap/${sub}_acq-${res2}_fieldmap" "${SUBDIR}fmap/${sub}_acq-${res2}_fieldmap" 0 1
#
jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_acq-${res2}_dir-AP_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/fmap/${sub}_acq-${res2}_fieldmap.json"
jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_acq-${res1}_dir-AP_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/fmap/${sub}_acq-${res1}_fieldmap.json"

#
fslmaths "${OUTDIR}/topup/${sub}_acq-${res2}_my_unwarped_images" -Tmean "${SUBDIR}fmap/${sub}_acq-${res2}_magnitude"
fslmaths "${OUTDIR}/topup/${sub}_acq-${res1}_my_unwarped_images" -Tmean "${SUBDIR}fmap/${sub}_acq-${res1}_magnitude"



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


