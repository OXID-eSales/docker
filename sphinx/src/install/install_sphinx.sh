#!/bin/bash
set -e
set -x
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends locales
locale-gen en_US.utf8
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
mkdir -p /usr/share/man/man1
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    python3-pip \
    liblz4-tool \
    plantuml \
    graphviz \
    default-jre \
    rsync \
    ssh \
    curl \
    apache2-utils \
    python3-wheel \
    python3-docutils \
    python3-sphinx \
    python3-rtd-theme \
    python3-sphinxcontrib.httpdomain \
    python3-sphinxcontrib.plantuml
apt-get clean
apt-get autoremove -y
pip install sphinxcontrib_phpdomain
pip install pygments-graphql
pip install git+https://github.com/fabpot/sphinx-php.git
java -jar ./usr/share/plantuml/plantuml.jar -testdot
