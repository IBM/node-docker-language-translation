#!/bin/bash

set -o errexit

main() {
  setup_dependencies
  update_docker_configuration
  install_markdownlint_cli

  echo "SUCCESS:
  Done! Finished setting up Travis machine.
  "
}

setup_dependencies() {
  echo "INFO:
  Setting up dependencies.
  "

  sudo apt update -y
  sudo apt install --only-upgrade docker-ce npm -y
  docker info
}

update_docker_configuration() {
  echo "INFO:
  Updating docker configuration
  "

  echo '{
  "experimental": true,
  "storage-driver": "overlay2",
  "max-concurrent-downloads": 50,
  "max-concurrent-uploads": 50
}' | sudo tee /etc/docker/daemon.json
  sudo service docker restart
}

install_markdownlint_cli() {
  npm -g install markdownlint-cli
}

main
