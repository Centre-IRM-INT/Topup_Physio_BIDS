

cd /Volumes/groupdata/MRI_BIDS_DATABANK/GestImage

list_sub=$(ls -d sub*)

echo "suject session dim1_T1 dim2_T1 dim3_T1 pixdim1_T1 pixdim2_T1 pixdim3_T1 \
dim1_T2 dim2_T2 dim3_T2 pixdim1_T2 pixdim2_T2 pixdim3_T2 \
dim1_DWAP dim2_DWAP dim3_DWAP dim4_DWAP pixdim1_DWAP pixdim2_DWAP pixdim3_DWAP \
dim1_DWPA dim2_DWPA dim3_DWPA dim4_DWPA pixdim1_DWPA pixdim2_DWPA pixdim3_DWPA" \
> /Volumes/groupdata/MRI_BIDS_DATABANK/GestImage/params_GestImage.txt

for sub in $list_sub
do
	echo "checking subject: ${sub/sub-/}..."
	pushd $sub
	list_ses=$(ls -d ses-*)
	for ses in $list_ses
	do 
		echo "checking session: ${ses}..."

		if [ $ses == 'ses-T0' ] || [ $ses == 'ses-T1' ]
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


				elif [ $sub == 'sub-Alf' ] || [ $sub == 'sub-Arthur' ] || [ $sub == 'sub-Babar' ] || [ $sub == 'sub-Bibou' ] || [ $sub == 'sub-Calisto' ] || [ $sub == 'sub-Chet' ] || [ $sub == 'sub-Clara' ] || [ $sub == 'sub-Feline' ] || [ $sub == 'sub-Fidji' ] || [ $sub == 'sub-Fildar' ] || [ $sub == 'sub-Filosophie' ] || [ $sub == 'sub-Geraldine' ] || [ $sub == 'sub-Odin' ] || [ $sub == 'sub-Noe' ] || [ $sub == 'sub-IvarJr' ]|| [ $sub == 'sub-Icono' ]|| [ $sub == 'sub-Steffie' ]
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

			elif [ $sub == 'sub-Oasis' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


			elif [ $sub == 'sub-Oceane' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

					elif [ $sub == 'sub-Rouky' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


					elif [ $sub == 'sub-Puma' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


					elif [ $sub == 'sub-Prouesse' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


					elif [ $sub == 'sub-Phyllis' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


					elif [ $sub == 'sub-Odor' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


					elif [ $sub == 'sub-Oceane' ] && [ $ses == 'ses-T2' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


	elif [ $sub == 'sub-Popeye' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		elif [ $sub == 'sub-Picsou' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


	elif [ $sub == 'sub-Pesto' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		elif [ $sub == 'sub-Pepita' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

	elif [ $sub == 'sub-Pau' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


		elif [ $sub == 'sub-Patouille' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

	elif [ $sub == 'sub-Papou' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

	elif [ $sub == 'sub-Palme' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

	elif [ $sub == 'sub-Ozone' ] && [ $ses == 'ses-T2' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

	elif [ $sub == 'sub-Ozone' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

	elif [ $sub == 'sub-Ota' ] && [ $ses == 'ses-T1' ] 
		 	then

		
		pixdim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)







			else 

		pixdim1_T1=$(fslinfo $ses/anat/sub*run*T1w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T1=$(fslinfo $ses/anat/sub*run*T1w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T1=$(fslinfo $ses/anat/sub*run*T1w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T1=$(fslinfo $ses/anat/sub*run*T1w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T1=$(fslinfo $ses/anat/sub*run*T1w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T1=$(fslinfo $ses/anat/sub*run*T1w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#T2w
		pixdim1_T2=$(fslinfo $ses/anat/sub*T2w.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_T2=$(fslinfo $ses/anat/sub*T2w.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_T2=$(fslinfo $ses/anat/sub*T2w.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)
		dim1_T2=$(fslinfo $ses/anat/sub*T2w.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_T2=$(fslinfo $ses/anat/sub*T2w.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_T2=$(fslinfo $ses/anat/sub*T2w.nii* | grep '^dim3'  | cut -d$'\t' -f 3)

		#dwi_PA
		dim1_DWPA=$(fslinfo $ses/dwi/sub*PA*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWPA=$(fslinfo $ses/dwi/sub*PA*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWPA=$(fslinfo $ses/dwi/sub*PA*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWPA=$(fslinfo $ses/dwi/sub*PA*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWPA=$(fslinfo $ses/dwi/sub*PA*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWPA=$(fslinfo $ses/dwi/sub*PA*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWPA=$(fslinfo $ses/dwi/sub*PA*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)

		#dwi_AP
		dim1_DWAP=$(fslinfo $ses/dwi/sub*AP*dwi.nii* | grep '^dim1'  | cut -d$'\t' -f 3)
		dim2_DWAP=$(fslinfo $ses/dwi/sub*AP*dwi.nii* | grep '^dim2'  | cut -d$'\t' -f 3)
		dim3_DWAP=$(fslinfo $ses/dwi/sub*AP*dwi.nii* | grep '^dim3'  | cut -d$'\t' -f 3)
		dim4_DWAP=$(fslinfo $ses/dwi/*AP*dwi.nii* | grep '^dim4'  | cut -d$'\t' -f 3)
		pixdim1_DWAP=$(fslinfo $ses/dwi/sub*AP*dwi.nii* | grep 'pixdim1'  | cut -d$'\t' -f 3)
		pixdim2_DWAP=$(fslinfo $ses/dwi/sub*AP*dwi.nii* | grep 'pixdim2'  | cut -d$'\t' -f 3)
		pixdim3_DWAP=$(fslinfo $ses/dwi/sub*AP*dwi.nii* | grep 'pixdim3'  | cut -d$'\t' -f 3)


			fi
		#write into file

		echo "$sub $ses $dim1_T1 $dim2_T1 $dim3_T1 $pixdim1_T1 $pixdim2_T1 $pixdim3_T1 \
		$dim1_T2 $dim2_T2 $dim3_T2 $pixdim1_T2 $pixdim2_T2 $pixdim3_T2 \
		$dim1_DWAP $dim2_DWAP $dim3_DWAP $dim4_DWAP $pixdim1_DWAP $pixdim2_DWAP $pixdim3_DWAP \
		$dim1_DWPA $dim2_DWPA $dim3_DWPA $dim4_DWPA $pixdim1_DWPA $pixdim2_DWPA $pixdim3_DWPA" \
		>> /Volumes/groupdata/MRI_BIDS_DATABANK/GestImage/params_GestImage.txt

	done
	popd
done





