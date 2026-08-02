# Routing | التوجيه

> Category: 01-Networking / 04-Routing

## نظرة عامة | Overview

**Routing** هو قرار Layer 3 الذي يحدد الـ next hop المناسب لإيصال IP packet إلى شبكة بعيدة. يستخدم الـ router جدول التوجيه (Routing Information Base / RIB) لاختيار المسار، ثم يرسل الحزمة إلى الـ next hop بعد إنشاء Layer 2 frame جديد لكل hop.

This module is aligned to CCNA foundations and CCNP enterprise operations: static and dynamic routing, route selection, resiliency, summarization, and evidence-based troubleshooting.

## أهداف التعلم | Learning Objectives

- قراءة وتفسير Cisco IOS routing table وWindows routing table.
- تكوين والتحقق من static, default, floating static, and summary routes.
- شرح Longest Prefix Match وAdministrative Distance (AD) وmetric.
- تمييز استخدامات RIP, OSPF, EIGRP, and BGP في بيئة Enterprise.
- تشخيص انقطاع الاتصال بين المواقع مع المحافظة على control-plane وdata-plane evidence.

## مفاهيم أساسية | Core Concepts

| المصطلح | English term | المعنى التشغيلي |
|---|---|---|
| جدول التوجيه | Routing table / RIB | قائمة الشبكات والمسارات المرشحة في جهاز Layer 3. |
| اختيار المسار | Longest Prefix Match | أكثر prefix تحديداً يفوز أولاً؛ `/24` يفوز على `/16` لنفس الوجهة. |
| المسافة الإدارية | Administrative Distance | موثوقية مصدر route؛ القيمة الأقل أفضل. |
| المقياس | Metric | تكلفة داخل routing protocol؛ لا يقارن عادةً بين مصادر مختلفة قبل AD. |
| القفزة التالية | Next hop | عنوان router التالي أو exit interface الذي سترسل إليه الحزمة. |
| المسار الافتراضي | Default route | route أخير مثل `0.0.0.0/0` عند عدم وجود route أكثر تحديداً. |

## ترتيب اختيار المسار | Route Selection Order

عند وصول packet، يطبق الجهاز التسلسل التالي:

1. يطابق destination IP مع كل prefixes متاحة ويختار **Longest Prefix Match**.
2. إن وُجدت routes متساوية في prefix، يفضّل **أقل Administrative Distance**.
3. إن كانت AD متساوية ومن المصدر نفسه غالباً، يفضّل **أقل metric**.
4. يمكن تثبيت مسارات متساوية الكلفة باعتبارها **ECMP** (Equal-Cost Multi-Path) وفق منصة وسياسة الجهاز.

> لا يفوز default route على route أكثر تحديداً مهما كانت AD الخاصة به؛ prefix length يُقيَّم أولاً.

## Administrative Distance الشائعة

| Route source | Default AD في Cisco IOS | ملاحظة |
|---|---:|---|
| Connected | 0 | شبكة interface up/up ومُعنونة. |
| Static | 1 | يمكن تعديلها لإنشاء floating static route. |
| eBGP | 20 | بين Autonomous Systems. |
| EIGRP internal | 90 | Cisco IGP متقدم. |
| OSPF | 110 | Link-state IGP شائع للمؤسسات. |
| IS-IS | 115 | IGP شائع لدى providers وبعض المؤسسات. |
| RIP | 120 | Distance-vector؛ محدود للبيئات الحديثة. |
| EIGRP external | 170 | Routes أُعيد توزيعها إلى EIGRP. |
| iBGP | 200 | داخل نفس AS. |
| Unknown | 255 | لا يُثبت route. |

## Static Routing | التوجيه الثابت

Static route مناسب للشبكات الصغيرة، stub networks، المسارات المحددة، وout-of-band management. هو بسيط ومتوقع، لكنه لا يتكيف تلقائياً مع تغيّر topology ما لم تضف tracking أو مسار احتياطي.

```cisco
! Route إلى فرع Branch-LAN عبر next hop
ip route 10.20.30.0 255.255.255.0 192.0.2.2

! IPv6 static route
ipv6 route 2001:db8:30::/64 2001:db8:12::2
```

استخدم next-hop IP أو exit interface في point-to-point link؛ في Ethernet multi-access يُفضّل next-hop IP لتجنب recursive/ARP ambiguity. في IPv6 link-local next hop يجب تحديد exit interface أيضاً.

## Default and Floating Static Routes

Default route يوجّه unknown destinations إلى upstream firewall, ISP, أو hub. Floating static route هو backup static route بقيمة AD أعلى من المسار الأساسي أو الـ dynamic route.

```cisco
! Primary default route
ip route 0.0.0.0 0.0.0.0 192.0.2.1
! Backup LTE/secondary WAN: higher AD, installed only if primary disappears
ip route 0.0.0.0 0.0.0.0 198.51.100.1 200
```

في production، ربط static route فقط بحالة interface قد لا يكشف فشل upstream. استخدم IP SLA + object tracking حيث تسمح سياسة المؤسسة بذلك.

## Dynamic Routing Overview | نظرة على التوجيه الديناميكي

| Protocol | النوع | مجال الاستخدام | CCNA/CCNP ملاحظة |
|---|---|---|---|
| RIP v2 | Distance-vector | legacy أو labs صغيرة | metric = hop count، حد أقصى 15 hops. |
| OSPF | Link-state | Enterprise campus/WAN | areas, LSDB, SPF، scalable design. |
| EIGRP | Advanced distance-vector | Cisco-centric Enterprise | DUAL، feasible successor، rapid convergence. |
| BGP | Path-vector | ISP، cloud edge، multi-homing | policy-based؛ ليس IGP داخلياً عادياً. |

**OSPF** هو الاختيار الشائع كـ IGP في Enterprise متعددة المواقع. **BGP** مناسب عندما تصبح سياسة المسار، AS boundaries، أو اتصال مزودين/Cloud أهم من أسرع IGP convergence. لا تشغّل بروتوكولاً لأنّه متاح فقط؛ اختره وفق حجم الشبكة، ownership، policy، وoperational maturity.

## Route Summarization | تلخيص المسارات

Route summarization يعلن prefix أكبر يمثل عدة شبكات متجاورة، فيقلل حجم routing table وupdates ويحدّ من أثر flapping. يجب أن تكون الشبكات contiguous وأن يُراجع أثر black hole بعناية.

مثال: `10.20.0.0/24` إلى `10.20.3.0/24` يمكن تلخيصها إلى `10.20.0.0/22`. إذا لم تكن كل الشبكات ضمن الملخص قابلة للوصول من نفس الاتجاه، قد تُرسل traffic إلى black hole.

## ECMP | المسارات متساوية الكلفة

ECMP يثبت عدة paths متساوية التكلفة للوجهة نفسها لزيادة المرونة والاستفادة من السعة. غالباً يوزع Cisco IOS traffic باستخدام per-destination hashing للحفاظ على ترتيب flows؛ لا تفترض توزيعاً packet-by-packet. تحقق من CEF، عدد maximum paths، وتصميم symmetry قبل التشغيل.

## مثال Enterprise | Enterprise Example

شركة لديها HQ وBranch متصلان عبر MPLS كمسار أساسي وInternet VPN كاحتياطي. يعلن OSPF شبكات المواقع، وتوجد floating static route نحو VPN بـ AD `200`. يوجه HQ default route إلى firewall، بينما BGP على edge فقط يتعامل مع مزودَي Internet. هذا الفصل بين IGP الداخلي وedge policy يجعل التشغيل والتشخيص أوضح.

## روابط الوحدة | Module Links

- [Cheatsheet | الملخص](cheatsheet.md)
- [Commands | الأوامر](commands.md)
- [Notes | الملاحظات](notes.md)
- [Lab Guide | المختبر](lab-guide.md)
- [Troubleshooting | التشخيص](troubleshooting.md)
- [Mermaid Diagrams | المخططات](mermaid-diagram.md)
