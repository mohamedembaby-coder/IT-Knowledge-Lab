#!/usr/bin/env bash
# Capture DHCP only. Run with appropriate local authorization.
set -euo pipefail

interface_name="${1:?Usage: capture-dhcp.sh <interface> [capture-file]}"
capture_file="${2:-dhcp-capture.pcapng}"

sudo tcpdump -ni "$interface_name" -w "$capture_file" 'udp port 67 or udp port 68'
