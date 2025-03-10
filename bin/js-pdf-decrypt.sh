#!/usr/bin/env bash

set -eu -o pipefail

IN_FILE=${1}
PASSWORD=${2}
OUT_FILE=${3}

if [[ -z "${IN_FILE}" ]] ; then
  read -r -p "Input File :" IN_FILE
fi
if [[ -z "${PASSWORD}" ]] ; then
  read -r -p "Password :" PASSWORD
fi
if [[ -z "${OUT_FILE}" ]] ; then
  read -r -p "Output File :" OUT_FILE
fi

# pdftk "${IN_FILE}" input_pw "${PASSWORD}" output "${OUT_FILE}"
qpdf --password="${PASSWORD}" --decrypt "${IN_FILE}" "${OUT_FILE}"

