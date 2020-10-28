ARG PHP_VERSION=7.0
FROM php:$PHP_VERSION-fpm

ARG RUNTIME_PACKAGE_DEPS="msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool bc libmemcached-dev openssh-client sshpass"
ARG BUILD_PACKAGE_DEPS="libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev zlib1g-dev"
ARG PHP_EXT_DEPS="curl json xml mbstring zip bcmath soap pdo_mysql gd mysqli"
ARG PECL_DEPS="pecl install xdebug memcached"
ARG PHP_MEMORY_LIMIT="-1"
ARG GD_CONFIG="--with-jpeg-dir=/usr/local/"

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

# prepare optional xdebug ini
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/optional_xdebug.ini && \
    echo "xdebug.remote_enable=on" >> /usr/optional_xdebug.ini && \
    echo "xdebug.remote_autostart=off" >> /usr/optional_xdebug.ini

# prepare optional memcached ini
RUN echo "extension=memcached.so" > /usr/optional_memcached.ini

# add symlink to provide php also from /usr/bin
RUN ln -s /usr/local/bin/php /usr/bin/php

# install latest composer v1
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer

# install latest composer v2 as composer2 binary
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer2
