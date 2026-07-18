# Cheat Sheet

## Important Commands

| Command | Description |
|----------|-------------|
| `ping <IP/host>` | Test basic connectivity (ICMP echo) |
| `ipconfig /all` (Windows) | Show full IP configuration and MAC address |
| `ifconfig` / `ip addr` (Linux) | Show interface configuration |
| `tracert <IP/host>` (Windows) | Show the path (hops) to a destination |
| `traceroute <IP/host>` (Linux) | Same as above on Linux |
| `arp -a` | Show the ARP table (IP-to-MAC mapping) |
| `netstat -an` | Show active connections and listening ports |
| `nslookup <host>` | Quick DNS lookup |

---

## Ports

| Port | Protocol | Service |
|------|----------|---------|
| 20/21 | TCP | FTP (Data/Control) |
| 22 | TCP | SSH |
| 23 | TCP | Telnet |
| 25 | TCP | SMTP |
| 53 | TCP/UDP | DNS |
| 67/68 | UDP | DHCP |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |
| 3389 | TCP | RDP |

---

## Tips

- Keep this page short.
- Add only quick references.
- Straight-Through cable = PC to Switch. Crossover cable = Switch to Switch / PC to PC (rarely needed manually now due to Auto-MDIX).
- Fiber Single-Mode = long distance (yellow cable). Multi-Mode = short distance (orange/aqua cable).


---

# Quick Reference

## Common Network Types

| Type | Range |
|------|-------|
| PAN | Personal |
| LAN | Building |
| MAN | City |
| WAN | Country/World |

## OSI Layers

1. Physical
2. Data Link
3. Network
4. Transport
5. Session
6. Presentation
7. Application

## Common Ports

| Service | Port |
|---------|-----:|
| HTTP | 80 |
| HTTPS | 443 |
| DNS | 53 |
| DHCP | 67/68 |
| SSH | 22 |
| RDP | 3389 |
