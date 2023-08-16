#!/usr/bin/env bash

if ! command -v flatpak &>/dev/null; then
    echo "'flatpak' could not be found"
    exit 1
fi

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
