#!/usr/bin/env bash

set -e

# Fixes issues with the KDE panel disappearing (had a couple of times in Kubuntu 21.04)

rm ~/.config/plasma-org.kde.plasma.desktop-appletrc || true

kquitapp5 plasmashell && kstart5 plasmashell &
