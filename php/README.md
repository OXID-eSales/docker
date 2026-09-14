Extended PHP base container
===========================

Based on the images provided at https://hub.docker.com/_/php.

Changes contain:
- Installing necessary PHP-extensions
- Use of msmtp for sendmail
- Removing memory limits on PHP
- Installing Xdebug and provide an option to enable it
- Installing Composer
- Installing PIE (the pecl successor) for adding further extensions (not on 8.6-rc)
- Skipping server certificate verification in the mysql/mariadb clients, as the dev databases use self-signed certificates

To build locally use ./build.sh [Major].[Minor], e.g. `./build.sh 8.4`