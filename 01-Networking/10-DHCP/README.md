# DHCP | التهيئة الديناميكية للمضيفين

> **Category:** 01-Networking / 10-DHCP
> **Level:** CCNA foundation → Enterprise operations
> **Language:** العربية مع English networking terminology

## نظرة عامة | Overview

**DHCP (Dynamic Host Configuration Protocol)** يوزع IPv4 configuration تلقائياً على clients: IP address وsubnet mask وdefault gateway وDNS servers وخيارات أخرى. يقلل أخطاء الإدخال اليدوي، لكنه يعتمد على scope صحيح وLayer 2/Layer 3 reachability وحماية من rogue DHCP servers.

يغطي هذا الدرس DHCPv4 عملياً: DORA، lease lifecycle، scopes، reservations، exclusions، relay/IP Helper، VLANs متعددة، Windows Server وCisco IOS وLinux وWireshark وDHCP Snooping.

## أهداف التعلم | Learning Objectives

- شرح DORA وسبب استخدام broadcast/unicast في كل مرحلة.
- قراءة DHCP packets والـ ports والـ options الأساسية.
- تصميم scope آمن لكل VLAN مع gateway وDNS وexclusions وreservations.
- تكوين والتحقق من DHCP على Cisco IOS وWindows Server وLinux.
- استخدام relay agent لإيصال clients في VLAN بعيدة إلى DHCP server.
- تحليل lease renewal/rebinding في Wireshark وتشخيص فشل الحصول على عنوان.
- حماية access switches عبر DHCP Snooping واكتشاف rogue DHCP.

## المفاهيم الأساسية | Core Concepts

| المصطلح | English term | المعنى التشغيلي |
|---|---|---|
| نطاق DHCP | Scope / Pool | مجموعة عناوين وإعدادات لشبكة واحدة؛ يجب أن تطابق subnet/VLAN. |
| عقد الإيجار | Lease | حق مؤقت للعميل في استخدام عنوان؛ ليس ملكية دائمة. |
| استثناء | Exclusion | عنوان داخل pool لا يوزعه DHCP، غالباً للبنية التحتية/static devices. |
| حجز | Reservation | عنوان ثابت للعميل نفسه عبر MAC/client identifier، ويظل مُداراً من DHCP. |
| وسيط DHCP | Relay agent / IP Helper | جهاز Layer 3 يمرر DHCP بين subnet العميل والخادم. |
| DHCP Snooping | Layer 2 security feature | يثق فقط بالمنافذ المؤدية للخادم/relay ويمنع offers غير الموثوقة. |

## DORA Process | عملية DORA

عند عدم امتلاك client عنواناً صالحاً، يرسل DHCPv4 الرسائل التالية (UDP client `68`، server `67`):

1. **Discover:** client يبث من `0.0.0.0` إلى `255.255.255.255` بحثاً عن servers.
2. **Offer:** server يعرض عنواناً ومدة lease وoptions؛ قد يكون broadcast حسب flags وحالة client.
3. **Request:** client يطلب العرض المختار، غالباً broadcast ليعلم servers الأخرى أنه لم يختر عروضها.
4. **ACK:** server يؤكد الإيجار والإعدادات؛ عند الرفض يرسل **NAK** ويبدأ client من جديد.

> DHCP broadcast لا يعبر router تلقائياً. في VLAN أخرى، relay يضع عنوان interface في `giaddr` ويرسل الطلب إلى DHCP server unicast.

## DHCP Packets and Options | الحزم والخيارات

DHCPv4 مبني على BOOTP. الحقول المهمة: `xid` لربط الرسائل، `chaddr` للـ MAC، `ciaddr` للعميل المجدد، `yiaddr` للعنوان المعروض، و`giaddr` لعنوان relay. لا تعتمد على MAC فقط في كل منصة؛ قد يستخدم client identifier.

| Option | الاسم | الاستخدام |
|---:|---|---|
| 1 | Subnet Mask | mask الخاص بالـ scope. |
| 3 | Router | default gateway؛ يمكن أكثر من عنوان. |
| 6 | DNS Servers | خوادم DNS للعميل. |
| 15 | Domain Name | DNS suffix مثل `corp.example`. |
| 42 | NTP Servers | مزامنة الوقت. |
| 51 | IP Address Lease Time | مدة الإيجار بالثواني. |
| 53 | DHCP Message Type | Discover/Offer/Request/ACK/NAK وغيرها. |
| 54 | Server Identifier | يحدد server الذي اختاره client. |
| 66/67 | TFTP/Bootfile | PXE/boot provisioning؛ استخدمها فقط وفق سياسة معتمدة. |
| 82 | Relay Agent Information | معلومات circuit/remote ID من relay أو switch snooping. |

## Lease Lifecycle | دورة حياة الإيجار

بعد ACK، يحفظ العميل configuration حتى انتهاء lease. عند **T1** (عادة 50%) يحاول renewal unicast إلى server الأصلي. عند **T2** (عادة 87.5%) يدخل rebinding ويرسل broadcast إلى أي DHCP server متاح. إن انتهت المدة بلا ACK يجب أن يتوقف عن استخدام العنوان ويبدأ DORA. في Windows قد يظهر APIPA من `169.254.0.0/16` عندما يفشل DHCP؛ هو دليل failure محلي وليس حلاً لشبكة enterprise.

## Scopes: Reservation and Exclusion

أنشئ scope واحداً لكل IPv4 subnet/VLAN. مثال VLAN 20: `10.20.20.0/24`، gateway `.1`، exclusion `.1-.49` للأجهزة الثابتة، dynamic pool `.50-.220`، وreserve `.221-.254` للنمو أو design محدد. لا تضع reservation في exclusion بلا فهم لسلوك المنصة؛ في Windows reservation يجب أن يقع ضمن scope لكنه يمكن أن يقع في excluded range عند تصميم مدروس. وثّق MAC/client ID والمالك والسبب.

## Multiple VLANs and Relay Agent

في campus نموذجي، DHCP server مركزي في VLAN/Server subnet، وSVI أو router interface هو default gateway لكل VLAN. ضع `ip helper-address <server>` على كل SVI يحتاج clients DHCP. يُنشئ relay unicast إلى server ويستخدم `giaddr` ليختار server scope الصحيح. لا تضع helper على access port؛ مكانه L3 gateway. راجع ACL/VRF/routing والعودة إلى relay.

| VLAN | Subnet | Gateway | DHCP scope | Relay on |
|---:|---|---|---|---|
| 10 Users | `10.10.10.0/24` | `10.10.10.1` | `USERS-10` | `Vlan10` |
| 20 Voice | `10.10.20.0/24` | `10.10.20.1` | `VOICE-20` | `Vlan20` |
| 30 Guest | `10.10.30.0/24` | `10.10.30.1` | `GUEST-30` | `Vlan30` |

## Platform Overview | منصات التشغيل

- **Windows Server DHCP:** ثبّت role، authorize في Active Directory، أنشئ IPv4 scope/options، وفعّل scope بعد الاختبار. استخدم failover عند الحاجة.
- **Cisco IOS DHCP:** مناسب للـ branch/lab أو deployments صغيرة؛ أنشئ excluded addresses و`ip dhcp pool`، واستعمل `ip helper-address` للـ remote server.
- **Linux (Kea/ISC DHCP):** استخدم خدمة مدارة وملف configuration تحت version control، وافحص syntax قبل restart. Kea هو خيار حديث شائع؛ قد تستخدم بيئات legacy ISC DHCP.

## Security: DHCP Snooping and Rogue DHCP

Rogue DHCP server يمكنه إعطاء gateway أو DNS خبيثين ويسبب outage أو interception. فعّل DHCP Snooping في access VLANs، علّم uplinks إلى DHCP server/relay فقط بأنها **trusted**، واترك user ports untrusted ومحدودة rate. يبني السويتش binding database (MAC, IP, VLAN, port, lease) يمكن استخدامه مع Dynamic ARP Inspection وIP Source Guard عند توافق التصميم. اختبر قبل التفعيل: trust خاطئ أو rate limit منخفض قد يقطع DHCP الشرعي.

## Enterprise Best Practices | أفضل الممارسات

1. اجعل scope/subnet/VLAN/default gateway متطابقة، ووثّق owner وpurpose وDNS/options.
2. استثنِ عناوين البنية التحتية أو استخدم reservations؛ لا تخلط static addresses عشوائياً مع dynamic range.
3. راقب utilization والـ declined/conflict leases قبل أن يصل pool إلى الامتلاء.
4. استخدم DHCP failover أو redundancy مصممة واختبر failure/restore، مع NTP وbackups وchange control.
5. فعّل DHCP Snooping وtrust أقل عدد من المنافذ، وراقب Option 82 وفق توافق server.
6. لا تستخدم `debug ip dhcp server events` في production بلا نافذة صيانة ومراقبة CPU/logging.

## Common Mistakes | أخطاء شائعة

- Scope mask أو Option 3 لا يطابق subnet العميل.
- نسيان `ip helper-address` في VLAN بعيدة، أو وضعه على interface خاطئ.
- استنفاد العناوين أو overlap بين dynamic range وstatic devices.
- عدم authorization لخادم Windows في AD، أو scope غير مُفعّل.
- marking access port as snooping trusted أو نسيان trust للـ uplink الشرعي.
- اعتبار نجاح ping إلى gateway دليلاً على صحة DNS، lease options، أو التطبيق.

## CCNA Notes | ملاحظات CCNA

- DHCPv4 يستخدم UDP `67` على server وUDP `68` على client.
- ترتيب DORA: Discover, Offer, Request, ACK؛ **NAK** يعيد العميل إلى البداية.
- relay يستخدم `giaddr` لاختيار scope؛ DHCP broadcast لا يمر عبر router بدون relay.
- `ip helper-address` قد يمرر UDP services أخرى افتراضياً في IOS؛ راجع سياسة المنصة عند hardening.
- DHCP Snooping: server-facing/uplink ports trusted، وaccess ports untrusted افتراضياً.

## روابط الوحدة | Module Links

- [Cheatsheet | الملخص](cheatsheet.md)
- [Commands | الأوامر](commands.md)
- [Notes | الملاحظات](notes.md)
- [Lab Guide | المختبر](lab-guide.md)
- [Troubleshooting | التشخيص](troubleshooting.md)
- [Quiz | الاختبار](quiz.md)
- [Mermaid Diagrams | المخططات](mermaid-diagram.md)
- [Labs | ملفات المختبر](labs/README.md)
- [References | المراجع](references/README.md)
