#!/usr/bin/env bash

# Runtime executor
# https://github.com/jdxcode/mise

# Install and use globally
GLOBALS_USED=(
    node@lts
    lua@latest
    luaJIT@latest
    go@latest
    rust@stable
    java@lts
    maven@latest
    gradle@latest
    spring-boot@latest
    sqlite@latest
    mysql@latest
)

# Install only
ENSURE_INSTALLED=(
    python@3.9
    python@3.10
    python@3.11
    python@latest
    java@adoptopenjdk-8
    java@11
    java@17
    java@latest
)

# Check that `mise` is installed
if ! command -v mise &>/dev/null; then
    echo "'mise' could not be found"
    exit 1
fi

# Install from above lists
for tool in "${GLOBALS_USED[@]}"; do
    mise install "$tool"
    mise use -g "$tool"
done

for tool in "${ENSURE_INSTALLED[@]}"; do
    mise install "$tool"
done
