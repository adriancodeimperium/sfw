#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPT_DIR}/includes/io.sh"

DEBUG=false

while getopts ":d" OPTION
do
    case ${OPTION} in
        d)
            DEBUG=true
            ;;
    esac
done
