#!/bin/bash

# Runtime executor
# https://github.com/jdxcode/rtx

# Install and use globally
GLOBALS_USED=(
	node@lts
	python@latest
	go@latest
	java@17
	spring-boot@latest
	sqlite@3.42
	mysql@8
)

# Install only
ENSURE_INSTALLED=(
	java@adoptopenjdk-8
)

# Check that `rtx` is installed
if ! command -v rtx &>/dev/null; then
	echo "'rtx' could not be found"
	exit
fi

# Install from above lists
for tool in "${GLOBALS_USED[@]}"; do
	rtx install "$tool"
	rtx use -g "$tool"
done

for tool in "${ENSURE_INSTALLED[@]}"; do
	rtx install "$tool"
done
