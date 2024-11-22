
#!/bin/sh

#script pour copier fichiers physio du dossier /data/physio vers les dossiers study/sourcedata/sub correspondant en les renommant

source ../Topup_Physio_BIDS/subjects_to_process.cfg

case $study in

	Interception)
		echo "--- project Interception ---"
		echo "--- edit_fieldmap_general_IntendedFor_only.sh ---"
		bash edit_fieldmap_general_IntendedFor_only.sh
		echo "--- move_loca_events_general.sh ---"
		bash move_loca_events_general.sh 
		echo "--- physio_general.sh ---"
		bash physio_general.sh 
		echo "--- convert_mp2rage_no_ses.sh ---"
		bash convert_mp2rage_no_ses.sh 
	;;

	PhantomPainBrain)
		echo "--- project PhantomPainBrain ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- move_dwi_phase_general.sh ---"
		bash move_dwi_phase_general.sh
		echo "--- edit_fieldmap_general.sh ---"
		bash edit_fieldmap_general.sh
		echo "--- move_loca_events_general.sh ---"
		bash move_loca_events_general.sh 
		echo "--- physio_general.sh ---"
		bash physio_general.sh 

	;;

	PhantomPainSpine)
		echo "--- project PhantomPainSpine ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- move_loca_events_general.sh ---"
		bash move_loca_events_general.sh 
		echo "--- physio_WIP.sh ---"
		bash physio_WIP.sh   

	;;

	CervicalSpine)
		echo "--- project PhantomPainSpine ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- move_loca_events_general.sh ---"
		bash move_loca_events_general.sh 
		echo "--- physio_WIP.sh ---"
		bash physio_WIP.sh   

	;;
	
	TimOn)
		echo "--- project TimOn ---"
		echo "--- running batch_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
	;;

	Mimicry)
		echo "--- project Mimicry ---"
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
		echo "--- running convert_mp2rage_no_ses.sh ... ---"
		bash convert_mp2rage_no_ses.sh 
	;;

	NEMO)
		echo "--- project NEMO ---"
		echo "--- running add_session.sh ... ---"
		bash add_session.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_spectro_general.sh ... ---"
		bash move_spectro_general.sh

	;;

	OculoTMS)
		echo "--- project OculoTMS ---"
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
	;;

	BRAINT)
		echo "--- project BRAINT ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
	;;

	EcriPark)
		echo "--- project EcriPark ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---" 
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
		echo "--- running prepare_b0.sh ... ---"
		bash prepare_b0.sh 
	;;


	TP_MASCO)
		echo "--- project TP_MASCO ---"
		#echo "--- bash create_session_new.sh ---"
		#bash create_session_new.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
	;;

	GesteSigne)
		echo "--- project GesteSigne ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
	;;

	RevCorf0)
		echo "--- project RevCorf0 ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- running edit_fieldmap_RevCorf0_new.sh ... ---"
		bash edit_fieldmap_RevCorf0_new.sh
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 

	;;

	DrugAddict)
		echo "--- project DrugAddict ---"
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 

	;;
	AlcAddict)
		echo "--- project AlcAddict ---"
		echo "--- bash add_session_.sh ---"
		bash add_session.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 

	;;
	DeepMReye)
		echo "--- project DeepMReye ---"
		echo "--- bash create_session_new.sh ---"
		bash create_session_new.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 

	;;

	MotConf)
		echo "--- project DeepMReye ---"
		echo "--- bash add_session.sh ---"
		bash add_session.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 

	;;

	MotorLang)
		echo "--- project MotorLang ---"
		echo "--- bash add_session.sh ---"
		bash add_session.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 

	;;

	ArtificialVoice)
		echo "--- project ArtificialVoice ---"
		echo "--- bash add_session.sh ---"
		bash add_session.sh
		echo "--- running batch_fieldmap_general.sh ... ---"
		bash batch_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 

	;;

	Inhibition)
		echo "--- project ArtificialVoice ---"
		echo "--- bash add_session.sh ---"
		bash add_session.sh
		echo "--- running edit_fieldmap_general.sh ... ---"
		bash edit_fieldmap_general.sh
		echo "--- running move_loca_events_general.sh ... ---"
		bash move_loca_events_general.sh 
		echo "--- running physio_general.sh ... ---"
		bash physio_general.sh 
		echo "--- running move_spectroRAW_general.sh ... ---"
		bash move_spectroRAW_general.sh

	;;



esac
