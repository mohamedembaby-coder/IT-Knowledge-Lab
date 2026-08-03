# DHCP Cheatsheet | ملخص DHCP

## DORA and Ports

| Order | Packet | Client state/action | Typical destination |
|---:|---|---|---|
| 1 | Discover | يبحث عن server | Broadcast `255.255.255.255` |
| 2 | Offer | عرض عنوان/options | Broadcast أو unicast |
| 3 | Request | يختار offer أو يجدد lease | Broadcast في initial request |
| 4 | ACK | يثبت lease/configuration | إلى client |

`UDP 68` = DHCP client، `UDP 67` = DHCP server. `NAK` يعني أن العنوان/الشبكة لم تعد صالحة؛ يبدأ client DORA مجدداً.

## Lifecycle

| State | Trigger | Behavior |
|---|---|---|
| INIT | لا lease صالحة | DORA. |
| BOUND | ACK received | يستخدم الإعدادات. |
| RENEWING | T1 ≈ 50% | unicast Request إلى server الأصلي. |
| REBINDING | T2 ≈ 87.5% | broadcast Request إلى أي server. |
| EXPIRED | انتهت lease | يتوقف عن العنوان ويبدأ من INIT. |

## Essential Options

`1` mask · `3` router/default gateway · `6` DNS · `15` domain suffix · `42` NTP · `51` lease time · `53` message type · `54` server identifier · `66/67` PXE boot · `82` relay information.

## Cisco IOS Quick Reference

```cisco
ip dhcp excluded-address 10.10.10.1 10.10.10.49
ip dhcp pool USERS-10
 network 10.10.10.0 255.255.255.0
 default-router 10.10.10.1
 dns-server 10.10.100.10 10.10.100.11
 domain-name corp.example
 lease 8

interface Vlan10
 ip helper-address 10.10.100.20
```

## Windows and Linux Quick Checks

```powershell
Get-DhcpServerv4Scope
Get-DhcpServerv4Lease -ScopeId 10.10.10.0
ipconfig /all
ipconfig /release; ipconfig /renew
```

```bash
ip -4 addr show
journalctl -u kea-dhcp4 -n 100 --no-pager
sudo tcpdump -ni eth0 -vv 'udp port 67 or udp port 68'
```

## Snooping

```cisco
ip dhcp snooping
ip dhcp snooping vlan 10,20,30
interface GigabitEthernet1/0/48
 ip dhcp snooping trust
interface range GigabitEthernet1/0/1-47
 ip dhcp snooping limit rate 15
show ip dhcp snooping
show ip dhcp snooping binding
```

Trust only verified uplinks/server-facing ports. Do not trust user ports.
