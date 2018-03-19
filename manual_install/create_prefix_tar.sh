#!/usr/bin/bash
## Script to pack the applications in the used format and store them in a tar.gz
## so they are deployed correctly

## input arguments:
## The folder where the app is, and contains the bin and cfg folder.


create_pkg(){
    if [ -d $1/bin/ ] && [ -d $1/cfg/ ]; then
        echo Prepare the folders
        TMP_DIR=$(mktemp -d /tmp/$1_deploy_XXXXX)
        echo $TMP_DIR
        cp -r $1/bin $TMP_DIR
        cp -r $1/cfg $TMP_DIR
        mv $TMP_DIR/cfg $TMP_DIR/etc
        TRANS=s,^\.,$1, # Without quotes
        #tar czvf $1_deploy.tar.gz --transform  's,^,simpleSomeIP_Rx/,' -C $TMP_DIR .
        ## Pack the files excluding vi bkps and adding the preffix with
        ## the name of the application
        tar czvf $1_deploy.tar.gz --exclude '*~' --transform  $TRANS -C $TMP_DIR .
    else
        echo not exists
    fi

}


main(){
    # remove slash from the dir name
    app_name=${1%/}
    create_pkg $app_name
}

main $1
