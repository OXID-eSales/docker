FROM ubuntu:20.04

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-11-jre-headless \
    tzdata \
    sudo \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-11-openjdk-amd64/conf/security/java.security

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "UTC"
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

#==========
# Selenium
#==========
RUN mkdir -p /opt/selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.9/selenium-server-standalone-3.9.1.jar \
    -O /opt/selenium/selenium-server-standalone.jar

#==============
# VNC and Xvfb
#==============
RUN apt-get update -qqy \
  && apt-get -qqy install \
    locales \
    xvfb \
    x11vnc \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && mkdir -p /root/.vnc \
  && x11vnc -storepasswd secret ~/.vnc/passwd

EXPOSE 5900

#============================
# Some configuration options
#============================
ENV SCREEN_WIDTH 1920
ENV SCREEN_HEIGHT 1080
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

#========================
# Selenium Configuration
#========================
# As integer, maps to "maxInstances"
ENV NODE_MAX_INSTANCES 1
# As integer, maps to "maxSession"
ENV NODE_MAX_SESSION 1
# As integer, maps to "port"
ENV NODE_PORT 5555
# In milliseconds, maps to "registerCycle"
ENV NODE_REGISTER_CYCLE 5000
# In milliseconds, maps to "nodePolling"
ENV NODE_POLLING 5000
# In milliseconds, maps to "unregisterIfStillDownAfter"
ENV NODE_UNREGISTER_IF_STILL_DOWN_AFTER 60000
# As integer, maps to "downPollingLimit"
ENV NODE_DOWN_POLLING_LIMIT 2
# As string, maps to "applicationName"
ENV NODE_APPLICATION_NAME ""

# Following line fixes https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

CMD ["/opt/bin/entry_point.sh"]

#=========
# Firefox
#=========
ARG FIREFOX_VERSION=94.0.1
RUN FIREFOX_DOWNLOAD_URL=$(if [ $FIREFOX_VERSION = "nightly" ]; then echo "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US"; else echo "https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2"; fi) \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install firefox \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && wget --no-verbose -O /tmp/firefox.tar.bz2 $FIREFOX_DOWNLOAD_URL \
  && apt-get -y purge firefox \
  && rm -rf /opt/firefox \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
  && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

#============
# GeckoDriver
#============
ARG GECKODRIVER_VERSION=0.30.0
RUN GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+)".*/\1/'); else echo $GECKODRIVER_VERSION; fi) \
  && echo "Using GeckoDriver version: "$GK_VERSION \
  && wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GK_VERSION \
  && chmod 755 /opt/geckodriver-$GK_VERSION \
  && ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver

# Install 'pulseaudio' package to support WebRTC audio streams
RUN apt-get update -qqy \
 && apt-get -qqy --no-install-recommends install -y pulseaudio software-properties-common \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Generating a default config during build time
# COPY generate_config /opt/bin/generate_config
# RUN /opt/bin/generate_config > /opt/selenium/config.json

#====================================
# Scripts to run Selenium Standalone
#====================================
COPY entry_point.sh /opt/bin/entry_point.sh
COPY functions.sh /opt/bin/functions.sh

EXPOSE 4444