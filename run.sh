#!/bin/bash

MY_PATH=$(dirname $(realpath $0))
. $MY_PATH/container-name.conf

MY_PATH=$(pwd)

ETC_POSTGRESQL=$MY_PATH"/etc_postgresql"
LIB_POSTGRESQL=$MY_PATH"/var_lib_postgresql"
LOG_POSTGRESQL=$MY_PATH"/var_log_postgresql"
LOG_SUPERVISOR=$MY_PATH"/var_log_supervisor"

DOCKER_ARGS=''
if [ "$1" = "/bin/bash" ]; then
	DOCKER_ARGS='-t -i';
fi

docker run --rm -p 5432:5432 \
    $DOCKER_ARGS \
	--name $PG_CONTAINER_NAME \
	-v $ETC_POSTGRESQL:/etc/postgresql \
	-v $LIB_POSTGRESQL:/var/lib/postgresql \
	-v $LOG_POSTGRESQL:/var/log/postgresql \
	-v $LOG_SUPERVISOR:/var/log/supervisor \
	$PG_IMAGE_NAME $@
