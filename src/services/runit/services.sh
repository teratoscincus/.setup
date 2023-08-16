#!/usr/bin/env bash

enable_service() {
    # Takes an arbitrary number of string arguments and enables their service if they
    # are installed.
    ORIGIN="/etc/sv"
    SERVICES="/var/service"
    for service in "${@}"; do
        if [[ -d "$ORIGIN/$service/" ]]; then
            sudo ln -s "$ORIGIN/$service/" "$SERVICES/"
        else
            warn "Failed to enable $service"
            echo "  Not found in $ORIGIN/$service"
        fi
    done
}

disable_service() {
    # Takes an arbitrary number of string arguments and disables their service if they
    # are enabled.
    SERVICES="/var/service"
    for service in "${@}"; do
        if [[ -d "$SERVICES/$service" ]]; then
            sudo rm "$SERVICES/$service"
        fi
    done
}

# Utility services

# Dbus
enable_service "dbus"

# Udev
enable_service "udevd"

# NetworkManager
disable_service "dhcpcd" "wpa_supplicant" "wicd"
enable_service "NetworkManager"

# Elogind
disable_service "acpid"
enable_service "elogind"

# Alsa
enable_service "alsa"

# Bluetooth
enable_service "bluetoothd"

# Printers
enable_service "cupsd"

# Dev tool services

# Docker
enable_service "containerd" "docker"

# Clean up

unset -v ok
unset -f enable_service disable_service
