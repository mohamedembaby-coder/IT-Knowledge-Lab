# TCP/IP Cheat Sheet | ملخص TCP/IP

## Layers and PDUs

| Layer | PDU | Addressing | Protocols |
|---|---|---|---|
| Application | Data | FQDN/URL | HTTP(S), DNS, DHCP |
| Transport | Segment/Datagram | TCP/UDP port | TCP, UDP |
| Internet | Packet | IPv4/IPv6 | IP, ICMP |
| Network Access | Frame/Bits | MAC/VLAN/media | Ethernet, Wi-Fi, ARP |

## TCP Handshake and Close

```text
Open:  SYN → SYN-ACK → ACK
Close: FIN → ACK ← FIN ← ACK
```

## TCP vs UDP

| TCP | UDP |
|---|---|
| connection-oriented | connectionless |
| reliable and ordered | best effort |
| retransmission/window | low overhead |
| HTTPS/SMB/RDP | DNS/DHCP/NTP/VoIP |

## IPv4 vs IPv6

| IPv4 | IPv6 |
|---|---|
| 32-bit, dotted decimal | 128-bit, hexadecimal |
| ARP | NDP/ICMPv6 |
| DHCPv4 | SLAAC/DHCPv6 |
| broadcast | multicast/anycast |
| `ping -4` | `ping -6` |

## Core Flows

| Flow | Sequence |
|---|---|
| DHCPv4 | Discover → Offer → Request → ACK |
| DNS | Client → Resolver → Authoritative → Answer |
| ARP | Broadcast request → Unicast reply |
| ICMP ping | Echo Request → Echo Reply |

## Ports

| Port | Service |
|---:|---|
| 53 UDP/TCP | DNS |
| 67/68 UDP | DHCP |
| 80/443 TCP | HTTP/HTTPS |
| 22 TCP | SSH |
| 25/587 TCP | SMTP |
| 123 UDP | NTP |
| 389/636 TCP | LDAP/LDAPS |
| 445 TCP | SMB |
| 3389 TCP/UDP | RDP |

## Windows Commands

```powershell
Get-NetIPConfiguration
Resolve-DnsName server01
Test-NetConnection server01 -Port 443
Get-NetRoute
Get-NetNeighbor
```

```cmd
ipconfig /all
ping -4 server01
tracert -d server01
nslookup server01
netstat -ano
```

## CCNA Reminders

- ICMP ليس TCP/UDP، بل control protocol في Internet layer.
- ARP لا يعبر Router؛ يبحث العميل عن MAC الـ default gateway للوجهات البعيدة.
- TCP port يحدد service داخل host، وIP يحدد host/network.
- DNS success لا يثبت أن TCP port أو application service متاح.
