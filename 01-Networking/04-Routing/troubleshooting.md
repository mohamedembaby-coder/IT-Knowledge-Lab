# Routing Troubleshooting | استكشاف أخطاء التوجيه

## Evidence-First Workflow | منهجية مبنية على الدليل

1. حدّد source, destination, protocol/port, وقت المشكلة، وتأثيرها.
2. تحقق من IP address, mask, default gateway, VLAN, interface state، وARP/ND محلياً.
3. نفّذ route lookup للـ exact destination على كل hop، ثم افحص next hop وreturn path.
4. تحقق من ACL/firewall/NAT/VRF وMTU بعد إثبات اختيار route.
5. افحص protocol neighbor, logs, timers, and policy إن كان المسار dynamic.
6. وثّق evidence قبل التغيير، نفّذ تغييراً واحداً، ثم تحقق وراقب rollback condition.

## Enterprise Scenarios

| Symptom | Likely cause | Evidence | Resolution |
|---|---|---|---|
| Branch cannot reach HQ; local gateway responds | Missing route أو return route | `show ip route DEST` على R1/R2، `traceroute` | أضف/أعلن route الصحيح في الاتجاهين؛ لا تعتمد على ping من router فقط. |
| Internet works but private app fails | Default route موجود، specific internal route مفقود/ملخص خاطئ | Lookup للـ app IP؛ compare prefix/next hop | صحح specific route أو summary، وراجع overlap. |
| Backup WAN never takes traffic | Floating static AD أقل/مساوٍ أو primary static لم يُزل | `show ip route PREFIX` قبل وبعد failure | اضبط backup AD أعلى، واستخدم tracking لقياس end-to-end health. |
| OSPF neighbor stuck in EXSTART/EXCHANGE | MTU mismatch، duplicate router ID، أو network type/timers | `show ip ospf neighbor`, interface/log data | طابق MTU/timers/type، وصحح router ID ضمن maintenance window. |
| OSPF neighbor absent | passive-interface، area/auth mismatch، L3 connectivity | `show ip ospf interface brief`, config | صحح adjacency prerequisites، ثم تحقق من `FULL`. |
| BGP Established but prefix absent | inbound/outbound policy أو next hop unreachable | `show ip bgp`, policy and route lookup | راجع prefix filters/route maps والـ next hop؛ لا تزيل filters عشوائياً. |
| Some flows slow across dual links | ECMP hash imbalance أو asymmetric path | CEF/flow telemetry، per-flow tests | تحقق من hashing وcapacity وreturn path؛ لا تتوقع equal packets لكل link. |
| Route exists, application still fails | ACL, firewall, NAT, DNS, port, MTU | `show ip cef`, flow logs, `Test-NetConnection -Port` | عالج طبقة الخدمة/السياسة بعد إثبات L3 reachability. |

## Focused Cisco IOS Checks

```cisco
show ip interface brief
show interfaces GigabitEthernet0/0
show ip route 10.20.30.10
show ip cef 10.20.30.10 detail
show ip arp
show ip protocols
show ip ospf neighbor
show ip eigrp neighbors
show ip bgp summary
show logging | last 50
```

## Focused Windows Checks

```powershell
Get-NetIPConfiguration
Get-NetRoute -DestinationPrefix '10.20.30.0/24'
route print -4
Test-NetConnection 10.20.30.10 -TraceRoute
Test-NetConnection app.corp.example -Port 443
Get-NetFirewallProfile
```

## Escalation Notes | ملاحظات التصعيد

صعّد إلى WAN/ISP أو Security team مع timestamp، source/destination، traceroute من الجهتين، interface counters، route lookup output، affected prefixes، وchange correlation. أخفِ public IPs وcredentials وcustomer data من tickets أو shared logs.
