#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

process_arguments() {
  local OPTIND ARGUMENT_COUNT
  while getopts 'ht:s:' option; do
    case "${option}" in
      h) echo "$USAGE"; exit;;
      t) TARGET=$OPTARG; REQUIRED_ARGUMENT_COUNT=$(( REQUIRED_ARGUMENT_COUNT + 1 ));;
      s) SHOP=$OPTARG; REQUIRED_ARGUMENT_COUNT=$(( REQUIRED_ARGUMENT_COUNT + 1 ));;
      *) FAIL=1;;
    esac
  done
}


USAGE="$(basename "$0") [-h] [-t project|dev] [-s version] -- Helper script to build an OXID eShop Community Edition Docker Image

Available options:
    -h  Show this help text
    -t  (Mandatory) Set the target to either one of \"project\" or \"dev\"
    -s  (Mandatory) Set the build version for the OXID eShop Compilation a.e. \"v6.1.3\""

FAIL=0
REQUIRED_ARGUMENT_COUNT=0
process_arguments "$@"

if [[ $REQUIRED_ARGUMENT_COUNT -lt 2 ]]; then
  echo "Mandatory arguments are missing!"
  FAIL=1
fi

if [[ $FAIL -gt 0 ]]; then
       echo "$USAGE" >&2
  exit $FAIL
else
  echo "Building $TARGET image for OXID eShop Community Edition $SHOP"
  cd "$DIR/$TARGET"
  if [[ $TARGET == "dev" ]]; then
    docker build --build-arg COMPILATION_VERSION=$SHOP -t oxidesales/oxideshop-docker-ce:$SHOP-dev .
  else
    docker build --build-arg COMPILATION_VERSION=$SHOP -t oxidesales/oxideshop-docker-ce:$SHOP .
  fi
  cd $OLDPWD
  exit
fi