#!/bin/bash

if [[ $1 == "7.4" ]]; then
  BUILD="docker build --no-cache -t oxidesales/oxideshop-sdk-php:7.4 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "8.0" ]]; then
  BUILD="docker build --no-cache -t oxidesales/oxideshop-sdk-php:8.0 ."
  echo $BUILD
  eval $BUILD
  exit 0
fi

if [[ $1 == "8.1" ]]; then
  BUILD="docker build --no-cache -t oxidesales/oxideshop-sdk-php:8.1 ."
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
