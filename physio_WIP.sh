#!/bin/sh

#script pour copier fichiers physio du dossier /data/physio vers les dossiers study/sourcedata/sub correspondant en les renommant

source ../Topup_Physio_BIDS/subjects_to_process.cfg
#read -p "quel est sont les noms des projets à traiter? (avec des espaces)" list_study
#list_study=Antisac_enfant
PHYSDIR=/Volumes/data/physio_PhantomPainSpine
#PHYSDIR=/Volumes/groupdata/physio_PhantomPainSpine

pushd $PHYSDIR
list_file=$(ls *bold.log)
#list_file=$(ls *Info.log)
popd
arrlistfile=($list_file)

physiotime=
physio_time=

for physio in $list_file
do

	physdate=$(echo  $physio | cut -d'_' -f 1)
	phystime=$(echo  $physio | cut -d'_' -f 2)

	physio_time=${physdate}_${phystime}
	physiotime="$physiotime $physio_time"

done

arrphysio=($physiotime)
echo $physiotime


#EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#EXPDIR=/Volumes/data/MRI_BIDS_DATABANK_TEMP/$study
EXPDIR=/Volumes/data3/MRI_BIDS_DATABANK/$study

for sub in $list_sub
do

    sub=sub-${sub}
    ses=$list_ses
    ses=ses-${ses}
    functime_min=
    funcdate=
    listfunc=


    echo -----starting subject ${sub}_${ses}------
    SUBDIR=$EXPDIR/${sub}/${ses}
    mkdir -p $EXPDIR/sourcedata/$sub/$ses/Physio
    list_func="$(ls $SUBDIR/func/*_bold.json)"
    arrlistfunc=($list_func)

	funcdate_time=

    for func in $list_func
    do
    	funcdate=$(jq '.AcquisitionDateTime' $func| cut -d'T' -f 1)
    	funcdate=$(echo $funcdate | cut -d'"' -f 2)
    	funcdate1=$(echo $funcdate | cut -d'-' -f 1)
    	funcdate2=$(echo $funcdate | cut -d'-' -f 2)
    	funcdate3=$(echo $funcdate | cut -d'-' -f 3)

    	functime=$(jq '.AcquisitionDateTime' $func| cut -d'T' -f 2)
    	functime=$(echo $functime | cut -d'"' -f 1)
    	functime=$(echo $functime | cut -d'.' -f 1)
    	functime1=$(echo $functime | cut -d':' -f 1)
    	if [ "${#functime1}" = 1 ];then
    		functime1="0$functime1"
    	fi

    	functime2=$(echo $functime | cut -d':' -f 2)
    	if [ "${#functime2}" = 1 ];then
    		functime2="0$functime2"
    	fi
    	functime3=$(echo $functime | cut -d':' -f 3)
    	if [ "${#functime3}" = 1 ];then
    		functime3="0$functime3"
    	fi

    	funcdatetime=${funcdate1}${funcdate2}${funcdate3}_${functime1}${functime2}${functime3}
    	funcdate_time="$funcdate_time $funcdatetime"
	done

	arrfunc=($funcdate_time)
	echo $funcdate_time


    for k in `seq 0 $((${#arrphysio[@]}-1))`
    do
    	for l in `seq 0 $((${#arrfunc[@]}-1))`
    	do
        	if [ "${arrphysio[k]}" = "${arrfunc[l]}" ] ; then

                echo "il y a le fichier func numero $l matche avec physio numero $k)"
                cp $PHYSDIR/"${arrlistfile[k]}" $EXPDIR/sourcedata/$sub/$ses/Physio/.
                base_phys1=$(echo "${arrlistfile[k]}" | cut -d'_' -f 1 )
                base_phys2=$(echo "${arrlistfile[k]}" | cut -d'_' -f 2 )
                cp $PHYSDIR/${base_phys1}_${base_phys2}_PULS.log $EXPDIR/sourcedata/$sub/$ses/Physio/.
                #cp $PHYSDIR/${base_phys1}_${base_phys2}_RESP.log $EXPDIR/sourcedata/$sub/$ses/Physio/.
                #cp $PHYSDIR/${base_phys1}_${base_phys2}_TriggerSignals.log $EXPDIR/sourcedata/$sub/$ses/Physio/.
                #cp $PHYSDIR/${base_phys1}_${base_phys2}_PhysioTriggertimes.log $EXPDIR/sourcedata/$sub/$ses/Physio/.
                cp $PHYSDIR/${base_phys1}_${base_phys2}_* $EXPDIR/sourcedata/$sub/$ses/Physio/.
            fi
        done
    done
done
 