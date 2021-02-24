#!/bin/sh

#script pour copier fichiers physio du dossier /data/physio vers les dossiers study/sourcedata/sub correspondant en les renommant

source ~/hubic/JUL/Topup_Physio_BIDS/subjects_to_process.cfg
#read -p "quel est sont les noms des projets à traiter? (avec des espaces)" list_study
#list_study=Antisac_enfant
PHYSDIR=/Volumes/data/physio
#PHYSDIR=/Volumes/groupdata/physio_old

list_file=$(ls $PHYSDIR)
list_file=$(ls $PHYSDIR/*_Info.log)
arrlistfile=($list_file)

physiotime_min=
physiotime=
physiodate=

for physio in $list_file
do
time_tic=$(echo $(cat $physio | grep FirstTime) | cut -d'=' -f 2)
#time_tic2=$(echo $(sed '11q;d' $physio)  | cut -d' ' -f 3)
substring=$(echo $(cat $physio | grep ScanDate) | cut -d'=' -f 2)
physiodate="$physiodate $(echo $substring | cut -d'_' -f 1)"
time_s=$(echo "$time_tic * 2.5 * 0.001" | bc)
time_hour=$(echo "$time_s / 3600" | bc)
time_rest=$(echo "$time_s % 3600" | bc)
time_min=$(echo "$time_rest / 60" | bc)
time_sec=$(echo "$time_rest % 60" | bc)
time_sec=$(echo $time_sec | cut -d'.' -f 1)

#if (( time_hour < 10 ))
#then
#time_hour="0$time_hour"
##echo " "two digits" "
#fi

if (( time_min < 10 ))
then
time_min="0$time_min"
fi

if (( time_sec < 10 ))
then
time_sec="0$time_sec"
fi

physiotime="$physiotime $time_hour$time_min$time_sec"
physiotime_min="$physiotime_min $time_hour$time_min"
done

arrphysiotime_min=($physiotime_min)
arrphysiodate=($physiodate)


EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study
#read -p "quel est sont les noms des sujets à traiter? (avec des espaces)" list_sub
#list_sub=$(ls $EXPDIR)
#list_sub=$(echo "${list_sub//sourcedata_orig}")
#list_sub=$(echo "${list_sub//sourcedata}")
#list_sub=$(echo "${list_sub//Pilote-02}")
#list_sub=$(echo "${list_sub//participants.tsv}")
#list_sub=$(echo "${list_sub//dataset_description.json}")
#list_sub=$(echo "${list_sub//derivatives}")
#list_sub=$(echo "${list_sub//README}")

for sub in $list_sub
do

functime_min=
funcdate=
listfunc=

    sub=sub-${sub}
    echo -----starting subject $sub------
    SUBDIR=$EXPDIR/$sub
    mkdir -p $EXPDIR/sourcedata/$sub
    list_func="$(ls $SUBDIR/func/*_bold.json)"
    arrlistfunc=($list_func)

    for func in $list_func
    do
    timedate=$(echo $(jq '.AcquisitionDateTime' $func)| tr -d '"')
    funcdate="$funcdate $(echo $timedate | cut -d'T' -f 1)"
    functime1=$(echo $timedate | cut -d'T' -f 2)
    functime1=$(echo $functime1 | cut -d'.' -f 1)
    init=$(echo "$(echo $functime1 | head -c 1)")
    if [ $init  = 0 ]
    then
    functime1_min=${functime1:1:4}
    functime1_min2=${functime1:1:2}
    else
    functime1_min=${functime1:0:5}
    functime1_min2=${functime1:0:3}
    fi
    functime_min="$functime_min "$(echo $functime1_min)
    functime_min2="$functime_min2 "$(echo $functime1_min2)
    functime="$functime $(echo $functime1)"
    done

    funcdate=$(echo $funcdate | tr -d -)
    functime=$(echo $functime | tr -d :)
    functime_min=$(echo $functime_min | tr -d :)
    functime_min2=$(echo $functime_min2 | tr -d :)
    arrfuncdate=($funcdate)
    arrfunctime=($functime)
    arrfunctime_min=($functime_min)
    arrfunctime_min2=($functime_min2)

    for k in `seq 0 $((${#arrphysiotime_min[@]}-1))`
    do
    for l in `seq 0 $((${#arrfunctime_min[@]}-1))`
    do
        if [ "${arrphysiodate[k]}" = "${arrfuncdate[l]}" ] ; then

               if ( [[ $(( ${arrfunctime_min[l]}/100 )) = $(( (${arrfunctime_min[l]}-1)/100 )) ]] && ( [[ ${arrphysiotime_min[k]} = ${arrfunctime_min[l]} ]] || [[ ${arrphysiotime_min[k]} = ${arrfunctime_min[l]}+1 ]] || [[ $((${arrfunctime_min[l]}-1)) = ${arrphysiotime_min[k]} ]] ) ) || (  [[ $(( (${arrfunctime_min[l]}/100)-1 )) = $(( (${arrfunctime_min[l]}-1)/100 )) ]] && ( [[ ${arrphysiotime_min[k]} = ${arrfunctime_min[l]} ]] ||  [[ $((${arrfunctime_min[l]}-41)) = ${arrphysiotime_min[k]} ]] ))  ; then

                    echo "il y a le fichier func numero $l matche avec physio numero $k)"
                    log_file=$(echo ${arrlistfile[k]}| cut -d'/' -f 5)
                    log_file_PULS=${log_file/Info/PULS}
                    log_file_RESP=${log_file/Info/RESP}
                    funcfilejson=$(echo "${arrlistfunc[l]}"| cut -d'/' -f 8)
                    funcfile=$(echo $funcfilejson| cut -d'.' -f 1)
                    cp -n "/Volumes/data/physio/$log_file" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_Info.log"
#cp -n "/Volumes/groupdata/physio_old/$log_file" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_Info.log"
                    time0=$(awk 'NR==10 {print $3}' ${arrlistfile[k]})
                    if  [ -e "/Volumes/data/physio/$log_file_PULS" ]; then
                        cp -n "/Volumes/data/physio/$log_file_PULS" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_PULS.log"
# if  [ -e "/Volumes/groupdata/physio_old/$log_file_PULS" ]; then
#cp -n "/Volumes/groupdata/physio_old/$log_file_PULS" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_PULS.log"
                        awk 'NR>8 && ($1>="'$time0'") {print$3 }' ${arrlistfile[k]/Info/PULS} > $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.tsv"
                        gzip $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.tsv"
                        jq -n ' { "Units": "Hz", "SamplingFrequency": 200,"StartTime": 0, "Columns": ["cardiac"] }'  > $SUBDIR/func/""${funcfile/_bold/}"_recording-cardiac_physio.json"
                    fi
                    if  [ -e "/Volumes/data/physio/$log_file_RESP" ]; then
                        cp -n "/Volumes/data/physio/$log_file_RESP" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_RESP.log"
#if  [ -e "/Volumes/groupdata/physio_old/$log_file_RESP" ]; then
#cp -n "/Volumes/groupdata/physio_old/$log_file_RESP" $EXPDIR/sourcedata/$sub/"Physio_"$funcfile"_RESP.log"
                        awk 'NR>8 && ($1>="'$time0'") {print$3 }' ${arrlistfile[k]/Info/RESP} > $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.tsv"
                        jq -n ' { "Units": "Hz", "SamplingFrequency": 50,"StartTime": 0, "Columns": ["respiratory"]  }'  > $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.json"
                        gzip $SUBDIR/func/""${funcfile/_bold/}"_recording-respiratory_physio.tsv"
                    fi



                fi
        fi
    done
    done

done
