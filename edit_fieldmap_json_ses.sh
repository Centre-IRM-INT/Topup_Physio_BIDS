#!/bin/bash

source ../Topup_Physio_BIDS/subjects_to_process.cfg
#list_sub="sub-001 sub-003 sub-005 sub-006 sub-007 sub-008 sub-013 sub-031 sub-032 sub-033 sub-034 sub-035 sub-036 sub-037 sub-039 sub-040 sub-041 sub-042 sub-043 sub-044 sub-045 sub-047 sub-061 sub-062 sub-065 sub-066 sub-067 sub-068 sub-069 sub-"
#study=Antisac_enfant
#read -p "quel est sont le noms du projet à traiter? (noms des sujets avec des espaces)" study
#read -p "quel est sont les noms des sujets à traiter? (noms des sujets avec des espaces)" list_sub
EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study

for subi in $list_sub
do
	for sesi in $list_ses 
	do
		sub=sub-${subi}
		ses=ses-${sesi}
		echo -----starting session ${sub}_${ses}------
		OUTDIR=$EXPDIR//derivatives/$sub/$ses
		SUBDIR=$EXPDIR/$sub/
		mkdir -p $OUTDIR

		shim1=$(jq .ShimSetting "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_epi.json")	

		list=$(ls "${SUBDIR}${ses}/func/"*bold.nii.gz)

		jq 'del(.IntendedFor)' "${SUBDIR}${ses}/fmap/${sub}_${ses}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_fieldmap.json"
		jq 'del(.IntendedFor)' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_epi.json"
		jq 'del(.IntendedFor)' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_epi.json"

		for func in $list
		do
			shim2=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
			funci=${func//$SUBDIR/}
	 		if [ "$shim2" = "$shim1" ]
	 		then 
				jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/fmap/${sub}_${ses}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_fieldmap.json"
				jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_epi.json"
				jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_epi.json"
			fi
		done



	done
done

