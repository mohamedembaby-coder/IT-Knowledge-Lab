# Commands

## Purpose

This file contains all commands related to this lesson (Networking Fundamentals).

---

## Windows

```powershell
# Show full IP configuration
ipconfig /all

# Test connectivity to a host
ping 192.168.1.1

# Trace the route to a destination
tracert google.com

# Show the ARP table
arp -a

# Show network adapters and their status
Get-NetAdapter

# Reset the ARP cache
netsh interface ip delete arpcache
```

---

## Linux

```bash
# Show interface configuration (modern)
ip addr show

# Show interface configuration (legacy)
ifconfig

# Test connectivity
ping -c 4 192.168.1.1

# Trace the route
traceroute google.com

# Show the ARP table
ip neigh

# Show all active network connections
ss -tulnp
```

---

## Networking

```text
# Straight-Through cable = PC/Server <-> Switch/Router
# Crossover cable      = Switch <-> Switch, Router <-> Router, PC <-> PC (direct)

# Basic cable diagnostic checklist:
1. Check both ends are firmly connected (link light on).
2. Verify correct cable type for the connection (straight vs crossover, or note Auto-MDIX).
3. Check cable category matches required speed (Cat5e = 1G, Cat6/6a = 10G).
4. For fiber: verify Single-Mode vs Multi-Mode matches the transceiver (SFP) type on both ends.
```

---

## Notes

- Explain what each command does.
- Avoid using commands without description.
- `ping` uses ICMP — if blocked by a firewall, a host might be reachable but not respond to ping.
- `tracert`/`traceroute` are useful to identify exactly where a connection is failing along the path.


---

# Windows Networking Commands

```powershell
ipconfig /all
ping 8.8.8.8
tracert google.com
nslookup google.com
arp -a
route print
netstat -ano
hostname
getmac
```

# Linux

```bash
ip addr
ip route
ping 8.8.8.8
ss -tuln
hostnamectl
```
