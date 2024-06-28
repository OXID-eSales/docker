ARG PHP_VERSION=7.0
FROM php:$PHP_VERSION-fpm

ARG RUNTIME_PACKAGE_DEPS="msmtp libfreetype6 libjpeg62-turbo libwebp6 unzip git default-mysql-client sudo rsync liblz4-tool bc libmemcached-dev openssh-client sshpass"
ARG BUILD_PACKAGE_DEPS="libcurl4-openssl-dev libjpeg-dev libpng-dev libwebp-dev libxml2-dev zlib1g-dev"
ARG PHP_EXT_DEPS="curl json xml mbstring zip bcmath soap pdo_mysql gd mysqli"
ARG PECL_DEPS="pecl install xdebug memcached"
ARG PHP_MEMORY_LIMIT="-1"
ARG GD_CONFIG="--with-jpeg-dir=/usr/local/ --with-webp"
ARG XDEBUG_INI="xdebug.ini"

# install dependencies and cleanup (needs to be one step, as else it will cache in the layer)
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        $RUNTIME_PACKAGE_DEPS \
        $BUILD_PACKAGE_DEPS \
    && docker-php-ext-configure gd $GD_CONFIG \
    && docker-php-ext-install -j$(nproc) $PHP_EXT_DEPS \
    && $PECL_DEPS \
    && docker-php-source delete \
    && apt-get clean \
    && apt-get autoremove -y \
    && apt-get purge -y --auto-remove $BUILD_PACKAGE_DEPS \
    && usermod -a -G root www-data && usermod -a -G www-data root \
    && rm -rf /var/lib/apt/lists/*

# set sendmail for php to msmtp
RUN echo "sendmail_path=/usr/bin/msmtp -t" > /usr/local/etc/php/conf.d/php-sendmail.ini

# remove memory limit
RUN echo "memory_limit = $PHP_MEMORY_LIMIT" > /usr/local/etc/php/conf.d/memory-limit-php.ini

# enable error log by default
RUN echo "log_errors = On" > /usr/local/etc/php/conf.d/error-log-php.ini

# prepare optional xdebug ini
COPY resources/$XDEBUG_INI /usr/optional_xdebug.ini
RUN sed -i "s~locate_extension~$(find /usr/local/lib/php/extensions/ -name xdebug.so)~" /usr/optional_xdebug.ini

# prepare optional memcached ini
RUN echo "extension=memcached.so" > /usr/optional_memcached.ini

# add symlink to provide php also from /usr/bin
RUN ln -s /usr/local/bin/php /usr/bin/php

# install latest composer v1 as composer1 binary
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer1

# install composer v2.2 as composer2 binary (latest or 2 drops php 7.1)
COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

# Workaround for https://oxid-esales.atlassian.net/browse/OXDEV-4797
RUN echo "php_admin_value[error_log] = /tmp/fpm-php.www.log" >> /usr/local/etc/php-fpm.d/www.conf

