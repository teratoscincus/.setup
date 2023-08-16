#!/usr/bin/env bash

if [[ "$1" == '-h' || "$1" == '--help' ]]; then
	cat <<HELP
OPTIONS:
      --skip-os         Skips installation of package manager packages
  -h, --help            Show this help message

HELP
	exit
fi

warn() {
	LABEL_PREFIX='['
	LABEL_SUFIX=']'
	LABEL='WARN'
	FORMATTED_PREFIX="$LABEL_PREFIX\033[1;31m$LABEL\033[0m$LABEL_SUFIX"
	echo -e "${FORMATTED_PREFIX} ${1}"
}

ok() {
	LABEL_PREFIX='['
	LABEL_SUFIX=']'
	LABEL=' OK '
	FORMATTED_PREFIX="$LABEL_PREFIX\033[1;32m$LABEL\033[0m$LABEL_SUFIX"
	echo -e "${FORMATTED_PREFIX} ${1}"
}

note() {
	LABEL_PREFIX='['
	LABEL_SUFIX=']'
	LABEL='NOTE'
	FORMATTED_PREFIX="$LABEL_PREFIX\033[1;34m$LABEL\033[0m$LABEL_SUFIX"
	echo -e "${FORMATTED_PREFIX} ${1}"
}

# Install packages handled by the OS package manager
install_os_packages() {
	# Determine OS
	if [ -f /etc/os-release ]; then
		source /etc/os-release
		OS=$(echo "$NAME" | awk '{print tolower($0)}')
	fi

	# Set package manager commands
	case "$OS" in
	'void')
		update() {
			sudo xbps-install -Su
		}
		install() {
			sudo xbps-install "$@"
		}
		INIT='runit'
		;;
	*)
		warn 'OS support not implemented'
		exit
		;;
	esac

	# Install packages from list
	PACKAGE_LIST=./resources/distro/$OS/packages.txt
	if [[ -f $PACKAGE_LIST ]]; then
		# Install from package list
		update
		while read package; do
			install "$package"
		done <"$PACKAGE_LIST"
	else
		warn 'Missing list of packages'
		echo "  Couldn't locate $PACKAGE_LIST"
		exit
	fi

	# Set up services
	if [[ $INIT ]]; then
		source ./src/services/"$INIT"/services.sh
	else
		warn 'Unable to setup services'
		exit
	fi
}
[[ "$1" != '--skip-os' ]] && install_os_packages

# Install other tools
install_other_tools() {
	# NOTE: Additional configuration for these may be needed.
	# This can include extending $PATH and other environmental variables, or setting various
	# `eval $(<package> init - )` in the shell configuration.

	for tool in ./src/tools/*; do
		[[ -f "$tool" ]] && source "$tool"
	done
}

# Success message
echo ''
ok 'Packages and services setup!'
note 'You may now restart your system'
echo ''
note 'You may want to fetch your dotfiles before rebooting!'
note 'You may want to change your default shell!'
