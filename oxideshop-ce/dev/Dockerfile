FROM oxidesales/oxideshop-docker-php:7.1

ARG COMPILATION_VERSION=v6.1.3

COPY config.inc.php /tmp/config.inc.php

RUN mkdir -p /var/www/oxideshop && \
    git clone https://github.com/OXID-eSales/oxideshop_metapackage_ce.git /tmp/meta && \
    ce_version=$(grep -E "oxid-esales/oxideshop-ce" /tmp/meta/composer.json | awk '{print $2}' FS=': "' | sed 's/",//') && \
    rm -rf /tmp/meta && \
    git clone --branch $ce_version https://github.com/OXID-eSales/oxideshop_ce.git /var/www/oxideshop && \
    composer config cache-dir /tmp/composercache -d /var/www/oxideshop && \
    composer install -d /var/www/oxideshop && \
    mv /tmp/config.inc.php /var/www/oxideshop/source/config.inc.php && \
    chmod 666 /var/www/oxideshop/source/.htaccess && \
    chmod 666 /var/www/oxideshop/source/config.inc.php && \
    chmod -R a+w /var/www/oxideshop/source/out && \
    chmod -R a+w /var/www/oxideshop/source/log && \
    chmod -R a+w /var/www/oxideshop/source/tmp && \
    chmod -R a+w /var/www/oxideshop/source/export && \
    mv /var/www/oxideshop /var/www/oxideshop_template && \
    mkdir /var/www/oxideshop && \
    rm -rf /tmp/composercache

# Actions which will be executed if /var/www/oxideshop is empty
ENV if_empty_action1="echo \"Empty shop directory found, moving prepared files.\""
ENV if_empty_action2="chown -R \$HOST_USER_ID.\$HOST_GROUP_ID \/var\/www\/oxideshop_template\/"
ENV if_empty_action3="mv \/var\/www\/oxideshop_template\/* \/var\/www\/oxideshop\/"
ENV if_empty_action4="\/var\/www\/oxideshop\/vendor\/bin\/reset-shop"
ENV if_empty="${if_empty_action1};\n  ${if_empty_action2};\n  ${if_empty_action3};\n  ${if_empty_action4}"

# Just echo that nothing will be done if /var/www/oxideshop is not empty
ENV if_not_empty="echo \"Shopdirectory is not empty, will not touch it and will not reset the database.\""

ENV prepend_script="if [ \"\$(ls -A \/var\/www\/oxideshop)\" ];\nthen\n  ${if_not_empty};\nelse\n  ${if_empty};\nfi\n\n"
ENV groupmatch_line="\(.*\)"
ENV matching_group_one="\1"
ENV php_entrypoint="/usr/local/bin/docker-php-entrypoint"

RUN prependline=$(grep -Ehn -m 1 "^exec .*$" ${php_entrypoint} | awk '{print $1}' FS=':') && \
    sed -i -e "${prependline}s/${groupmatch_line}/${prepend_script}${matching_group_one}/" ${php_entrypoint}

# RUN cat ${php_entrypoint} # Uncomment if you need to adapt the entrypoint and want to check if it was changed as needed

WORKDIR /var/www/oxideshop