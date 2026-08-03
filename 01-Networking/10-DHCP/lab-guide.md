# DHCP Lab Guide | دليل مختبر DHCP

## الهدف | Objective

بناء DHCP server مركزي لـ VLANs متعددة، تمرير requests عبر relay، اختبار reservation/exclusion، ثم حماية access VLAN باستخدام DHCP Snooping وتحليل DORA في Wireshark. نفّذ في Packet Tracer/CML/EVE-NG أو شبكة معزولة فقط.

## Topology and Addressing

| Node | Interface / VLAN | Address / role |
|---|---|---|
| R1/L3-SW | Vlan10 Users | `10.10.10.1/24`, relay |
| R1/L3-SW | Vlan20 Voice | `10.10.20.1/24`, relay |
| DHCP01 | Server VLAN | `10.10.100.20/24` |
| SW1 | Gi1/0/48 | trusted uplink to R1 |
| PC-Users | VLAN 10 | DHCP client |
| PC-Voice | VLAN 20 | DHCP client |

## Part 1: Configure Cisco IOS DHCP (local-server alternative)

استخدم هذا الجزء إن لم يتوفر Windows/Linux server. لا تشغّل local pool وcentral pool لنفس subnet في آن واحد.

```cisco
ip dhcp excluded-address 10.10.10.1 10.10.10.49
ip dhcp pool USERS-10
 network 10.10.10.0 255.255.255.0
 default-router 10.10.10.1
 dns-server 10.10.100.10
 domain-name corp.example
```

ضع PC في DHCP mode، ثم افحص `show ip dhcp binding` و`show ip dhcp pool`. سجّل IP وmask/gateway/DNS المستلمة.

## Part 2: Central DHCP and Relay

على DHCP01 أنشئ scopes: `10.10.10.50-10.10.10.220/24` و`10.10.20.50-10.10.20.220/24`، مع gateway `.1` وDNS مناسب. على L3 gateway:

```cisco
interface Vlan10
 ip address 10.10.10.1 255.255.255.0
 ip helper-address 10.10.100.20
interface Vlan20
 ip address 10.10.20.1 255.255.255.0
 ip helper-address 10.10.100.20
```

حرر/جدّد client lease. أثبت أن DHCP server يختار scope الصحيح عبر `giaddr`، ثم اختبر ping إلى gateway وDNS lookup إن توفر.

## Part 3: Exclusion and Reservation

1. استثنِ `.1-.49` في كل scope لأجهزة البنية التحتية.
2. أنشئ reservation لـ PC-Users بعنوان `10.10.10.60` باستخدام MAC/client identifier الفعلي.
3. حرر ثم جدّد lease وتحقق من بقاء العنوان نفسه.
4. لا تضبط جهاز static على عنوان dynamic لاختبار conflict؛ استخدم documentation فقط أو أعد الحالة فوراً.

## Part 4: Capture and Interpret DORA

ابدأ capture في Wireshark على client/relay path، ثم نفّذ renew. filter: `dhcp || bootp`. حدد Discover, Offer, Request, ACK، وسجّل `xid`, `yiaddr`, Option 3, Option 6, Option 54، و`giaddr`. أعد التجربة بعد تعطيل helper **في المختبر فقط** ولاحظ غياب Offer ثم أعده.

## Part 5: DHCP Snooping

```cisco
ip dhcp snooping
ip dhcp snooping vlan 10,20
interface GigabitEthernet1/0/48
 ip dhcp snooping trust
interface GigabitEthernet1/0/10
 ip dhcp snooping limit rate 15
```

تحقق من bindings. لا توصل rogue DHCP فعلياً؛ بدلاً من ذلك راجع أن access port غير trusted وأن uplink الشرعي فقط trusted. إن كان platform يدعم DAI/IP Source Guard، ادرس binding dependency قبل تفعيله.

## Success Criteria and Cleanup

- كل client يأخذ IP من scope الصحيح مع mask/gateway/DNS متوقعة.
- يظهر relay address في server logs/capture للـ remote VLANs.
- reservation ثابت وexcluded range لا يوزع dynamically.
- snooping enabled وtrusted ports محدودة ومُوثقة.
- أزل lab pools/scopes أو أوقفها، وأعد client إلى baseline بعد الاختبار.
