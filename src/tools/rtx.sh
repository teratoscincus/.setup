#!/usr/bin/env bash

# Runtime executor
# https://github.com/jdxcode/rtx

# Install and use globally
GLOBALS_USED=(
	node@lts
	lua@latest
	luaJIT@latest
	python@latest
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
	java@adoptopenjdk-8
	java@11
	java@17
	java@latest
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
