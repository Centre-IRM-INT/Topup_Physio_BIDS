#!/bin/sh


# Code to run topup on PEPOLAR type fieldmap, to generate a magnitude image and a fieldmap in Hz for use in SPM.
# Inputs are two SE-EPI images with reversed phase encoding, with 3 volumes each.
# written by Julien Sein, 2023-06-13, julien.sein@univ-amu.fr

source ~/JUL/Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study
#EXPDIR=~/Documents/Centre_IRMf/DATA/BIDS/$study
#EXPDIR=~/disks/meso_scratch/BIDS/$study


for sub in $list_sub
do
	sub=sub-${sub}
	ses=$list_ses


	if [ -z ${ses} ]; then
		##### case with no "ses-" ###########
		echo "there is no session"
		echo -----starting subject $sub------
		OUTDIR=/$EXPDIR/derivatives/topup/$sub
		SUBDIR=$EXPDIR/$sub/
		mkdir -p ${OUTDIR}
	 	pushd  $SUBDIR/fmap
     	epi=$(ls sub-*dir-AP*epi*.nii.gz)
     	popd
     	num=$(echo $epi | wc -w)

     	if [ $num == 1 ];then
     		##### case with one pair AP-PA ###########
     		echo "case with one pair AP-PA"

			fslmerge -t "${OUTDIR}/${sub}_FieldmapAP_PA"  "${SUBDIR}fmap/${sub}_dir-AP_epi.nii.gz" "${SUBDIR}fmap/${sub}_dir-PA_epi.nii.gz"


			RT=$(jq .TotalReadoutTime "${SUBDIR}fmap/${sub}_dir-AP_epi.json")

			direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_dir-AP_epi.json")
			direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_dir-PA_epi.json")
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
			echo -e  "$phase1 $RT\n$phase1 $RT\n$phase1 $RT\n$phase2 $RT\n$phase2 $RT\n$phase2 $RT" > ${OUTDIR}/${sub}_acqparamsAP_PA.txt

			# Correct for EVEN number of slices to use b02b0.cnf
			dimz=`fslval ${OUTDIR}/${sub}_FieldmapAP_PA.nii.gz dim3`
			if [ `expr $dimz % 2` -eq 1 ]; then
    			echo "remove one slice to get odd number of slices"
    			#fslroi ${OUTDIR}/${sub}_FieldmapAP_PA.nii.gz ${OUTDIR}/${sub}_FieldmapAP_PA.nii.gz 0 -1 0 -1 1 -1 0 -1
    			#topup --imain="${OUTDIR}/${sub}_FieldmapAP_PA" --datain="${OUTDIR}/${sub}_acqparamsAP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}fmap/${sub}_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images"
    			# to use topup config file for odd slices uncomment line below and comment lines above
    			echo "odd number of slices: run topup with specific config file"
    			topup --imain="${OUTDIR}/${sub}_FieldmapAP_PA" --datain="${OUTDIR}/${sub}_acqparamsAP_PA.txt" --config=/usr/local/fsl/etc/flirtsch/b02b0_1.cnf --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}fmap/${sub}_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images"

 			else       
 				topup --imain="${OUTDIR}/${sub}_FieldmapAP_PA" --datain="${OUTDIR}/${sub}_acqparamsAP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}fmap/${sub}_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images"
			fi

			# new line to extract first volume
			fslroi "${SUBDIR}fmap/${sub}_fieldmap" "${SUBDIR}fmap/${sub}_fieldmap" 0 1

			jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_dir-AP_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/fmap/${sub}_fieldmap.json"

#
			fslmaths "${OUTDIR}/${sub}_my_unwarped_images" -Tmean "${SUBDIR}fmap/${sub}_magnitude"

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
	 				jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}${ses}/"fmap/"${sub}_dir-AP_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_dir-AP_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}${ses}/"fmap/"${sub}_dir-PA_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_dir-PA_epi.json"
					jq '. + { "B0FieldSource": "B0map"}' "${func//nii.gz/json}" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${func//nii.gz/json}"	
					jq 'del(.B0FieldSource)' "${SUBDIR}"fmap/"${sub}_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_fieldmap.json" 			
	 			fi
	 		done
	 	elif [ $num == 2 ]; then
	 		##### case with one repeat: 4 pairs AP-PA ###########
	 		echo "case with two pairs AP-PA"

			fslmerge -t "${OUTDIR}/${sub}_Fieldmap1AP_PA"  "${SUBDIR}fmap/${sub}_dir-AP_run-1_epi.nii.gz" "${SUBDIR}fmap/${sub}_dir-PA_run-1_epi.nii.gz"
			fslmerge -t "${OUTDIR}/${sub}_Fieldmap2AP_PA"  "${SUBDIR}fmap/${sub}_dir-AP_run-2_epi.nii.gz" "${SUBDIR}fmap/${sub}_dir-PA_run-2_epi.nii.gz"


			RT=$(jq .TotalReadoutTime "${SUBDIR}fmap/${sub}_dir-AP_run-1_epi.json")

			direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_dir-AP_run-1_epi.json")
			direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_dir-PA_run-1_epi.json")
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
			echo   "$phase1 $RT\n$phase1 $RT\n$phase1 $RT\n$phase2 $RT\n$phase2 $RT\n$phase2 $RT" > ${OUTDIR}/${sub}_acqparams1AP_PA.txt

			RT=$(jq .TotalReadoutTime "${SUBDIR}fmap/${sub}_dir-AP_run-2_epi.json")

			direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_dir-AP_run-2_epi.json")
			direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}fmap/${sub}_dir-PA_run-2_epi.json")
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
			echo   "$phase1 $RT\n$phase1 $RT\n$phase1 $RT\n$phase2 $RT\n$phase2 $RT\n$phase2 $RT" > ${OUTDIR}/${sub}_acqparams2AP_PA.txt

			# Correct for EVEN number of slices to use b02b0.cnf
			dimz=`fslval ${OUTDIR}/${sub}_Fieldmap1AP_PA.nii.gz dim3`
			if [ `expr $dimz % 2` -eq 1 ]; then
    			#echo "remove one slice to get odd number of slices"
    			#fslroi ${OUTDIR}/${sub}_Fieldmap1AP_PA.nii.gz ${OUTDIR}/${sub}_Fieldmap1AP_PA.nii.gz 0 -1 0 -1 1 -1 0 -1
    			#topup --imain="${OUTDIR}/${sub}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_acqparams1AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}fmap/${sub}_run-1_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images1"
    			# to use topup config file for odd slices uncomment line below and comment lines above
    			echo "odd number of slices: run topup with specific config file"
    			topup --imain="${OUTDIR}/${sub}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_acqparams1AP_PA.txt" --config="/usr/local/fsl/etc/flirtsch/b02b0_1.cnf" --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}fmap/${sub}_run-1_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images1"
 			else       
 				topup --imain="${OUTDIR}/${sub}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_acqparams1AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}fmap/${sub}_run-1_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images1"
			fi

			dimz=`fslval ${OUTDIR}/${sub}_Fieldmap2AP_PA.nii.gz dim3`
			if [ `expr $dimz % 2` -eq 1 ]; then
    			#echo "remove one slice to get odd number of slices"
    			#fslroi ${OUTDIR}/${sub}_Fieldmap2AP_PA.nii.gz ${OUTDIR}/${sub}_Fieldmap2AP_PA.nii.gz 0 -1 0 -1 1 -1 0 -1
    			#topup --imain="${OUTDIR}/${sub}_Fieldmap2AP_PA" --datain="${OUTDIR}/${sub}_acqparams2AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_my_topup_results2" --fout="${SUBDIR}fmap/${sub}_run-2_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images2"
    			# to use topup config file for odd slices uncomment line below and comment lines above
    			echo "odd number of slices: run topup with specific config file"
    			topup --imain="${OUTDIR}/${sub}_Fieldmap2AP_PA" --datain="${OUTDIR}/${sub}_acqparams2AP_PA.txt" --config="/usr/local/fsl/etc/flirtsch/b02b0_1.cnf" --out="${OUTDIR}/${sub}_my_topup_results2" --fout="${SUBDIR}fmap/${sub}_run-2_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images2"
 			else       
    			topup --imain="${OUTDIR}/${sub}_Fieldmap2AP_PA" --datain="${OUTDIR}/${sub}_acqparams2AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_my_topup_results2" --fout="${SUBDIR}fmap/${sub}_run-2_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images2"
			fi


			# new line to extract first volume
			fslroi "${SUBDIR}fmap/${sub}_run-1_fieldmap" "${SUBDIR}fmap/${sub}_run-1_fieldmap" 0 1
			fslroi "${SUBDIR}fmap/${sub}_run-2_fieldmap" "${SUBDIR}fmap/${sub}_run-2_fieldmap" 0 1
			#
			jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_dir-AP_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/fmap/${sub}_run-1_fieldmap.json"
			jq '. + { "Units": "Hz"}' "${SUBDIR}/fmap/${sub}_dir-AP_run-2_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/fmap/${sub}_run-2_fieldmap.json"


			fslmaths "${OUTDIR}/${sub}_my_unwarped_images1" -Tmean "${SUBDIR}fmap/${sub}_run-1_magnitude"
			fslmaths "${OUTDIR}/${sub}_my_unwarped_images2" -Tmean "${SUBDIR}fmap/${sub}_run-2_magnitude"

			#list=$(ls "${SUBDIR}func/"*acq-2mm*bold.nii.gz)
			#list_func=${list//$SUBDIR/}

			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_run-1_fieldmap.json"
			

			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-AP_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-AP_run-2_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_dir-PA_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_dir-PA_run-2_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}/"fmap/"${sub}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}/"fmap/"${sub}_run-2_fieldmap.json"
			

			shim1=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_run-1_epi.json")	
			shim2=$(jq .ShimSetting "${SUBDIR}fmap/${sub}_dir-AP_run-2_epi.json")

			list=$(ls "${SUBDIR}func/"*bold.nii.gz)



			for func in $list
			do
				shim3=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
				funci=${func//$SUBDIR/}
				if [ "$shim3" = "$shim1" ]
				then
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"
		 			jq '. + { "B0FieldIdentifier": "B0map1"}' "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-1_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map1"}' "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-1_epi.json"
					jq '. + { "B0FieldSource": "B0map1"}' "${func//nii.gz/json}" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${func//nii.gz/json}"
					jq 'del(.B0FieldSource)' "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-1_fieldmap.json"
				elif [ "$shim3" = "$shim2" ]
				then
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"
			 		jq '. + { "B0FieldIdentifier": "B0map2"}' "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-AP_run-2_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map2"}' "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_dir-PA_run-2_epi.json"
					jq '. + { "B0FieldSource": "B0map2"}' "${func//nii.gz/json}" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${func//nii.gz/json}"
					jq 'del(.B0FieldSource)' "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}"fmap/"${sub}_run-2_fieldmap.json"
				fi
			done
		fi
	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		OUTDIR=$EXPDIR/derivatives/topup/$sub/${ses}
		SUBDIR=$EXPDIR/$sub/
		mkdir -p ${OUTDIR}
		pushd  ${SUBDIR}${ses}/fmap
     	epi=$(ls sub-*dir-AP*epi*.nii.gz)
     	popd
     	num=$(echo $epi | wc -w)

     	if [ $num == 1 ];then
     		##### case with one pair AP-PA ###########
     		echo "case with one pair AP-PA"

     		if [[ -n $(find ${SUBDIR}${ses}/fmap/  -type f -name "*run-1*" 2>/dev/null) ]]
				then echo "#### There is run in name ####"
				run="_run-1"
			else
				run=""
			fi

			#fslmerge -t "${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA"  "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.nii.gz" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_run-1_epi.nii.gz"
			fslmerge -t "${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA"  "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP${run}_epi.nii.gz" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA${run}_epi.nii.gz"

			#RT=$(jq .TotalReadoutTime "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.json")
			RT=$(jq .TotalReadoutTime "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP${run}_epi.json")

			#direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.json")
			#direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_run-1_epi.json")
			direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP${run}_epi.json")
			direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA${run}_epi.json")
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
			echo -e   "$phase1 $RT\n$phase1 $RT\n$phase1 $RT\n$phase2 $RT\n$phase2 $RT\n$phase2 $RT" > ${OUTDIR}/${sub}_${ses}_acqparams1AP_PA.txt

			# Correct for EVEN number of slices to use b02b0.cnf
			dimz=`fslval ${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA.nii.gz dim3`
			if [ `expr $dimz % 2` -eq 1 ]; then
    			#echo "remove one slice to get odd number of slices"
    			#fslroi ${OUTDIR}/${sub}_${ses}_FieldmapAP_PA.nii.gz ${OUTDIR}/${sub}_${ses}_FieldmapAP_PA.nii.gz 0 -1 0 -1 1 -1 0 -1
    			#topup --imain="${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_${ses}_acqparamsAP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_${ses}_my_topup_results" --fout="${SUBDIR}${ses}/fmap/${sub}_${ses}_fieldmap" --iout="${OUTDIR}/${sub}_${ses}_my_unwarped_images"
    			# to use topup config file for odd slices uncomment line below and comment lines above
    			echo "odd number of slices: run topup with specific config file"
    			topup --imain="${OUTDIR}/${sub}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_acqparams1AP_PA.txt" --config="/usr/local/fsl/etc/flirtsch/b02b0_1.cnf" --out="${OUTDIR}/${sub}_${ses}_my_topup_results1" --fout="${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" --iout="${OUTDIR}/${sub}_${ses}_run-1_my_unwarped_images"

 			else       
 				topup --imain="${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_${ses}_acqparams1AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_${ses}_my_topup_results" --fout="${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" --iout="${OUTDIR}/${sub}_${ses}_run-1_my_unwarped_images"
			fi

			# new line to extract first volume
			fslroi "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" 0 1

			#jq '. + { "Units": "Hz"}' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap.json"
			jq '. + { "Units": "Hz"}' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP${run}_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap.json"


			fslmaths "${OUTDIR}/${sub}_${ses}_run-1_my_unwarped_images" -Tmean "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_magnitude"

			#jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			#jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP${run}_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP${run}_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA${run}_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA${run}_epi.json"
			
			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"

			#shim1=$(jq .ShimSetting "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.json") 
			shim1=$(jq .ShimSetting "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP${run}_epi.json") 

			list=$(ls "${SUBDIR}${ses}/func/"*bold.nii.gz)

			for func in $list
			do
        		shim2=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        		funci=${func//$SUBDIR/}
        		if [ "$shim2" = "$shim1" ]
        		then
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
					#jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
					#jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
					#jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
					#jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP${run}_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP${run}_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA${run}_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA${run}_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP${run}_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP${run}_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA${run}_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA${run}_epi.json"
					jq '. + { "B0FieldSource": "B0map"}' "${func//nii.gz/json}" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${func//nii.gz/json}"
					jq 'del(.B0FieldSource)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
				fi
			done
     	elif [ $num == 2 ];then
     		##### case with two pairs AP-PA ###########
     		echo "case with two pairs AP-PA"

			fslmerge -t "${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA"  "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.nii.gz" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_run-1_epi.nii.gz"
			fslmerge -t "${OUTDIR}/${sub}_${ses}_Fieldmap2AP_PA"  "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-2_epi.nii.gz" "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_run-2_epi.nii.gz"


			RT=$(jq .TotalReadoutTime "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.json")

			direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.json")
			direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_run-1_epi.json")
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
			echo   "$phase1 $RT\n$phase1 $RT\n$phase1 $RT\n$phase2 $RT\n$phase2 $RT\n$phase2 $RT" > ${OUTDIR}/${sub}_${ses}_acqparams1AP_PA.txt

			RT=$(jq .TotalReadoutTime "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-2_epi.json")

			direction1=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-2_epi.json")
			direction2=$(jq '.PhaseEncodingDirection' "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-PA_run-2_epi.json")
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
			echo   "$phase1 $RT\n$phase1 $RT\n$phase1 $RT\n$phase2 $RT\n$phase2 $RT\n$phase2 $RT" > ${OUTDIR}/${sub}_${ses}_acqparams2AP_PA.txt

			# Correct for EVEN number of slices to use b02b0.cnf
			dimz=`fslval ${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA.nii.gz dim3`
			if [ `expr $dimz % 2` -eq 1 ]; then
    			#echo "remove one slice to get odd number of slices for 1st fieldmap"
    			#fslroi ${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA.nii.gz ${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA.nii.gz 0 -1 0 -1 1 -1 0 -1
    			#topup --imain="${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_${ses}_acqparams1AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_${ses}_my_topup_results1" --fout="${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" --iout="${OUTDIR}/${sub}_${ses}_my_unwarped_images1"
    			# to use topup config file for odd slices uncomment line below and comment lines above
    			echo "odd number of slices: run topup with specific config file"
    			topup --imain="${OUTDIR}/${sub}_FieldmapAP_PA" --datain="${OUTDIR}/${sub}_acqparamsAP_PA.txt" --config="/usr/local/fsl/etc/flirtsch/b02b0_1.cnf" --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}${ses}/fmap/${sub}_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images"
    		else       
 				topup --imain="${OUTDIR}/${sub}_${ses}_Fieldmap1AP_PA" --datain="${OUTDIR}/${sub}_${ses}_acqparams1AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_${ses}_my_topup_results1" --fout="${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" --iout="${OUTDIR}/${sub}_${ses}_my_unwarped_images1"
	
			fi

			# Correct for EVEN number of slices to use b02b0.cnf
			dimz=`fslval ${OUTDIR}/${sub}_${ses}_Fieldmap2AP_PA.nii.gz dim3`
			if [ `expr $dimz % 2` -eq 1 ]; then
    			#echo "remove one slice to get odd number of slice for 2nd fieldmap"
    			#fslroi ${OUTDIR}/${sub}_${ses}_Fieldmap2AP_PA.nii.gz ${OUTDIR}/${sub}_${ses}_Fieldmap2AP_PA.nii.gz 0 -1 0 -1 1 -1 0 -1
    			#topup --imain="${OUTDIR}/${sub}_${ses}_Fieldmap2AP_PA" --datain="${OUTDIR}/${sub}_${ses}_acqparams2AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_${ses}_my_topup_results2" --fout="${SUBDIR}${ses}/fmap/${sub}_${ses}_run-2_fieldmap" --iout="${OUTDIR}/${sub}_${ses}_my_unwarped_images2"
    			# to use topup config file for odd slices uncomment line below and comment lines above
    			echo "odd number of slices: run topup with specific config file"
    			topup --imain="${OUTDIR}/${sub}_FieldmapAP_PA" --datain="${OUTDIR}/${sub}_acqparamsAP_PA.txt" --config="/usr/local/fsl/etc/flirtsch/b02b0_1.cnf" --out="${OUTDIR}/${sub}_my_topup_results1" --fout="${SUBDIR}${ses}/fmap/${sub}_fieldmap" --iout="${OUTDIR}/${sub}_my_unwarped_images"

 			else       
 				topup --imain="${OUTDIR}/${sub}_${ses}_Fieldmap2AP_PA" --datain="${OUTDIR}/${sub}_${ses}_acqparams2AP_PA.txt" --config=b02b0.cnf --out="${OUTDIR}/${sub}_${ses}_my_topup_results2" --fout="${SUBDIR}${ses}/fmap/${sub}_${ses}_run-2_fieldmap" --iout="${OUTDIR}/${sub}_${ses}_my_unwarped_images2"

			fi

			# new line to extract first volume
			fslroi "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_fieldmap" 0 1
			fslroi "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-2_fieldmap" "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-2_fieldmap" 0 1

			jq '. + { "Units": "Hz"}' "${SUBDIR}${ses}//fmap/${sub}_${ses}_dir-AP_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}//fmap/${sub}_${ses}_run-1_fieldmap.json"
			jq '. + { "Units": "Hz"}' "${SUBDIR}${ses}//fmap/${sub}_${ses}_dir-AP_run-2_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}//fmap/${sub}_${ses}_run-2_fieldmap.json"


			fslmaths "${OUTDIR}/${sub}_${ses}_my_unwarped_images1" -Tmean "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-1_magnitude"
			fslmaths "${OUTDIR}/${sub}_${ses}_my_unwarped_images2" -Tmean "${SUBDIR}${ses}/fmap/${sub}_${ses}_run-2_magnitude"

			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"

			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
			jq 'del(.IntendedFor)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-2_fieldmap.json"

			shim1=$(jq .ShimSetting "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-1_epi.json")	
			shim2=$(jq .ShimSetting "${SUBDIR}${ses}/fmap/${sub}_${ses}_dir-AP_run-2_epi.json")

			list=$(ls "${SUBDIR}${ses}/func/"*bold.nii.gz)
			for func in $list
			do
				shim3=$(jq .'ShimSetting' ${func//"nii.gz"/"json"})
        		funci=${func//$SUBDIR/}
        		if [ "$shim3" = "$shim1" ]; then
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map1"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-1_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map1"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-1_epi.json"
					jq '. + { "B0FieldSource": "B0map1"}' "${func//nii.gz/json}" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${func//nii.gz/json}"
					jq 'del(.B0FieldSource)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-1_fieldmap.json"
				elif [ "$shim3" = "$shim2" ]; then
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-2_fieldmap.json"
					jq --arg func $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
					jq --arg funci $funci  '.IntendedFor |= .+  [$funci]' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map2"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-AP_run-2_epi.json"
					jq '. + { "B0FieldIdentifier": "B0map2"}' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_dir-PA_run-2_epi.json"
					jq '. + { "B0FieldSource": "B0map2"}' "${func//nii.gz/json}" > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${func//nii.gz/json}"
					jq 'del(.B0FieldSource)' "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-2_fieldmap.json"  > "${OUTDIR}/tmp.$$.json" && mv  "${OUTDIR}/tmp.$$.json" "${SUBDIR}${ses}/"fmap/"${sub}_${ses}_run-2_fieldmap.json"
				fi
			done
		fi
	fi
done


