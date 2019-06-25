#!/bin/bash

composer require --dev oxid-esales/testing-library ^v5.0.4 --no-update -d /var/www/oxideshop &&
composer require --dev oxid-esales/coding-standards ^v3.0.5 --no-update -d /var/www/oxideshop &&
composer require --dev oxid-esales/azure-theme ^v1.4.2 --no-update -d /var/www/oxideshop &&
composer require --dev oxid-esales/oxideshop-ide-helper ^v3.1.2 --no-update -d /var/www/oxideshop &&
composer require --dev incenteev/composer-parameter-handler ~v2.0 --no-update -d /var/www/oxideshop