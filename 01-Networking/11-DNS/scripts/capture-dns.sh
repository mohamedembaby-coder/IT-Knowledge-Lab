#!/usr/bin/env bash
set -euo pipefail

interface="${1:?Usage: $0 <interface> [output.pcapng]}"
output="${2:-dns-evidence.pcapng}"

echo "Capturing DNS on ${interface}; stop with Ctrl+C. Output: ${output}" >&2
sudo tcpdump -ni "$interface" -s 0 -w "$output" 'udp port 53 or tcp port 53'
