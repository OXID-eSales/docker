#!/bin/bash
set -e
set -x
if [ -z "$CHROME_DRIVER_VERSION" ]; then
    CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/")
    NO_SUCH_KEY=$(curl -ls https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION} | head -n 1 | grep -oe NoSuchKey)
    while [ -n "$NO_SUCH_KEY" ]; do
      echo "No Chromedriver for version ${CHROME_MAJOR_VERSION}. Use previous major version instead"
      CHROME_MAJOR_VERSION=$((CHROME_MAJOR_VERSION--))
      NO_SUCH_KEY=$(curl -ls https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION} | head -n 1 | grep -oe NoSuchKey)
    done
    CHROME_DRIVER_VERSION=$(wget --no-verbose -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION}");
fi
echo "Using chromedriver version: ${CHROME_DRIVER_VERSION}"
wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip
rm -rf /opt/selenium/chromedriver
sudo unzip /tmp/chromedriver_linux64.zip -d /opt/selenium
rm /tmp/chromedriver_linux64.zip
sudo mv "/opt/selenium/chromedriver" "/opt/selenium/chromedriver-${CHROME_DRIVER_VERSION}"
sudo chmod 755 "/opt/selenium/chromedriver-${CHROME_DRIVER_VERSION}"
sudo ln -fs "/opt/selenium/chromedriver-${CHROME_DRIVER_VERSION}" "/usr/bin/chromedriver"
