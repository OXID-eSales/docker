#!/bin/sh

if [ "$ENABLE_WEBDRIVER" = true ] && [ "$DISABLE_X11" = true ]; then
  exec chromedriver "$@"
fi

if [ "$ENABLE_WEBDRIVER" = true ]; then
  chromedriver &
fi

if [ "$DISABLE_X11" = true ]; then
  exec "$@"
fi

if [ "$ENABLE_VNC" = true ]; then
  set -- vnc-start "$@"
fi

if [ "$EXPOSE_X11" = true ]; then
  set -- --listen-tcp "$@"
fi

# 6000+SERVERNUM is the TCP port Xvfb is listening on:
SERVERNUM=$(echo "$DISPLAY" | sed 's/:\([0-9][0-9]*\).*/\1/')

# Options passed directly to the Xvfb server:
# -ac disables host-based access control mechanisms
# −screen NUM WxHxD creates the screen and sets its width, height, and depth
SERVERARGS="-ac -screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH}"

exec xvfb-run --server-num "$SERVERNUM" --server-args "$SERVERARGS" "$@"