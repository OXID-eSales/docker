FROM oxidesales/oxideshop-docker-php:7.1

ARG COMPILATION_VERSION=v6.1.3

COPY config.inc.php /tmp/config.inc.php
COPY dependencies/$COMPILATION_VERSION.sh /tmp/mydep

RUN mkdir -p /var/www/oxideshop && \
    composer create-project oxid-esales/oxideshop-project /var/www/oxideshop dev-b-6.1-ce --no-install && \
    composer config cache-dir /tmp/composercache -d /var/www/oxideshop && \
    composer require oxid-esales/oxideshop-metapackage-ce $COMPILATION_VERSION --no-update -d /var/www/oxideshop && \
    chmod +x /tmp/mydep && /tmp/mydep && \
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
    rm -rf /tmp/composercache && rm -rf /tmp/mydep

# Actions which will be executed if /var/www/oxideshop is empty
ENV if_empty_action1="echo \"Empty shop directory found, moving prepared files.\""
ENV if_empty_action2="chown -R \$HOST_USER_ID.\$HOST_GROUP_ID \/var\/www\/oxideshop_template\/"
ENV if_empty_action3="\/bin\/bash -c 'shopt -s dotglob \&\& mv \/var\/www\/oxideshop_template\/* \/var\/www\/oxideshop\/'"
ENV if_empty_action4="sleep 5 \&\& \/var\/www\/oxideshop\/vendor\/bin\/reset-shop"
ENV if_empty="${if_empty_action1};\n  ${if_empty_action2};\n  ${if_empty_action3};\n  ${if_empty_action4}"

# Just echo that nothing will be done if /var/www/oxideshop is not empty
ENV if_not_empty="echo \"Shopdirectory is not empty, will not touch it and will not reset the database.\""

ENV prepend_script="if [ \"\$(ls -A \/var\/www\/oxideshop)\" ];\nthen\n  ${if_not_empty};\nelse\n  ${if_empty};\nfi\n\n"
ENV groupmatch_line="\(.*\)"
ENV matching_group_one="\1"
ENV php_entrypoint="/usr/local/bin/docker-php-entrypoint"

RUN prependline=$(grep -Ehn -m 1 "^exec .*$" ${php_entrypoint} | awk '{print $1}' FS=':') && \
    sed -i -e "${prependline}s/${groupmatch_line}/${prepend_script}${matching_group_one}/" ${php_entrypoint}

# RUN cat /usr/local/bin/docker-php-entrypoint # Uncomment if you need to adapt the entrypoint and want to check if it was changed as needed

WORKDIR /var/www/oxideshop