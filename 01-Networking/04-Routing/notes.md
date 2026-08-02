# Routing Notes | ملاحظات التوجيه

## Data Plane وControl Plane

- **Control plane** يتعلم أو يثبت routes عبر static configuration أو routing protocols.
- **Data plane** يمرر packets باستخدام FIB/CEF بعد اختيار route.
- مشكلة adjacency أو route advertisement هي control-plane symptom؛ مشكلة ARP, MTU, ACL, NAT, أو return path قد تمنع traffic رغم أن route موجود.

## Longest Prefix Match

لا تختار الأجهزة "أقرب" route بناءً على شكل topology؛ تقارن destination بالـ masks. لـ `192.168.10.50`، route `192.168.10.0/24` أكثر تحديداً من `192.168.0.0/16`، ولذلك يُستخدم أولاً. بعد اختيار prefix فقط تتم مقارنة AD ثم metric بين routes لنفس prefix length.

## Administrative Distance مقابل Metric

AD يقارن **مصادر مختلفة** للـ route: static مقابل OSPF مثلاً. Metric يقارن جودة paths داخل protocol نفسه: OSPF cost أو RIP hop count. لا تقل إن OSPF "أفضل" من static لأن cost أقل؛ static AD الافتراضي 1 ولذلك يتقدم عند prefix متساوٍ.

## Summarization وBlack Holes

الملخص يقلل حجم جدول التوجيه ويعزل instability، لكنه قد يغطي subnet غير موجودة. استخدم `Null0` summary route عند الحاجة وفق تصميم البروتوكول لمنع loop، وراقب counters حتى لا يصبح legitimate traffic black-holed. لا تعلن summary دون التأكد من routes components والعودة.

## Default Route

`0.0.0.0/0` و`::/0` هما routes of last resort. في branch، default route إلى HQ/firewall منطقي غالباً. في core، default route واسع قد يخفي نقصاً في internal route؛ راجع scope قبل إضافته.

## ECMP

ECMP يوفر availability واستغلالاً أفضل للوصلات المتساوية. يعتمد التوزيع على hash fields مثل source/destination IP وports حسب platform. لهذا قد تستخدم جلسة واحدة path واحداً؛ اختبر عدة flows ولا تحكم من `ping` واحد.

## Protocol Notes | ملاحظات البروتوكولات

- **RIP v2:** بسيط لكنه hop-count محدود، أوقف auto-summary في تصميمات discontiguous عند الحاجة.
- **OSPF:** تحقق من area, network type, hello/dead timers, authentication, MTU, router ID، وpassive-interface عند فشل neighbor.
- **EIGRP:** adjacency وfeasible successor ترتبط بالـ DUAL؛ لا تعيد توزيع routes بلا tags وسياسة منع loops.
- **BGP:** session up لا يعني وصول كل prefixes؛ افحص policies, attributes, next-hop reachability, and advertised/received routes.

## Best Practices | أفضل الممارسات

1. صمم IP plan قابلاً للتلخيص عند boundaries واضحة.
2. اجعل IGP داخل المؤسسة وBGP عند edge/policy boundaries ما لم يبرر التصميم غير ذلك.
3. استخدم authentication وrouting protocol filtering حيث يلزم، مع logging وNTP وconfiguration backups.
4. اختبر failure وعودة المسار (failover/failback) في maintenance window، وليس route installation فقط.
5. راقب route count, adjacency state, convergence time, packet loss، وCPU/memory.
