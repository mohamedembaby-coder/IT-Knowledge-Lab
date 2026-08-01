# OSI Model Cheat Sheet | الملخص السريع لنموذج OSI

## الطبقات السبع

| # | Layer | الوظيفة | PDU | Addressing | أمثلة |
|---:|---|---|---|---|---|
| 7 | Application | خدمات التطبيقات | Data | FQDN/URL | HTTP, DNS, SMTP |
| 6 | Presentation | encryption/formatting | Data | — | TLS, UTF-8, gzip |
| 5 | Session | إدارة الجلسة | Data | Session ID | RPC, SMB session |
| 4 | Transport | ports/reliability | Segment/Datagram | TCP/UDP port | TCP, UDP |
| 3 | Network | routing | Packet | IP address | IPv4, IPv6, ICMP |
| 2 | Data Link | switching/VLAN | Frame | MAC address | Ethernet, 802.1Q |
| 1 | Physical | signal/media | Bits | — | UTP, fiber, Wi-Fi |

## Mnemonics | طرق الحفظ

```text
Top → Bottom: All People Seem To Need Data Processing
Bottom → Top: Please Do Not Throw Sausage Pizza Away
```

## OSI مقابل TCP/IP

| OSI | TCP/IP |
|---|---|
| Application + Presentation + Session | Application |
| Transport | Transport |
| Network | Internet |
| Data Link + Physical | Network Access |

## الأجهزة

| Device | Layer | Key decision |
|---|---:|---|
| Hub | 1 | يعيد الإشارة للجميع |
| Switch | 2 | destination MAC |
| Router/L3 Switch | 3 | destination IP/routing table |
| Firewall | 3–7 | policy حسب IP/port/app/user |

## TCP مقابل UDP

| TCP | UDP |
|---|---|
| reliable, ordered, connection-oriented | lightweight, connectionless, low latency |
| HTTPS, SMB, RDP | DNS, NTP, VoIP |
| Segment | Datagram |

## أدوات Windows حسب الطبقة

| Layer | Command |
|---:|---|
| 1 | `Get-NetAdapter`, `netsh wlan show interfaces` |
| 2 | `getmac /v`, `arp -a`, `Get-NetNeighbor` |
| 3 | `ipconfig /all`, `route print`, `tracert -d` |
| 4 | `Test-NetConnection -Port`, `netstat -ano` |
| 7 | `Resolve-DnsName`, `curl.exe -I` |

## منفذ وخدمة

| Port | Protocol | Service |
|---:|---|---|
| 53 | UDP/TCP | DNS |
| 67/68 | UDP | DHCP |
| 80/443 | TCP | HTTP/HTTPS |
| 88 | TCP/UDP | Kerberos |
| 123 | UDP | NTP |
| 389/636 | TCP | LDAP/LDAPS |
| 445 | TCP | SMB |
| 3389 | TCP/UDP | RDP |

## Troubleshooting Ladder

```text
L1 Link → L2 VLAN/MAC → L3 IP/Gateway/Route → L4 Port/Firewall → L5–L7 DNS/TLS/App
```

## CCNA Facts

- Source MAC هو ما يتعلمه switch.
- Router يفصل broadcast domains ويعيد تغليف Layer 2 لكل hop.
- TCP: SYN → SYN-ACK → ACK.
- لا تخلط IP address (L3) وMAC address (L2) وport number (L4).
