Custom Selenium container
=========================

Based on the images provided at https://hub.docker.com/r/selenium/node-base.

Changes contain:
- Fixed version for Firefox
- Installation of x11vnc

**Notice:**
- This container exposes port 5900 for VNC (which is the default VNC port).
- The password for the login is "secret".