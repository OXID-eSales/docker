#!/bin/bash

if [[ $1 == "5.6" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=5.6')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-2.5.5 memcached-2.2.0'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:5.6 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.0" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-2.7.2 memcached'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.0 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.1" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.1')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-2.9.8 memcached'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.1 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.2" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.2')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool bc iproute2 libmemcached-dev openssh-client sshpass'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev zlib1g-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-2.9.8 memcached'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.2 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.3" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.3')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev openssh-client sshpass'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-2.9.8 memcached'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.3 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.4" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.4')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev libonig-dev openssh-client sshpass'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg GD_CONFIG='--with-jpeg=/usr/local/'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-3.1.3 memcached'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg XDEBUG_INI='xdebug3.ini'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.4 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "8.0" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=8.0')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo libwebp6 unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev libonig-dev openssh-client sshpass'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libwebp-dev libxml2-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PHP_EXT_DEPS='zip bcmath soap pdo_mysql gd mysqli'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg GD_CONFIG='--with-jpeg=/usr/local/ --with-webp'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-3.1.3 memcached'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg XDEBUG_INI='xdebug3.ini'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:8.0 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "8.1" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=8.1')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo libwebp6 unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev libonig-dev openssh-client sshpass'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libwebp-dev libxml2-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PHP_EXT_DEPS='zip bcmath soap pdo_mysql gd mysqli'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg GD_CONFIG='--with-jpeg=/usr/local/ --with-webp=/usr/local'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='pecl install xdebug-3.1.3 memcached'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg XDEBUG_INI='xdebug3.ini'")
  BUILD="docker build --no-cache ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:8.1 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == [0-9]\.[0-9] ]]; then
  echo "Version $1 is not supported."
  exit 128
fi

echo "Usage: provide one argument specifying the PHP version in the format Major.Minor (a.e. 7.0)!"
exit 128
