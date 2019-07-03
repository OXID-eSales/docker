OXID eShop Community Edition
============================

This container is based on the images provided by https://hub.docker.com/r/oxidesales/oxideshop-docker-php.

For an example usage see https://github.com/OXID-eSales/oxvm_eshop/tree/docker_developer_preview.

The containers provided by this repository will contain a prepared shop:
* Using a Compilation Version a.e. oxidesales/oxideshop-docker-ce:v6.1.3 will provide a demonstration shop based on https://github.com/OXID-eSales/oxideshop_project
* Appending the -dev flag a.e. oxidesales/oxideshop-docker-ce:v6.1.3-dev will provide an installation optimized for development purposes based on https://github.com/OXID-eSales/oxideshop_ce

**Building your own container**<br>

If you need to build the shop on your own you may use the provided build.sh script a.e. `./build.sh -t project -s v6.1.3` or `./build.sh -t dev -s v6.1.3`.

This script is a wrapper providing easy building of the containers.

**Parameters**:

- "-t" defines the target, available values are the two different image flavours "dev" and "project"
- "-s" defines the shop version to be created, valid values are the release tags from https://github.com/OXID-eSales/oxideshop_metapackage_ce/tags

**Notice:**

- For "-t dev" all tags from https://github.com/OXID-eSales/oxideshop_metapackage_ce/tags are valid to be used
- For "-t project" a dependency file has to be available a.e. `project/dependencies/v6.1.3.sh`
