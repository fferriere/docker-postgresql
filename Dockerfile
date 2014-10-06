# src : https://docs.docker.com/examples/postgresql_service/

FROM debian:wheezy

MAINTAINER ferriere.florian@gmail.com

# install wget for get GPG key && locales for UTF8
RUN apt-get update && apt-get install -y wget locales

RUN dpkg-reconfigure locales && \
    echo 'fr_FR.UTF-8 UTF-8' > /etc/locale.gen && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

# add pgdg repository
ADD apt-pgdg.list /etc/apt/sources.list.d/pgdg.list

# get GPG key of pgdg repository
RUN wget --quiet -O - http://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add -

# install of postgres
RUN apt-get update && apt-get install -y supervisor postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 --no-install-recommends

# change user
#USER postgres

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD initpg.sh /usr/local/bin/initpg.sh
ADD start-postgresql.sh /usr/local/bin/start-postgresql.sh

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/log/supervisor", "/var/lib/postgresql"]

EXPOSE 5432

CMD ["/usr/local/bin/entrypoint.sh"]
