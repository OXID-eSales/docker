Extended PHP base container
===========================

Based on the images provided at https://hub.docker.com/_/php.

Changes contain:
- Installing necessary PHP-extensions
- Use of msmtp for sendmail
- Removing memory limits on PHP
- Installing Xdebug and provide an option to enable it
- Installing Composer

To build locally use ./build.sh [Major].[Minor] a.e. `./build.sh 7.1`