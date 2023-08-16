#!/usr/bin/env bash

# Command line cheatsheet
# https://github.com/denisidoro/navi

if command -v navi &>/dev/null; then
    exit
fi

SRC_DEST=$XDG_DATA_HOME/navi
git clone https://github.com/denisidoro/navi "$SRC_DEST"
cd "$SRC_DEST" || exit 1
# Set the install directory:
make BIN_DIR=/usr/local/bin install
make install
