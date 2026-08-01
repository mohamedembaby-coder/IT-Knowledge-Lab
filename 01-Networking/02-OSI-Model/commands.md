# OSI Model Commands | أوامر نموذج OSI

> استخدم الأوامر كأدلة تشخيص (Evidence) حسب الطبقة. شغّل PowerShell كمسؤول فقط عند الحاجة، وتجنب أوامر reset أو التغيير في الإنتاج من دون change approval.

## Layer 1 — Physical | الطبقة الفيزيائية

```powershell
Get-NetAdapter | Format-Table Name, Status, LinkSpeed, MacAddress -Auto
Get-NetAdapterStatistics -Name 'Ethernet'
```

| الأمر | ما الذي يتحقق منه؟ |
|---|---|
| `Get-NetAdapter` | حالة NIC والسرعة وMAC؛ يثبت link محلياً. |
| `Get-NetAdapterStatistics` | counters محلية تساعد على تتبع errors/discards. |
| `netsh wlan show interfaces` | signal، channel، SSID، وWi-Fi rate. |

## Layer 2 — Data Link | طبقة ربط البيانات

```cmd
getmac /v
arp -a
```

```powershell
Get-NetNeighbor -AddressFamily IPv4
Get-NetAdapterAdvancedProperty -Name 'Ethernet'
```

| التفسير | الملاحظة |
|---|---|
| `arp -a` / `Get-NetNeighbor` | يعرض IP-to-MAC cache؛ entry مفقود قد يشير إلى L2 reachability أو target offline. |
| `getmac /v` | يعرض MAC وconnection name للمقارنة مع switch MAC table. |
| Cisco: `show mac address-table` | يثبت أين تعلم switch MAC العميل. |

## Layer 3 — Network | طبقة الشبكة

```cmd
ipconfig /all
route print
ping <default-gateway>
tracert -d <destination-ip>
```

```powershell
Get-NetIPConfiguration
Get-NetRoute -AddressFamily IPv4
Test-Connection -TargetName <destination-ip> -Count 4
```

| الدليل | الاستخدام |
|---|---|
| `ipconfig /all` | IP، prefix/mask، gateway، DNS، DHCP lease. |
| `route print` / `Get-NetRoute` | route والـ next hop والـ metric. |
| `tracert -d` | يحدد hop الذي يبدأ بعده الفشل؛ `-d` يمنع تأخير DNS. |

## Layer 4 — Transport | طبقة النقل

```powershell
Test-NetConnection app01.corp.example -Port 443 -InformationLevel Detailed
Get-NetTCPConnection -State Established
Get-NetUDPEndpoint
```

```cmd
netstat -ano
netstat -ano | findstr :443
```

| نتيجة | تفسير أولي |
|---|---|
| `TcpTestSucceeded : True` | TCP path والمنفذ متاحان من هذا العميل. |
| `SYN_SENT` مستمر | قد يكون ACL/firewall/route أو server لا يرد. |
| `LISTENING` على الخادم | الخدمة تستقبل اتصالات؛ افحص firewall/application بعد ذلك. |

## Layers 5–7 — Session, Presentation, Application

```powershell
Resolve-DnsName app01.corp.example
Test-NetConnection app01.corp.example -Port 443
curl.exe -I https://app01.corp.example
Get-WinEvent -LogName System -MaxEvents 20
```

| الأمر | الطبقة التي يساعد على عزلها |
|---|---|
| `Resolve-DnsName` | Layer 7 name resolution. |
| `curl.exe -I` | HTTP status وTLS/HTTP response بشكل أولي. |
| `Get-WinEvent` | DNS client، NIC، TLS، والخدمات حسب source. |
| `klist` | Kerberos tickets؛ مفيد لمشكلات session/authentication في AD. |

## Workflow: Windows Client إلى تطبيق HTTPS

```powershell
Get-NetAdapter
Get-NetIPConfiguration
Test-Connection -TargetName <default-gateway> -Count 2
Resolve-DnsName app01.corp.example
Test-NetConnection app01.corp.example -Port 443 -InformationLevel Detailed
curl.exe -I https://app01.corp.example
```

## Cisco Verification Commands

```cisco
show interfaces status
show interfaces counters errors
show vlan brief
show interfaces trunk
show mac address-table dynamic
show ip interface brief
show ip route
show logging
```

## Recovery Commands — بحذر

| الأمر | الأثر | متى يستخدم؟ |
|---|---|---|
| `ipconfig /renew` | يطلب DHCP lease جديداً | بعد التحقق من VLAN/DHCP، في endpoint فقط. |
| `Clear-DnsClientCache` | يمسح DNS cache محلياً | بعد تأكيد record حديث أو cache stale. |
| `netsh winsock reset` | يحتاج restart ويؤثر في الشبكة | كآخر خيار بعد baseline وموافقة. |

## ملاحظات CCNA

- `ping` يستخدم ICMP (Layer 3)، لذلك لا يثبت TCP/443 أو حالة تطبيق الويب.
- ARP cache دليل مفيد، لكن absence قد ينتج من cache timeout؛ لا تعتبره سبباً منفرداً.
- ابدأ بـ `show` commands في Cisco قبل أي `configure terminal` أثناء incident.
