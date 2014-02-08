ROOT_DIR=$HOME

function run_rsync {
	echo "Starting rsync"
    rsync -rah --delete --progress --human-readable "$ROOT_DIR/Pictures/iPhoto Library.photolibrary/"\
    "$ROOT_DIR/Cloud@Mail.Ru/photo/iPhoto Library.photolibrary/"
}

function is_process_running {
	local APP_NAME=$1
	number=$(ps xc | grep "$APP_NAME" | wc -l)
	
	if [ $number -gt 0 ]; then
		echo TRUE
	else
		echo FALSE
	fi
}

APP_NAME="iPhoto"
RES=$(is_process_running "$APP_NAME")

echo $(tput setaf 6)"\nChecking application status"$(tput sgr 0)

echo $APP_NAME is running: $RES
if [ "$RES"  == "TRUE" ] ; then 
	echo $(tput setaf 1) "Cannot rsync: '$APP_NAME' is running"
	exit
fi

APP_NAME="Aperture"
RES="$(is_process_running "$APP_NAME")"

echo
echo $APP_NAME is running: $RES
if [ "$RES"  == "TRUE" ] ; then 
	echo $(tput setaf 1)"Cannot rsync: '$APP_NAME' is running"
	exit
fi

run_rsync


echo $(tput setaf 6)"Syncronization finished"
