#!/bin/bash

# script to correct the colmun header of the physio json files

study=Mimicry

EXPDIR=/Volumes/groupdata/MRI_BIDS_DATABANK/$study

list_cardio=$(ls $EXPDIR/sub*/func/*cardiac_physio.json)

for json in $list_cardio
do
 jq '.Columns |= ["cardiac"]' $json > $EXPDIR/derivatives/tmp.$$.json && mv $EXPDIR/derivatives/tmp.$$.json $json
done

list_respiratory=$(ls $EXPDIR/sub*/func/*respiratory_physio.json)

for json in $list_respiratory
do
 jq '.Columns |= ["respiratory"]' $json > $EXPDIR/derivatives/tmp.$$.json && mv $EXPDIR/derivatives/tmp.$$.json $json
done





