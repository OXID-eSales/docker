FROM debian:stable-slim

ENV LANG en_US.utf8
ENV LANGUAGE en_US.utf8
ENV LC_ALL en_US.utf8

RUN apt-get update -y && export LANG="en_US.utf8" && export LANGUAGE="en_US.utf8" && export LC_ALL="en_US.utf8" && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends locales && \
    locale-gen en_US.utf8 && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    mkdir -p /usr/share/man/man1 && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git python3-pip liblz4-tool plantuml graphviz openjdk-11-jre rsync ssh curl apache2-utils && \
    apt-get clean && \
    apt-get autoremove -y && \
    pip install wheel && \
    pip install -U Sphinx>=4.3.0 && \
    pip install sphinx_rtd_theme>=0.5.1 && \
    pip install docutils==0.16 && \
    pip install sphinxcontrib-httpdomain && \
    pip install sphinxcontrib_plantuml && \
    pip install sphinxcontrib_phpdomain && \
    pip install pygments-graphql && \
    pip install git+https://github.com/fabpot/sphinx-php.git && \
    java -jar ./usr/share/plantuml/plantuml.jar -testdot