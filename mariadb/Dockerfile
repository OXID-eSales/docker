ARG MARIADB_VERSION=10

FROM mariadb:$MARIADB_VERSION

RUN \
    if [ ! -e /usr/bin/mysql ]; then ln -s /usr/bin/mariadb /usr/bin/mysql ; fi ; \
    if [ ! -e /usr/bin/mysql_convert_table_format ]; then ln -s /usr/bin/mariadb-convert-table-format /usr/bin/mysql_convert_table_format ; fi ; \
    if [ ! -e /usr/bin/mysql_find_rows ]; then ln -s /usr/bin/mariadb-find-rows /usr/bin/mysql_find_rows ; fi ; \
    if [ ! -e /usr/bin/mysql_fix_extensions ]; then ln -s /usr/bin/mariadb-fix-extensions /usr/bin/mysql_fix_extensions ; fi ; \
    if [ ! -e /usr/bin/mysql_install_db ]; then ln -s /usr/bin/mariadb-install-db /usr/bin/mysql_install_db ; fi ; \
    if [ ! -e /usr/bin/mysql_plugin ]; then ln -s /usr/bin/mariadb-plugin /usr/bin/mysql_plugin ; fi ; \
    if [ ! -e /usr/bin/mysql_secure_installation ]; then ln -s /usr/bin/mariadb-secure-installation /usr/bin/mysql_secure_installation ; fi ; \
    if [ ! -e /usr/bin/mysql_setpermission ]; then ln -s mariadb-setpermission /usr/bin/mysql_setpermission ; fi ; \
    if [ ! -e /usr/bin/mysql_tzinfo_to_sql ]; then ln -s /usr/bin/mariadb-tzinfo-to-sql /usr/bin/mysql_tzinfo_to_sql ; fi ; \
    if [ ! -e /usr/bin/mysql_upgrade ]; then ln -s /usr/bin/mariadb-upgrade /usr/bin/mysql_upgrade ; fi ; \
    if [ ! -e /usr/bin/mysql_waitpid ]; then ln -s /usr/bin/mariadb-waitpidn /usr/bin/mysql_waitpid ; fi ; \
    if [ ! -e /usr/bin/mysqlaccess ]; then ln -s /usr/bin/mariadb-access /usr/bin/mysqlaccess ; fi ; \
    if [ ! -e /usr/bin/mysqladmin ]; then ln -s /usr/bin/mariadb-admin /usr/bin/mysqladmin ; fi ; \
    if [ ! -e /usr/bin/mysqlanalyze ]; then ln -s /usr/bin/mariadb-check /usr/bin/mysqlanalyze ; fi ; \
    if [ ! -e /usr/bin/mysqlbinlog ]; then ln -s /usr/bin/mariadb-binlog /usr/bin/mysqlbinlog ; fi ; \
    if [ ! -e /usr/bin/mysqlcheck ]; then ln -s /usr/bin/mariadb-check /usr/bin/mysqlcheck ; fi ; \
    if [ ! -e /usr/bin/mysqld_multi ]; then ln -s /usr/bin/mariadbd-multi /usr/bin/mysqld_multi ; fi ; \
    if [ ! -e /usr/bin/mysqld_safe ]; then ln -s /usr/bin/mariadbd-safe /usr/bin/mysqld_safe ; fi ; \
    if [ ! -e /usr/bin/mysqld_safe_helper ]; then ln -s /usr/bin/mariadbd-safe-helper /usr/bin/mysqld_safe_helper ; fi ; \
    if [ ! -e /usr/bin/mysqldump ]; then ln -s /usr/bin/mariadb-dump /usr/bin/mysqldump ; fi ; \
    if [ ! -e /usr/bin/mysqldumpslow ]; then ln -s /usr/bin/mariadb-dumpslow /usr/bin/mysqldumpslow ; fi ; \
    if [ ! -e /usr/bin/mysqlhotcopy ]; then ln -s /usr/bin/mariadb-hotcopy /usr/bin/mysqlhotcopy ; fi ; \
    if [ ! -e /usr/bin/mysqlimport ]; then ln -s /usr/bin/mariadb-import /usr/bin/mysqlimport ; fi ; \
    if [ ! -e /usr/bin/mysqloptimize ]; then ln -s /usr/bin/mariadb-check /usr/bin/mysqloptimize ; fi ; \
    if [ ! -e /usr/bin/mysqlrepair ]; then ln -s /usr/bin/mariadb-check /usr/bin/mysqlrepair ; fi ; \
    if [ ! -e /usr/bin/mysqlreport ]; then ln -s /usr/bin/mariadb-report /usr/bin/mysqlreport ; fi ; \
    if [ ! -e /usr/bin/mysqlshow ]; then ln -s /usr/bin/mariadb-show /usr/bin/mysqlshow ; fi ; \
    if [ ! -e /usr/bin/mysqlslap ]; then ln -s /usr/bin/mariadb-slap /usr/bin/mysqlslap ; fi
