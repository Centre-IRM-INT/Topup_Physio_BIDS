#!/bin/bash

source ../Topup_Physio_BIDS/subjects_to_process.cfg
#list_sub="sub-001 sub-003 sub-005 sub-006 sub-007 sub-008 sub-013 sub-031 sub-032 sub-033 sub-034 sub-035 sub-036 sub-037 sub-039 sub-040 sub-041 sub-042 sub-043 sub-044 sub-045 sub-047 sub-061 sub-062 sub-065 sub-066 sub-067 sub-068 sub-069 sub-"
#study=Antisac_enfant
#read -p "quel est sont le noms du projet à traiter? (noms des sujets avec des espaces)" study
#read -p "quel est sont les noms des sujets à traiter? (noms des sujets avec des espaces)" list_sub
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

jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_run-1_epi.json"
jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_run-1_epi.json"
jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_run-1_fieldmap.json"

jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_run-2_epi.json"
jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_run-2_epi.json"
jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_run-2_fieldmap.json"

#jq '. + { "Units": "Hz"}' "${SUBDIR}fmap/${sub}_acq-topup_dir-01_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}fmap/${sub}_acq-topup_fieldmap.json"

list=$(ls "${SUBDIR}func/"*bold.nii.gz)

shim1=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_run-1_epi.json")	
shim2=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_run-2_epi.json")

for func in $list
do
	shim3=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
	funci=${func//$SUBDIR/}
if [ "$shim3" = "$shim1" ]
then
	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"
	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"
	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"
elif [ "$shim3" = "$shim2" ]
then
	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"
	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"
	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"
fi
done



done
