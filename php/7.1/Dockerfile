FROM php:7.1-fpm

ENV Dependencies "ssmtp libfreetype6 libjpeg62-turbo unzip git mysql-client sudo rsync liblz4-tool"
ENV TempDependencies "libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev"

# install dependencies and cleanup (needs to be one step, as else it will cache in the laver)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    $Dependencies $TempDependencies && \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/local/ && \
    docker-php-ext-install -j$(nproc) curl json xml mbstring zip bcmath soap pdo_mysql gd && \
    pecl install xdebug && \
    apt-get clean && \
    apt-get autoremove -y && \
    apt-get purge -y --auto-remove $TempDependencies && \
    rm -rf /var/lib/apt/lists/*

# set up mailhog as sendmail target
RUN echo "mailhub=mailhog:1025" >> /etc/ssmtp/ssmtp.conf
RUN echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

# remove memory limit
RUN echo "memory_limit = -1" > /usr/local/etc/php/conf.d/memory-limit-php.ini

# prepare optional xdebug ini
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/optional_xdebug.ini && \
    echo "xdebug.remote_enable=on" >> /usr/optional_xdebug.ini && \
    echo "xdebug.remote_autostart=off" >> /usr/optional_xdebug.ini

# install latest composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv /var/www/html/composer.phar /usr/local/bin/composer
