#!/bin/bash

# Usage:
#   ./build.sh <version>              build the image locally (single-arch)
#   ./build.sh --emit-args <version>  print the build-args (KEY=value per line)
#                                     for the CI workflow to feed into build_docker

set -euo pipefail

IMAGE="oxidesales/oxideshop-docker-php"

usage() {
    echo "Usage: $0 [--emit-args] <PHP version, e.g. 8.4>" >&2
    exit 128
}

MODE="build"
if [[ "${1:-}" == "--emit-args" ]]; then
    MODE="emit"
    shift
fi

VERSION="${1:-}"
[[ -n "${VERSION}" ]] || usage

# Populate ARGS (KEY=value entries) for the requested version.
ARGS=()
case "${VERSION}" in
5.6)
    ARGS=(
        "PHP_VERSION=5.6"
        "PECL_DEPS=pecl install xdebug-2.5.5 memcached-2.2.0"
        "COMPOSER_VERSION=2.2"
    ) ;;
7.0)
    ARGS=(
        "PHP_VERSION=7.0"
        "PECL_DEPS=pecl install xdebug-2.7.2 memcached"
        "COMPOSER_VERSION=2.2"
    ) ;;
7.1)
    ARGS=(
        "PHP_VERSION=7.1"
        "PECL_DEPS=pecl install xdebug-2.9.8 memcached"
        "COMPOSER_VERSION=2.2"
    ) ;;
7.2)
    ARGS=(
        "PHP_VERSION=7.2"
        "RUNTIME_PACKAGE_DEPS=msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool bc iproute2 libmemcached-dev openssh-client sshpass"
        "BUILD_PACKAGE_DEPS=libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev zlib1g-dev"
        "PECL_DEPS=pecl install xdebug-2.9.8 memcached"
    ) ;;
7.3)
    ARGS=(
        "PHP_VERSION=7.3"
        "RUNTIME_PACKAGE_DEPS=msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev openssh-client sshpass"
        "BUILD_PACKAGE_DEPS=libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev"
        "PECL_DEPS=pecl install xdebug-2.9.8 memcached"
    ) ;;
7.4)
    ARGS=(
        "PHP_VERSION=7.4"
        "RUNTIME_PACKAGE_DEPS=msmtp libfreetype6 libjpeg62-turbo unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev libonig-dev openssh-client sshpass libgd3"
        "BUILD_PACKAGE_DEPS=libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev"
        "GD_CONFIG=--with-jpeg=/usr/local/"
        "PECL_DEPS=pecl install xdebug-3.1.3 memcached"
        "XDEBUG_INI=xdebug3.ini"
    ) ;;
8.0)
    ARGS=(
        "PHP_VERSION=8.0"
        "RUNTIME_PACKAGE_DEPS=msmtp libfreetype6 libjpeg62-turbo libwebp6 unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev libonig-dev openssh-client sshpass libgd3"
        "BUILD_PACKAGE_DEPS=libcurl4-openssl-dev libjpeg-dev libpng-dev libwebp-dev libxml2-dev"
        "PHP_EXT_DEPS=zip bcmath soap pdo_mysql gd mysqli"
        "GD_CONFIG=--with-jpeg=/usr/local/ --with-webp"
        "PECL_DEPS=pecl install xdebug-3.1.3 memcached"
        "XDEBUG_INI=xdebug3.ini"
    ) ;;
8.1|8.2|8.3|8.4|8.5)
    ARGS=(
        "PHP_VERSION=${VERSION}"
        "FPM_VARIANT=-bookworm"
        "RUNTIME_PACKAGE_DEPS=msmtp libfreetype6 libjpeg62-turbo libwebp-dev unzip git default-mysql-client sudo rsync liblz4-tool libzip-dev bc iproute2 libmemcached-dev libonig-dev openssh-client sshpass libssl-dev libgd3 libavif15"
        "BUILD_PACKAGE_DEPS=libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libavif-dev"
        "PHP_EXT_DEPS=zip bcmath soap pdo_mysql gd mysqli"
        "GD_CONFIG=--with-jpeg=/usr/local/ --with-webp=/usr/local/ --with-avif"
        "PECL_DEPS=pecl install xdebug memcached"
        "XDEBUG_INI=xdebug3.ini"
    ) ;;
8.6-rc)
    ARGS=(
        "PHP_VERSION=8.6-rc"
        "FPM_VARIANT=-trixie"
        "RUNTIME_PACKAGE_DEPS=msmtp libfreetype6 libjpeg62-turbo libwebp-dev unzip git default-mysql-client sudo rsync lz4 libzip-dev bc iproute2 libmemcached-dev libonig-dev openssh-client sshpass libssl-dev libgd3 libavif16"
        "BUILD_PACKAGE_DEPS=libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libavif-dev"
        "PHP_EXT_DEPS=zip bcmath soap pdo_mysql gd mysqli"
        "GD_CONFIG=--with-jpeg=/usr/local/ --with-webp=/usr/local/ --with-avif"
        "PECL_DEPS=true"
        "XDEBUG_FROM_SOURCE=true"
        "XDEBUG_INI=xdebug3.ini"
    ) ;;
*)
    echo "Version ${VERSION} is not supported." >&2
    exit 128 ;;
esac

if [[ "${MODE}" == "emit" ]]; then
    printf '%s\n' "${ARGS[@]}"
    exit 0
fi

# Local build: turn each KEY=value into a --build-arg and build single-arch.
BUILD_ARGS=()
for arg in "${ARGS[@]}"; do
    BUILD_ARGS+=(--build-arg "${arg}")
done

set -x
docker build --no-cache "${BUILD_ARGS[@]}" -t "${IMAGE}:${VERSION}" .
