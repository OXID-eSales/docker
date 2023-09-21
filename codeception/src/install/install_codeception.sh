#!/bin/bash
set -e
set -x

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
apt-get update -qqy
apt-get -qqy install ${CHROME_VERSION:-google-chrome-stable} \
    python3-pip python3-venv
rm /etc/apt/sources.list.d/google-chrome.list
rm -rf /var/lib/apt/lists/* /var/cache/apt/*
chmod a+x /opt/bin/*
/opt/bin/wrap_chrome_binary
# setup a venv for pip
python3 -m venv python3_temporary
source python3_temporary/bin/activate
python3 -m pip install requests get-chrome-driver
cd /opt/selenium
if [ -n "${CHROME_DRIVER_VERSION}" ]; then
  echo "Using explicitly defined chromedriver version ${CHROME_DRIVER_VERSION}"
  get-chrome-driver --download-version ${CHROME_DRIVER_VERSION} --extract
else
    CHROME_DRIVER_VERSION=$(get-chrome-driver --stable-version)
    echo "Using chromedriver version matching the current chrome version"
    get-chrome-driver --auto-download --extract
fi
find .

# remove venv and pip
deactivate
rm -r python3_temporary
apt -y remove python3-venv python3-pip
apt-get clean
apt-get autoremove -y
# Install the driver
DRIVER=$(find /opt/selenium -type f -iname "chromedriver")
mv ${DRIVER} "/opt/selenium/chromedriver-${CHROME_DRIVER_VERSION}"
chmod 755 "/opt/selenium/chromedriver-${CHROME_DRIVER_VERSION}"
ln -fs "/opt/selenium/chromedriver-${CHROME_DRIVER_VERSION}" "/usr/bin/chromedriver"
DIR=$(dirname "${DRIVER}")
rm -r "${DIR}"
