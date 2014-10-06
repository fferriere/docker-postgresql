#!/bin/bash

copy_config() {
    ETC_POSTGRESQL="$1/etc_postgresql"

    if [ ! -d $ETC_POSTGRESQL ]; then

        echo "Copy of /etc/postgresql"
        mkdir -p $ETC_POSTGRESQL

        CIDFILE="$MY_PATH/cid"
        docker run -d \
            --cidfile=$CIDFILE \
            $PG_IMAGE_NAME

        MY_CONTAINER=$(cat $CIDFILE)
        docker cp $MY_CONTAINER:/etc/postgresql/9.3 $ETC_POSTGRESQL

        docker stop -t 0 $MY_CONTAINER
        docker rm $MY_CONTAINER
        rm $CIDFILE
    fi
}

MY_PATH=$(dirname $(realpath $0))

. $MY_PATH"/container-name.conf"

docker build -t $PG_IMAGE_NAME $MY_PATH/.

copy_config $(pwd)
