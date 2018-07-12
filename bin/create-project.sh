#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPT_DIR}/../includes/io.sh"

DEBUG=false

UPDATE_MODE=false
TEMPLATE="basic"

while getopts ":dn:t:u" OPTION
do
    case ${OPTION} in
        d)
            DEBUG=true
            ;;
        n)
            PROJECT_NAME="${OPTARG}"
            ;;
        t)
            TEMPLATE="${OPTARG}"
            ;;
        u)
            UPDATE_MODE=true
            ;;
    esac
done

if [ -z "${SFW_BASE_DIR}" ]
then
    errorline "SFW_BASE_DIR variable is required to be set"
    exit 1
fi

if [ -z "${PROJECT_NAME}" ]
then
    errorline "Project name is required: -n PROJECT_NAME"
    exit 1
fi

if ${UPDATE_MODE}
then
    if [ ! -d "./${PROJECT_NAME}" ]
    then
        errorline "Cannot update: directory ${PROJECT_NAME} doesn't exists."
        exit 1
    fi

    rm -rf "${PROJECT_NAME}/includes"
    cp -r "${SFW_BASE_DIR}/includes" "${PROJECT_NAME}/includes"

    exit 0
fi

if [ -d "./${PROJECT_NAME}" ]
then
    errorline "Directory ${PROJECT_NAME} already exists."
    exit 1
fi

if [ ! -f "${SFW_BASE_DIR}/templates/${TEMPLATE}.sh" ]
then
    errorline "No template named ${TEMPLATE} found in ${SFW_BASE_DIR}"
    exit 1
fi

mkdir "${PROJECT_NAME}"
cp -r "${SFW_BASE_DIR}/includes" "${PROJECT_NAME}/includes"
cp "${SFW_BASE_DIR}/templates/${TEMPLATE}.sh" "${PROJECT_NAME}/${PROJECT_NAME}.sh"
chmod +x "${PROJECT_NAME}/${PROJECT_NAME}.sh"
