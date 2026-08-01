# TCP/IP Commands | أوامر TCP/IP

> نفّذ الأوامر في مختبر أو على جهاز مصرح به. اجمع output قبل التغيير، وميّز بين read-only verification وأوامر recovery.

## Windows: Local Configuration

```powershell
Get-NetIPConfiguration
Get-NetAdapter
Get-NetIPAddress -AddressFamily IPv4
Get-NetRoute -AddressFamily IPv4
Get-DnsClientServerAddress
```

```cmd
ipconfig /all
route print
hostname
getmac /v
```

| الأمر | الاستخدام |
|---|---|
| `ipconfig /all` | IPv4/IPv6، mask، gateway، DHCP، DNS، lease |
| `Get-NetIPConfiguration` | التحقق بصيغة PowerShell قابلة للمعالجة |
| `route print` | routing table وinterfaces وmetrics |
| `Get-NetRoute` | routes حسب address family وdestination prefix |

## ICMP and Path Testing

```powershell
Test-Connection -TargetName 10.20.20.1 -Count 4
Test-Connection -TargetName server01 -IPv4 -Count 4
Test-Connection -TargetName server01 -IPv6 -Count 4
```

```cmd
ping 10.20.20.1
ping -4 server01.corp.example
ping -6 server01.corp.example
tracert -d 10.30.30.10
pathping -n 10.30.30.10
```

فشل ICMP قد ينتج من policy؛ لا تعتبره فشل TCP أو application.

## ARP / Neighbor Discovery

```cmd
arp -a
arp -d *
```

```powershell
Get-NetNeighbor -AddressFamily IPv4
Get-NetNeighbor -AddressFamily IPv6
```

استخدم `arp -d *` في مختبر فقط؛ يمسح cache المحلي وقد يسبب فشل اتصالات مؤقتاً.

## DNS

```powershell
Resolve-DnsName portal.corp.example
Resolve-DnsName portal.corp.example -Type A
Resolve-DnsName portal.corp.example -Type AAAA
Resolve-DnsName _ldap._tcp.corp.example -Type SRV
Clear-DnsClientCache
```

```cmd
nslookup portal.corp.example
nslookup -type=SRV _ldap._tcp.corp.example
ipconfig /displaydns
ipconfig /flushdns
ipconfig /registerdns
```

## DHCP

```cmd
ipconfig /all
ipconfig /release
ipconfig /renew
```

```powershell
Get-NetIPConfiguration
Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-DHCP-Client'} -MaxEvents 20
```

`169.254.0.0/16` يعني APIPA غالباً: افحص VLAN وDHCP scope وrelay وACL قبل تكرار renew.

## TCP / UDP Ports

```powershell
Test-NetConnection portal.corp.example -Port 443 -InformationLevel Detailed
Test-NetConnection dc01.corp.example -Port 53
Get-NetTCPConnection -State Listen
Get-NetTCPConnection -State Established
Get-NetUDPEndpoint
```

```cmd
netstat -ano
netstat -ano | findstr :443
tasklist /fi "PID eq <PID>"
```

## Wireshark Display Filters

```text
icmp
arp
dns
dhcp || bootp
tcp.flags.syn == 1
tcp.port == 443
udp.port == 53
ip.addr == 10.30.30.10
ipv6
```

التقط على الواجهة الصحيحة، واستخدم display filters بعد capture، واحفظ timestamp وsource/destination وfilter في ticket.

## Cisco IOS Verification

```cisco
show ip interface brief
show ip route
show ip arp
show interfaces counters errors
show logging
show access-lists
show running-config | section ip helper
```

## Linux Equivalents

```bash
ip addr
ip route
ip neigh
resolvectl query portal.corp.example
ss -tulpn
ping -4 -c 4 10.20.20.1
traceroute -n 10.30.30.10
```

## Recovery Safety

| الأمر | المخاطر |
|---|---|
| `ipconfig /release` | يفصل lease الحالي |
| `Clear-DnsClientCache` | يمسح cache؛ ليس إصلاحاً لسجل DNS خاطئ |
| `netsh winsock reset` | يحتاج restart وقد يؤثر في applications |
| `netsh int ip reset` | يغير TCP/IP state؛ استخدمه كآخر حل |
