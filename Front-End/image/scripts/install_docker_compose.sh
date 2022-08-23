#! /usr/bin/env bash

install_docker_compose() {
  echo "[$(date +%H:%M:%S)]: Installing Docker Compose..."
  curl -s -L "https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  docker-compose -v
}

install_docker_compose