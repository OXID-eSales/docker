ARG PHP_VERSION=7.0
FROM php:$PHP_VERSION-fpm

ARG RUNTIME_PACKAGE_DEPS="ssmtp libfreetype6 libjpeg62-turbo unzip git mysql-client sudo rsync liblz4-tool"
ARG BUILD_PACKAGE_DEPS="libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev"
ARG PHP_EXT_DEPS="curl json xml mbstring zip bcmath soap pdo_mysql gd mysqli"
ARG PHP_MEMORY_LIMIT="-1"

# install dependencies and cleanup (needs to be one step, as else it will cache in the laver)
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        $RUNTIME_PACKAGE_DEPS \
        $BUILD_PACKAGE_DEPS \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/local/ \
    && docker-php-ext-install -j$(nproc) $PHP_EXT_DEPS \
    && pecl install xdebug \
    && apt-get clean \
    && apt-get autoremove -y \
    && apt-get purge -y --auto-remove $BUILD_PACKAGE_DEPS \
    && rm -rf /var/lib/apt/lists/*

# set sendmail for php to ssmtp
RUN echo "sendmail_path=/usr/sbin/ssmtp -t" > /usr/local/etc/php/conf.d/php-sendmail.ini

# remove memory limit
RUN echo "memory_limit = $PHP_MEMORY_LIMIT" > /usr/local/etc/php/conf.d/memory-limit-php.ini

# prepare optional xdebug ini
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/optional_xdebug.ini && \
    echo "xdebug.remote_enable=on" >> /usr/optional_xdebug.ini && \
    echo "xdebug.remote_autostart=off" >> /usr/optional_xdebug.ini

# install latest composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv /var/www/html/composer.phar /usr/local/bin/composer
