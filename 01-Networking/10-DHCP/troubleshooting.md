# DHCP Troubleshooting | استكشاف أخطاء DHCP

## Evidence-First Workflow | منهجية مبنية على الدليل

1. حدد client MAC/client ID، VLAN، الوقت، scope المتوقع، وما إذا كانت المشكلة فردية أم جماعية.
2. تحقق من link، VLAN/access policy، وIP الحالي (`ipconfig /all` أو `ip addr`).
3. التقط/افحص DORA عند client أو relay؛ لا تغيّر scope قبل معرفة آخر packet وصل.
4. تحقق من scope state، free addresses، exclusions/reservations/conflicts، وOption 3/6/mask.
5. للـ remote VLAN، افحص SVI address و`ip helper-address` وrouting/ACL/VRF إلى server والعودة.
6. افحص Snooping trust/rate limits وrogue offers. نفذ تغييراً واحداً، ثم renew واختبر وسجل النتيجة.

## Symptom Matrix

| Symptom | Likely cause | Evidence | Resolution |
|---|---|---|---|
| Client لديه APIPA `169.254.x.x` | لا ACK من DHCP | capture يظهر Discover فقط أو Offer بلا ACK | افحص VLAN، relay، server/service، وpath قبل تغيير client. |
| كل VLAN بعيدة تفشل | missing/wrong helper أو routing/ACL | SVI config؛ server لا يرى `giaddr` requests | ضع helper على SVI الصحيح وصحح routing/policy. |
| VLAN واحدة فقط تفشل | scope inactive/exhausted أو scope/subnet mismatch | scope statistics وOption 1/3 | فعّل/وسّع scope وفق change control وصحح options. |
| Client يحصل على IP لكن لا يصل شبكات أخرى | gateway/mask/DNS option خاطئ | ACK و`ipconfig /all` | صحح Option 3/1؛ اختبر gateway ثم DNS/application. |
| أجهزة جديدة لا تحصل على lease بعد snooping | uplink ليس trusted أو rate limit منخفض | `show ip dhcp snooping statistics` | trust فقط المسار الشرعي واضبط rate بحذر. |
| عناوين duplicate أو conflict | static داخل pool أو stale lease | conflict log, ARP, inventory | أخرج static من pool/أضف exclusion، عالج lease بدليل. |
| Windows server لا يوزع | DHCP service/scope/AD authorization | service state، scope state، Event Viewer | ابدأ الخدمة، فعّل scope، authorize server وفق السياسة. |
| Offers متعددة أو gateway غريب | rogue DHCP | capture source MAC/IP؛ switch port | اعزل المنفذ وفق incident process، فعّل/راجع snooping. |
| Renewals تفشل لاحقاً | server/path unavailable عند T1/T2 | timestamps، Request بلا ACK | افحص server availability/firewall/relay والـ redundancy. |

## Focused Checks

```cisco
show ip dhcp pool
show ip dhcp binding
show ip dhcp conflict
show running-config interface Vlan10
show ip dhcp snooping
show ip dhcp snooping binding
show interfaces status
```

```powershell
ipconfig /all
Get-DhcpServerv4ScopeStatistics
Get-DhcpServerv4Lease -ScopeId 10.10.10.0
Get-Service DHCPServer
Get-WinEvent -LogName System -MaxEvents 100 | Where-Object ProviderName -Match 'Dhcp'
```

## Wireshark Analysis | تحليل Wireshark

استخدم `dhcp || bootp` ثم اتبع `xid` نفسه. Discover بلا Offer: افحص VLAN وrelay/service. Offer بلا Request: client policy/NIC أو offer غير مناسب. Request بلا ACK: server رفض/NAK أو path عائد. ACK صحيح مع failure لاحق: راجع options، duplicate detection، ACL، وDNS. احتفظ بالـ timestamp وMAC وVLAN وpacket sequence عند التصعيد، وأخفِ بيانات المؤسسة الحساسة.

## Escalation Notes | ملاحظات التصعيد

صعّد مع: scope name/subnet، affected VLAN/sites، client MAC/client ID، IP المعروض، server/relay IP، timestamps، DORA capture أو server logs، scope utilization، وchanges الأخيرة. لا تمسح leases أو تعطل DHCP Snooping كحل أول؛ قد تخفي السبب أو توسّع incident.
