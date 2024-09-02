ARG MARIADB_VERSION=10

FROM mariadb:$MARIADB_VERSION

RUN if [ ! -e /usr/bin/mysqladmin ]; then ln -s /usr/bin/mariadb-admin /usr/bin/mysqladmin ; fi
