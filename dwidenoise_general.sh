#!/bin/sh

source ../Topup_Physio_BIDS/subjects_to_process.cfg

#EXPDIR=/home/seinj/mygpdata/MRI_BIDS_DATABANK/$study
EXPDIR=~/Documents/Centre_IRMf/DATA/BIDS/$study
#EXPDIR=~/disks/meso_scratch/BIDS/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study

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
		echo "there is no ses"
		##### case with no "ses-" ###########

	else echo "there is ses"
		ses=ses-${ses}
		echo -----starting subject ${sub}_${ses}------
		OUTDIR=$EXPDIR/derivatives/dwidenoise/$sub/$ses
		SUBDIR=$EXPDIR/$sub/$ses
		mkdir -p ${OUTDIR}
		pushd  ${SUBDIR}/dwi
     	dwi=$(ls ${sub}_${ses}_dir-AP_dwi.nii.gz)
     	bval=$(ls ${sub}_${ses}_dir-AP_dwi.bval)
     	bvec=$(ls ${sub}_${ses}_dir-AP_dwi.bvec)
     	dwip=$(ls ${sub}_${ses}_part-phase_dir-AP_dwi.nii.gz)
     	bvalp=$(ls ${sub}_${ses}_part-phase_dir-AP_dwi.bval)
     	bvecp=$(ls ${sub}_${ses}_part-phase_dir-AP_dwi.bvec)
     	popd

     	dwidenoise $SUBDIR/dwi/$dwi $OUTDIR/${dwi/dwi.nii.gz/rec-denmag_dwi.nii.gz}

     	mrconvert $SUBDIR/dwi/$dwi -fslgrad $SUBDIR/dwi/$bvec $SUBDIR/dwi/$bval $OUTDIR/${dwi/dwi.nii.gz/dwi.mif}
     	mrconvert $SUBDIR/dwi/$dwip -fslgrad $SUBDIR/dwi/$bvecp $SUBDIR/dwi/$bvalp $OUTDIR/${dwip/dwi.nii.gz/dwi.mif}
     	mrcalc $OUTDIR/${dwip/dwi.nii.gz/dwi.mif} 4096 -add 4050 -divide pi -multiply $OUTDIR/${dwip/dwi.nii.gz/dwi_rad.mif} -force
     	mrcalc $OUTDIR/${dwi/dwi.nii.gz/dwi.mif} $OUTDIR/${dwip/dwi.nii.gz/dwi_rad.mif} -polar $OUTDIR/${dwip/dwi.nii.gz/dwi_complex.mif} -force
     	dwidenoise $OUTDIR/${dwip/dwi.nii.gz/dwi_complex.mif} $OUTDIR/${dwip/dwi.nii.gz/dwi_den_complex.mif} -noise $OUTDIR/${dwip/dwi.nii.gz/noise.mif} -force
     	mrcalc $OUTDIR/${dwip/dwi.nii.gz/dwi_den_complex.mif} -abs $OUTDIR/${dwi/dwi.nii.gz/rec-dencomplex_dwi.nii.gz} -force
     fi
done

