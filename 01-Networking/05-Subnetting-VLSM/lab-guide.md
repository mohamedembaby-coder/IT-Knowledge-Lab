# Subnetting & VLSM Lab Guide | دليل المختبر

## الهدف | Objective

تصميم address plan لمؤسسة متعددة الأقسام، حساب subnets يدوياً، ثم تطبيقها على Cisco IOS والتحقق من Windows client. استخدم Packet Tracer أو CML/EVE-NG أو أجهزة معزولة فقط.

## Scenario and Requirements

لدى مؤسسة block `10.50.0.0/23` وتحتاج:

| Segment | Required hosts | Design intent |
|---|---:|---|
| Data Center | 200 | Server VLAN |
| Corporate Users | 120 | User access |
| Voice | 60 | IP phones |
| Management | 25 | Network management |
| WAN transit A/B | 2 each | Point-to-point |

## Part 1: Calculate VLSM

رتّب requirements تنازلياً، واحسب أصغر prefix يحقق hosts، ثم خصص subnets aligned:

| Segment | Subnet | Mask | Network | Gateway | Broadcast |
|---|---|---|---|---|---|
| Data Center | `/24` | `255.255.255.0` | `10.50.0.0` | `.1` | `.255` |
| Corporate Users | `/25` | `255.255.255.128` | `10.50.1.0` | `.1` | `.127` |
| Voice | `/26` | `255.255.255.192` | `10.50.1.128` | `.129` | `.191` |
| Management | `/27` | `255.255.255.224` | `10.50.1.192` | `.193` | `.223` |
| Transit A | `/30` | `255.255.255.252` | `10.50.1.224` | `.225/.226` | `.227` |
| Transit B | `/30` | `255.255.255.252` | `10.50.1.228` | `.229/.230` | `.231` |

## Part 2: Configure Cisco IOS

```cisco
interface GigabitEthernet0/1
 description CORPORATE-USERS
 ip address 10.50.1.1 255.255.255.128
 no shutdown
interface GigabitEthernet0/2
 description MANAGEMENT
 ip address 10.50.1.193 255.255.255.224
 no shutdown
ip dhcp excluded-address 10.50.1.1 10.50.1.20
ip dhcp pool CORPORATE-USERS
 network 10.50.1.0 255.255.255.128
 default-router 10.50.1.1
```

## Part 3: Verify

```cisco
show ip interface brief
show ip route connected
show ip dhcp binding
show arp
```

```powershell
Get-NetIPConfiguration
ipconfig /all
ping 10.50.1.1
Test-NetConnection 10.50.1.1
```

تحقق أن client داخل `.1–.126`، وأن gateway `.1` وmask `/25`، وأن broadcast `.127` غير مخصص.

## Part 4: Summarization Exercise

افحص إمكانية تلخيص Data Center وCorporate وVoice. ناقش هل `10.50.0.0/23` واسع أكثر من اللازم، وما أثر summary على reserve وblack holes قبل تطبيقه.

## Success Criteria and Cleanup

- لا يوجد overlap وكل requirement لديه usable hosts كافٍ.
- Cisco interfaces up/up وconnected routes صحيحة.
- Windows client يصل إلى gateway ويحصل على mask صحيح.
- DHCP لا يوزع gateway أو broadcast أو infrastructure addresses.
- احذف lab pools والعناوين أو أعد startup-config المحفوظة.
