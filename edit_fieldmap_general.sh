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


	if [ -z $ses ]; then
		##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------
		OUTDIR=/$EXPDIR/derivatives/topup/$sub
		SUBDIR=$EXPDIR/$sub/
		#mkdir -p ${OUTDIR}  # pas besoin si topup n'est pas utilisé
	 	pushd  $SUBDIR/fmap
     	epi=$(ls sub-*dir-AP*epi*.nii.gz)
     	popd
     	num=$(echo $epi | wc -w)

     	if [ $num == 1 ];then
     		##### case with one pair AP-PA ###########
     		echo "case with one pair AP-PA"


		#	jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_dir-AP_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/fmap/${sub}_fieldmap.json"


			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_epi.json"
			#jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_fieldmap.json"

			shim1=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_epi.json")	

			list=$(ls "${SUBDIR}func/"*bold.nii.gz)

			for func in $list
			do
				shim2=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
				funci=${func//$SUBDIR/}
	 			if [ "$shim2" = "$shim1" ]
	 			then
	 				jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_epi.json"
	 				jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_epi.json"
	 				#jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_fieldmap.json"
	 	#			jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}"fmap/"${sub}_dir-AP_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_epi.json"
		#			jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}"fmap/"${sub}_dir-PA_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_epi.json"
		#			jq '. + { "B0FieldSource": "B0map"}' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"	
					#jq 'del(.B0FieldIdentifier)' "${SUBDIR}"fmap/"${sub}_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_fieldmap.json" 			
	 			fi
	 		done
	 	elif [ $num == 2 ]; then
	 		##### case with one repeat: two pairs AP-PA ###########
	 		echo "case with two pairs AP-PA"

			#jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_dir-AP_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/fmap/${sub}_run-1_fieldmap.json"
			#jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_dir-AP_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/fmap/${sub}_run-2_fieldmap.json"


			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_run-1_epi.json"
			#jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_run-1_fieldmap.json"
			

			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_run-2_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_run-2_epi.json"
			#jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_run-2_fieldmap.json"
			

			shim1=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_run-1_epi.json")	
			shim2=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_run-2_epi.json")

			list=$(ls "${SUBDIR}func/"*bold.nii.gz)



			for func in $list
			do
				shim3=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
				funci=${func//$SUBDIR/}
				if [ "$shim3" = "$shim1" ]
				then
					#jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"
		 			jq '. + { "B0FieldIdentifier": "B0map1"}' "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map1"}' "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"
					jq '. + { "B0FieldSource": "B0map1"}' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"
				elif [ "$shim3" = "$shim2" ]
				then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"
			 		jq '. + { "B0FieldIdentifier": "B0map2"}' "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map2"}' "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"
					jq '. + { "B0FieldSource": "B0map2"}' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"
				fi
			done
		fi
	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		OUTDIR=$EXPDIR/derivatives/topup/$sub/$ses
		SUBDIR=$EXPDIR/$sub/
		mkdir -p ${OUTDIR}
		pushd  ${SUBDIR}$ses/fmap
     	epi=$(ls sub-*dir-AP*epi*.nii.gz)
     	popd
     	num=$(echo $epi | wc -w)

     	if [ $num == 1 ];then
     		##### case with one pair AP-PA ###########
     		echo "case with one pair AP-PA"

		#	jq '. + { "Units": "Hz"}' "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/fmap/${sub}_${ses}_fieldmap.json"

			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"
		#	jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_fieldmap.json"

			shim1=$(jq .ShimSetting "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_epi.json") 
			B0arg="B0map${ses//ses-/}"
			jq --arg B0arg $B0arg '.B0FieldIdentifier |= .+ $B0arg' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"
			jq --arg B0arg $B0arg '.B0FieldIdentifier |= .+ $B0arg' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"
			

			list=$(ls "${SUBDIR}${ses}/func/"*bold.nii.gz)

			for func in $list
			do
        		shim2=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        		funci=${func//$SUBDIR/}
        		if [ "$shim2" = "$shim1" ]
        		then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					jq --arg B0arg $B0arg '.B0FieldSource |= .+ $B0arg' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_fieldmap.json"
				fi
			done
     	elif [ $num == 2 ];then
     		##### case with two pairs AP-PA ###########
     		echo "case with two pairs AP-PA"

		#	jq '. + { "Units": "Hz"}' "${SUBDIR}$ses//fmap/${sub}_${ses}_dir-AP_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses//fmap/${sub}_${ses}_run-1_fieldmap.json"
		#	jq '. + { "Units": "Hz"}' "${SUBDIR}$ses//fmap/${sub}_${ses}_dir-AP_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses//fmap/${sub}_${ses}_run-2_fieldmap.json"


			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
		#	jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"

			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
		#	jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"

			shim1=$(jq .ShimSetting "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_run-1_epi.json")	
			shim2=$(jq .ShimSetting "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_run-2_epi.json")
			B0arg1="B0map1${ses//es-/}"
			B0arg2="B0map2${ses//es-/}"
			jq --arg B0arg1 $B0arg1 '.B0FieldIdentifier |= .+ $B0arg1' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			jq --arg B0arg1 $B0arg1 '.B0FieldIdentifier |= .+ $B0arg1' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
			jq --arg B0arg2 $B0arg2 '.B0FieldIdentifier |= .+ $B0arg2' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
			jq --arg B0arg2 $B0arg2 '.B0FieldIdentifier |= .+ $B0arg2' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"


			list=$(ls "${SUBDIR}$ses/func/"*bold.nii.gz)
			for func in $list
			do
				shim3=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        		funci=${func//$SUBDIR/}
        		if [ "$shim3" = "$shim1" ]; then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					jq --arg B0arg1 $B0arg1 '.B0FieldSource |= .+ $B0arg1' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
				elif [ "$shim3" = "$shim2" ]; then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					jq --arg B0arg2 $B0arg2 '.B0FieldSource |= .+ $B0arg2' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"
				fi
			done
		elif [ $num == 3 ];then
     		##### case with three pairs AP-PA ###########
     		echo "case with three pairs AP-PA"

		#	jq '. + { "Units": "Hz"}' "${SUBDIR}$ses//fmap/${sub}_${ses}_dir-AP_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses//fmap/${sub}_${ses}_run-1_fieldmap.json"
		#	jq '. + { "Units": "Hz"}' "${SUBDIR}$ses//fmap/${sub}_${ses}_dir-AP_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses//fmap/${sub}_${ses}_run-2_fieldmap.json"


			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
		#	jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"

			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
		#	jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"

			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json"
			jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json"
		#	jq 'del(.IntendedFor)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-3_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-3_fieldmap.json"


			shim1=$(jq .ShimSetting "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_run-1_epi.json")	
			shim2=$(jq .ShimSetting "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_run-2_epi.json")
			shim3=$(jq .ShimSetting "${SUBDIR}$ses/fmap/${sub}_${ses}_dir-AP_run-3_epi.json")
			B0arg1="B0map1${ses//es-/}"
			B0arg2="B0map2${ses//es-/}"
			B0arg3="B0map3${ses//es-/}"
			jq --arg B0arg1 $B0arg1 '.B0FieldIdentifier |= .+ $B0arg1' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			jq --arg B0arg1 $B0arg1 '.B0FieldIdentifier |= .+ $B0arg1' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
			jq --arg B0arg2 $B0arg2 '.B0FieldIdentifier |= .+ $B0arg2' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
			jq --arg B0arg2 $B0arg2 '.B0FieldIdentifier |= .+ $B0arg2' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
			jq --arg B0arg3 $B0arg3 '.B0FieldIdentifier |= .+ $B0arg3' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json"
			jq --arg B0arg3 $B0arg3 '.B0FieldIdentifier |= .+ $B0arg3' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json" > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json"



			list=$(ls "${SUBDIR}$ses/func/"*bold.nii.gz)
			for func in $list
			do
				shimX=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        		funci=${func//$SUBDIR/}
        		if [ "$shimX" = "$shim1" ]; then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					jq --arg B0arg1 $B0arg1 '.B0FieldSource |= .+ $B0arg1' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
				elif [ "$shimX" = "$shim2" ]; then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					jq --arg B0arg2 $B0arg2 '.B0FieldSource |= .+ $B0arg2' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-2_fieldmap.json"
				elif [ "$shimX" = "$shim3" ]; then
				#	jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-3_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-3_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-AP_run-3_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_dir-PA_run-3_epi.json"
					jq 'del(.B0FieldSource)' "${func//.nii.gz/.json}"  > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
					jq --arg B0arg3 $B0arg3 '.B0FieldSource |= .+ $B0arg3' "${func//.nii.gz/.json}" > "tmp.$$.json" && mv  "tmp.$$.json" "${func//.nii.gz/.json}"
				#	jq 'del(.B0FieldIdentifier)' "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-3_fieldmap.json"  > "tmp.$$.json" && mv  "tmp.$$.json" "${SUBDIR}$ses/"fmap/"${sub}_${ses}_run-3_fieldmap.json"				
				fi
			done
		fi
	fi
done


