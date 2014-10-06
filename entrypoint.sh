#!/bin/bash

chown -R postgres:postgres /var/log/postgresql
if [ ! -d /var/lib/postgresql/9.3/main ]; then
    chown -R postgres:postgres /etc/postgresql
    chown postgres:postgres /var/lib/postgresql
fi

/usr/bin/supervisord -n
