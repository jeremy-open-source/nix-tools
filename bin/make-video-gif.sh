#!/usr/bin/env bash

set -e

NAME="${1}"

# See: https://askubuntu.com/questions/648603/how-to-create-an-animated-gif-from-mp4-video-via-command-line

ffmpeg \
  -i "${NAME}.mp4" \
  -r 15 \
  -vf "scale=512:-1,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
  -ss 00:00:03 -to 00:00:06 \
  "${NAME}.gif"
