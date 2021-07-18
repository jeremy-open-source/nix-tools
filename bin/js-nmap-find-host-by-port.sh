#!/usr/bin/env bash

# Look for a host with a specific port that's open
nmap -p 88 --open 192.168.1.1-255
