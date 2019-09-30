#!/bin/sh

chromedriver &
# uncomment to start vnc
# set -- vnc-start "$@"
# uncomment to expose X11 port
# set -- --listen-tcp "$@"

# 6000+SERVERNUM is the TCP port Xvfb is listening on:
SERVERNUM=0
SCREEN_WIDTH=1440
SCREEN_HEIGHT=900
SCREEN_DEPTH=24

# Options passed directly to the Xvfb server:
# -ac disables host-based access control mechanisms
# −screen NUM WxHxD creates the screen and sets its width, height, and depth
SERVERARGS="-ac -screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH}"

exec xvfb-run -a --server-num "$SERVERNUM" --server-args "$SERVERARGS" "google-chrome"