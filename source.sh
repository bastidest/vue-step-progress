#!/bin/bash

source .env

export COMPOSE_PROJECT_NAME=vue-step-progress

export DOCKER_PWD=$(pwd)
export DOCKER_USER="$(id -u):$(id -g)"

function _docker_cmd() {
    local ti_arg="-t"

    # if tty is available also open input
    if [ -t 1 ] ; then
        ti_arg="${ti_arg}i"
    fi

    docker run "$ti_arg" --rm -u "$DOCKER_USER" -v "$(pwd)":"$(pwd)" -w "$(pwd)" "$@"
}

function _npm() {
    _docker_cmd "node${DOCKER_NODE_VERSION}" npm "$@"
}

function _node() {
    _docker_cmd "node${DOCKER_NODE_VERSION}" node "$@"
}

function _node_run() {
    _docker_cmd "node${DOCKER_NODE_VERSION}" "$@"
}

# if is interactive shell, define aliases
if [[ $- == *i* ]] ; then
    alias npm="_npm"
    alias node="_node"
fi
