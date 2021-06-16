#!/usr/bin/env bash

# https://askubuntu.com/questions/123798/how-to-hear-my-voice-in-speakers-with-a-mic
arecord -f cd - | aplay -

# arecord -f cd - | tee output.wav | aplay -
