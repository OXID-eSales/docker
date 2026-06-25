FROM ghcr.io/actions/actions-runner:latest

USER root

COPY src /

RUN /install/install_runner_packages.sh

USER runner
