#!/bin/bash

NODE_VERSION="11.14.0"
export DOCKER_PWD=$(pwd)
DOCKER_USER="$(id -u ${USER}):$(id -g ${USER})"
DOCKER_PORTS="-p 127.0.0.1:3000:3000/tcp"
DOCKER_COMMAND="docker run $DOCKER_PORTS -it --rm -u $DOCKER_USER -v $(pwd):$(pwd) -w $(pwd)"

alias npm="$DOCKER_COMMAND node:$NODE_VERSION npm"
alias node="$DOCKER_COMMAND node:$NODE_VERSION node"
