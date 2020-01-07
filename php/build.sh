#!/bin/bash

if [[ $1 == "7.0" ]]; then
  BUILD="docker build -t oxidesales/oxideshop-docker-php:7.0 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.1" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.1')
  BUILD="docker build ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.1 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.2" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.2')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool bc iproute2'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libmemcached-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='xdebug memcached'")
  BUILD="docker build ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.2 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "7.3" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.3')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libmemcached-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='xdebug memcached'")
  BUILD="docker build ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.3 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

# NOTICE: only for internal use, do not publish on dockerhub until 7.4 is released as final
if [[ $1 == "7.4" ]]; then
  DOCKER_BUILD_ARGUMENTS=()
  DOCKER_BUILD_ARGUMENTS+=('--build-arg PHP_VERSION=7.4')
  DOCKER_BUILD_ARGUMENTS+=("--build-arg RUNTIME_PACKAGE_DEPS='msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libonig-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg BUILD_PACKAGE_DEPS='libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libmemcached-dev'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg PECL_DEPS='xdebug-beta memcached'")
  DOCKER_BUILD_ARGUMENTS+=("--build-arg GD_CONFIG='--with-jpeg=/usr/local/'")
  BUILD="docker build ${DOCKER_BUILD_ARGUMENTS[*]} -t oxidesales/oxideshop-docker-php:7.4 ."
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
