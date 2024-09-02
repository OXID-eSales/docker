ARG MARIADB_VERSION

FROM mariadb:$MARIADB_VERSION

ENV MARIADB_DATABASE=example
ENV MARIADB_ROOT_PASSWORD=root

HEALTHCHECK --interval=2s --retries=120 \
    CMD out=$$(mariadb-admin ping -h localhost -P 3306 -u root --password=$${MYSQL_ROOT_PASSWORD} 2>&1); echo $$out | grep 'mysqld is alive' || { echo $$out; exit 1; }
