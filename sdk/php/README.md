Extended PHP base container for OXID eShop SDK
==============================================

Based on the images provided at https://hub.docker.com/_/php.

Changes contain:
- Installing necessary PHP-extensions
- Use of msmtp for sendmail
- Removing memory limits on PHP
- Installing Xdebug
- Installing Composer
- Installing SPX

To build locally use ./build.sh [Major].[Minor] a.e. `./build.sh 7.4`