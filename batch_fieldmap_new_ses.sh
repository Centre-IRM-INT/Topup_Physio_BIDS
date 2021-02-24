#!/bin/sh

source ../Topup_Physio_BIDS/subjects_to_process.cfg

EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
mkdir -p /Volumes/groupdata/MRI_BIDS_DATABANK/$study/derivatives

for sub in $list_sub
do
	for ses in $list_ses
	do

			sub=sub-${sub}
			ses=ses-${ses}
echo -----starting subject ${sub}_${ses}------
OUTDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study/derivatives/$sub/$ses
SUBDIR=$EXPDIR/$sub/
mkdir -p /Volumes/groupdata/MRI_BIDS_DATABANK/$study/derivatives/$sub/$ses
mkdir -p ${OUTDIR}/topup

fslmerge -t "${OUTDIR}/topup/${sub}_${ses}_FieldmapAP_PA"  "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_epi.nii.gz" "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-PA_epi.nii.gz"


RT=$(jq .TotalReadoutTime "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_epi.json")

direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_epi.json")
direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-PA_epi.json")
if [ "$direction1" = '"j-"' ]; then
    phase1='0 -1 0'
elif [ "$direction1" = '"j"' ]; then
    phase1='0 1 0'
fi;
if [ "$direction2" = '"j-"' ]; then
phase2='0 -1 0'
elif [ "$direction2" = '"j"' ]; then
phase2='0 1 0'
fi;
echo   "$phase1 $RT\n$phase1 $RT\n$phase1 $RT\n$phase2 $RT\n$phase2 $RT\n$phase2 $RT" > ${OUTDIR}/topup/${sub}_${ses}_acqparamsAP_PA.txt

# Correct for EVEN number of slices to use b02b0.cnf
dimz=`fslval ${OUTDIR}/topup/${sub}_${ses}_FieldmapAP_PA.nii.gz dim3`
if [ `expr $dimz % 2` -eq 1 ]; then
    echo "remove one slice to get odd number of slices"
    fslroi ${OUTDIR}/topup/${sub}_${ses}_FieldmapAP_PA.nii.gz ${OUTDIR}/topup/${sub}_${ses}_FieldmapAP_PA.nii.gz 0 -1 0 -1 1 -1 0 -1
    topup --imain="${OUTDIR}/topup/${sub}_${ses}_FieldmapAP_PA" --datain="${OUTDIR}/topup/${sub}_${ses}_acqparamsAP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/topup/${sub}_${ses}_my_topup_results1" --fout="${SUBDIR}$ses/fmap/${sub}_${ses}_fieldmap" --iout="${OUTDIR}/topup/${sub}_${ses}_my_unwarped_images"
    # to use topup config file for odd slices uncomment line below and comment lines above
    #echo "odd number of slices: run topup with specific config file"
    #topup --imain="${OUTDIR}/topup/${sub}_FieldmapAP_PA" --datain="${OUTDIR}/topup/${sub}_acqparamsAP_PA.txt" --config=/Users/jsein/hubiC/JUL/Topup_Physio_BIDS/b02b0_oddslices.cnf --out="${OUTDIR}/topup/${sub}_my_topup_results1" --fout="${SUBDIR}$ses/fmap/${sub}_fieldmap" --iout="${OUTDIR}/topup/${sub}_my_unwarped_images"

 else       
 	topup --imain="${OUTDIR}/topup/${sub}_${ses}_FieldmapAP_PA" --datain="${OUTDIR}/topup/${sub}_${ses}_acqparamsAP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/topup/${sub}_${ses}_my_topup_results1" --fout="${SUBDIR}$ses/fmap/${sub}_${ses}_fieldmap" --iout="${OUTDIR}/topup/${sub}_${ses}_my_unwarped_images"
fi

# new line to extract first volume
fslroi "${SUBDIR}$ses/fmap/${sub}_${ses}_fieldmap" "${SUBDIR}$ses/fmap/${sub}_${ses}_fieldmap" 0 1
#
jq '. + { "Units": "Hz"}' "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}$ses/fmap/${sub}_${ses}_fieldmap.json"


fslmaths "${OUTDIR}/topup/${sub}_${ses}_my_unwarped_images" -Tmean "${SUBDIR}$ses/fmap/${sub}_${ses}_magnitude"

shim1=$(jq .ShimSetting "${SUBDIR}${ses}/fmap/${sub}_dir-AP_epi.json") 

list=$(ls "${SUBDIR}${ses}/func/"*bold.nii.gz)

for func in $list_func
do
        shim2=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        funci=${func//$SUBDIR/}
        if [ "$shim2" = "$shim1" ]
        then
~/jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_fieldmap.json"
~/jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_dir-AP_epi.json"
~/jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_dir-PA_epi.json"
done

done
done