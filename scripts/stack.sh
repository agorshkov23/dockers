#!/bin/bash -e

function arg_deploy() {
    docker stack deploy --compose-file docker-compose.yml ${STACK_NAME}
}

function arg_pull() {
    docker-compose pull
}

function arg_status() {
    docker stack ps ${STACK_NAME}
}

function arg_stop() {
    echo 'stop is not implemented'
}

function arg_validate() {
    docker-compose config -q
}

if [[ -z $1 ]]; then
    echo "Required command name"
    exit 1
fi

if [[ `type -t arg_$1` != 'function' ]]; then
    echo "Not found command: ${1}"
    exit 1
fi

STACK_NAME=`basename ${PWD}`
echo "Detected stack name: ${STACK_NAME}"

echo "Start executing $1 at `date -Iseconds`..."
arg_${1}
