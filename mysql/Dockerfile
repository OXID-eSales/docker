ARG MYSQL_VERSION

FROM mysql:${MYSQL_VERSION}-debian

ENV MYSQL_DATABASE=example
ENV MYSQL_ROOT_PASSWORD=root

HEALTHCHECK --interval=2s --retries=120 \
    CMD out=$$(mysqladmin ping -h localhost -P 3306 -u root --password=$${MYSQL_ROOT_PASSWORD} 2>&1); echo $$out | grep 'mysqld is alive' || { echo $$out; exit 1; }
