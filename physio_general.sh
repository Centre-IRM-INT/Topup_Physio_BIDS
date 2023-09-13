#!/bin/sh

#script pour copier fichiers physio du dossier /data/physio vers les dossiers study/sourcedata/sub correspondant en les renommant

source ../Topup_Physio_BIDS/subjects_to_process.cfg
#read -p "quel est sont les noms des projets à traiter? (avec des espaces)" list_study
#list_study=Antisac_enfant
PHYSDIR=/Volumes/data/physio
#PHYSDIR=/Volumes/groupdata/physio

list_file=$(ls $PHYSDIR)
list_file=$(ls $PHYSDIR/*_Info.log)
arrlistfile=($list_file)

arrUUIDphys=

for physio in $list_file
do
    UUID=$(cat $physio | grep 'UUID' | cut -d'=' -f 2 | cut -d ' ' -f 2)

    arrUUIDphys="$arrUUIDphys $UUID"
done

arrUUIDphys=($arrUUIDphys)



EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study


for sub in $list_sub
do
    sub=sub-${sub}
    ses=$list_ses

    if [ -z $ses ]; then
        ##### case with no "ses-" ###########
        echo "there is no session"
 
        echo -----starting subject $sub------

        arrUUIDfunc=


        SUBDIR=$EXPDIR/$sub
        mkdir -p $EXPDIR/sourcedata/$sub
        list_func="$(ls $SUBDIR/func/*_bold.json)"
        arrlistfunc=($list_func)

        for func in $list_func
        do
            UUID=$(jq .WipMemBlock $func | cut -d'|' -f 1 | cut -d'"' -f 2)
            arrUUIDfunc="$arrUUIDfunc $UUID"
        done

        arrUUIDfunc=($arrUUIDfunc)


        for k in `seq 0 $((${#arrUUIDphys[@]}-1))`
        do
            for l in `seq 0 $((${#arrUUIDfunc[@]}-1))`
            do
                if [ "${arrUUIDphys[k]}" = "${arrUUIDfunc[l]}" ] ; then

                    funcfilejson=$(echo "${arrlistfunc[l]}"| cut -d'/' -f 8)
                    funcfile=$(echo $funcfilejson| cut -d'.' -f 1)
                    echo "il y a le fichier func $funcfile qui matche avec physio numero $k)"
                    log_file=$(echo ${arrlistfile[k]}| cut -d'/' -f 5)
                    log_file_PULS=${log_file/Info/PULS}
                    log_file_RESP=${log_file/Info/RESP}
                    cp -n "$PHYSDIR/$log_file" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_Info.log"
                    #cp -n "/Volumes/groupdata/physio_old/$log_file" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_Info.log"
                    time0=$(awk 'NR==10 {print $3}' ${arrlistfile[k]})
                    if  [ -e "$PHYSDIR/$log_file_PULS" ]; then
                        cp -n "$PHYSDIR/$log_file_PULS" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_PULS.log"
                        # if  [ -e "/Volumes/groupdata/physio_old/$log_file_PULS" ]; then
                        #cp -n "/Volumes/groupdata/physio_old/$log_file_PULS" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_PULS.log"
                        awk 'NR>8 && ($1>="'$time0'") {print$3 }' ${arrlistfile[k]/Info/PULS} > $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.tsv"
                        gzip $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.tsv"
                        jq -n ' { "Units": "Hz", "SamplingFrequency": 200,"StartTime": 0, "Columns": ["cardiac"] }'  > $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.json"
                    fi
                    if  [ -e "$PHYSDIR/$log_file_RESP" ]; then
                        cp -n "$PHYSDIR/$log_file_RESP" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_RESP.log"
                        #if  [ -e "/Volumes/groupdata/physio_old/$log_file_RESP" ]; then
                        #cp -n "/Volumes/groupdata/physio_old/$log_file_RESP" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_RESP.log"
                        awk 'NR>8 && ($1>="'$time0'") {print$3 }' ${arrlistfile[k]/Info/RESP} > $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.tsv"
                        jq -n ' { "Units": "Hz", "SamplingFrequency": 50,"StartTime": 0, "Columns": ["respiratory"]  }'  > $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.json"
                        gzip $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.tsv"
                    fi
                fi
            done
        done
    else echo "there is ses"
    ses=ses-${ses}
    echo -----starting subject ${sub}_${ses}------
    SUBDIR=$EXPDIR/${sub}/${ses}
    mkdir -p $EXPDIR/sourcedata/$sub/$ses
    list_func="$(ls $SUBDIR/func/*_bold.json)"
    arrlistfunc=($list_func)

    arrUUIDfunc=

        for func in $list_func
        do
            UUID=$(jq .WipMemBlock $func | cut -d'|' -f 1 | cut -d'"' -f 2)
            arrUUIDfunc="$arrUUIDfunc $UUID"
        done

        arrUUIDfunc=($arrUUIDfunc)

        for k in `seq 0 $((${#arrUUIDphys[@]}-1))`
        do
            for l in `seq 0 $((${#arrUUIDfunc[@]}-1))`
            do
                if [ "${arrUUIDphys[k]}" = "${arrUUIDfunc[l]}" ] ; then

                    funcfilejson=$(echo "${arrlistfunc[l]}"| cut -d'/' -f 9)
                    funcfile=$(echo $funcfilejson| cut -d'.' -f 1)
                    echo "il y a le fichier func $funcfile qui matche avec physio numero $k)"
                    log_file=$(echo ${arrlistfile[k]}| cut -d'/' -f 5)
                    log_file_PULS=${log_file/Info/PULS}
                    log_file_RESP=${log_file/Info/RESP}
                    cp -n "$PHYSDIR/$log_file" $EXPDIR/sourcedata/$sub/$ses/"Physio_"$funcfile"_Info.log"
                    #cp -n "/Volumes/groupdata/physio_old/$log_file" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_Info.log"
                    time0=$(awk 'NR==10 {print $3}' ${arrlistfile[k]})
                    if  [ -e "$PHYSDIR/$log_file_PULS" ]; then
                        cp -n "$PHYSDIR/$log_file_PULS" $EXPDIR/sourcedata/$sub/$ses/"Physio_"$funcfile"_PULS.log"
                        # if  [ -e "/Volumes/groupdata/physio_old/$log_file_PULS" ]; then
                        #cp -n "/Volumes/groupdata/physio_old/$log_file_PULS" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_PULS.log"
                        awk 'NR>8 && ($1>="'$time0'") {print$3 }' ${arrlistfile[k]/Info/PULS} > $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.tsv"
                        gzip $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.tsv"
                        jq -n ' { "Units": "Hz", "SamplingFrequency": 200,"StartTime": 0, "Columns": ["cardiac"] }'  > $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.json"
                    fi
                    if  [ -e "$PHYSDIR/$log_file_RESP" ]; then
                        cp -n "$PHYSDIR/$log_file_RESP" $EXPDIR/sourcedata/$sub/$ses/"Physio_"$funcfile"_RESP.log"
                        #if  [ -e "/Volumes/groupdata/physio_old/$log_file_RESP" ]; then
                        #cp -n "/Volumes/groupdata/physio_old/$log_file_RESP" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_RESP.log"
                        awk 'NR>8 && ($1>="'$time0'") {print$3 }' ${arrlistfile[k]/Info/RESP} > $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.tsv"
                        jq -n ' { "Units": "Hz", "SamplingFrequency": 50,"StartTime": 0, "Columns": ["respiratory"]  }'  > $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.json"
                        gzip $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.tsv"
                    fi
                fi
            done
        done
    fi
done
    
