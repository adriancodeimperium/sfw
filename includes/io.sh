#!/usr/bin/env bash

line() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] ${1}"
}

logline() {
    line "${1}"
}

errorline() {
    >&2 line "${1}"
}

debugline() {
    if ${DEBUG}
    then
        logline "${1}"
    fi
}
