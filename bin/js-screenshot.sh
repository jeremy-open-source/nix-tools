#!/usr/bin/env bash

set -e

TMP_FILE=$(mktemp --suffix ".jpg")
OUT_FILE="$HOME/Desktop/screenshot-$(date +%Y%m%d%H%M%S).jpg"
CROP="1920x1080+1920+0"
DRAW="text 270,55 \"Screenshot at ${DATE}\" "

spectacle \
  --fullscreen \
  --background \
  --nonotify \
  --output "${TMP_FILE}"

convert "${TMP_FILE}" \
  -crop "${CROP}" \
  "${OUT_FILE}"

DATE=$(date --iso-8601=seconds)

echo "DATE: ${DATE}"

convert "${OUT_FILE}" \
  -pointsize 40 -fill blue -draw "${DRAW}" \
  "${OUT_FILE}"
