ARG MARIADB_VERSION

FROM mariadb:$MARIADB_VERSION

RUN [[ ! -e /usr/bin/mysqladmin ]] && ln -s /usr/bin/mariadb-admin /usr/bin/mysqladmin
