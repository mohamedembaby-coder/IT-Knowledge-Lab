# DNS | نظام أسماء النطاقات

> **Category:** 01-Networking / 11-DNS
> **Level:** CCNA foundation → Enterprise operations
> **Language:** العربية مع English networking terminology

## نظرة عامة | Overview

**DNS (Domain Name System)** يحوّل الأسماء المفهومة للبشر مثل `app.corp.example` إلى بيانات قابلة للاستخدام، أهمها IP addresses. لكنه ليس مجرد “phone book”: هو نظام موزّع هرمي، يعتمد على delegation وcaching وTTL، ويؤثر مباشرة في Active Directory، البريد، cloud services، التطبيقات، وعمليات troubleshooting.

يغطي الدرس DNS forwarding وreverse lookup، recursive وiterative queries، authoritative وrecursive servers، zones وrecords، Windows Server DNS وBIND 9 وCisco IOS، Wireshark، والتصميم الآمن للمؤسسات.

## أهداف التعلم | Learning Objectives

- تفسير رحلة query من client إلى recursive resolver ثم root/TLD/authoritative hierarchy.
- التمييز بين recursive وiterative query وبين authoritative وrecursive server.
- اختيار واختبار A, AAAA, CNAME, MX, PTR, NS, TXT, وSRV records.
- تصميم forward وreverse zones وTTL وsplit DNS وconditional forwarders.
- تكوين والتحقق من DNS client settings على Cisco IOS وWindows وLinux/BIND 9.
- استخدام `Resolve-DnsName`, `nslookup`, `dig` وWireshark لتشخيص failures بالدليل.
- تطبيق best practices: redundancy, secure dynamic updates, least privilege, logging, DNSSEC policy، ومنع open recursion.

## مفاهيم أساسية | Core Concepts

| المصطلح | English term | المعنى التشغيلي |
|---|---|---|
| محلّل Stub | Stub resolver | جزء client/OS الذي يرسل query إلى DNS server مكوّن. |
| محلّل Recursive | Recursive resolver | يبحث نيابةً عن العميل أو يستخدم forwarder ويخزن النتائج في cache. |
| خادم Authoritative | Authoritative server | يجيب من zone يملكها، مع authoritative answer (AA). |
| Zone | DNS zone | جزء إداري من namespace يحوي records؛ ليس دائماً كل domain. |
| Delegation | تفويض | NS records تشير إلى authoritative servers للـ child zone. |
| Cache | ذاكرة مؤقتة | نتائج محفوظة حتى TTL لتقليل latency والتحميل. |
| TTL | Time To Live | مدة صلاحية record في cache بالثواني؛ ليس “وقت استجابة DNS”. |
| Forwarder | مُمرّر استعلامات | resolver خارجي/داخلي يستقبل unresolved queries من DNS server. |

## DNS Hierarchy | هرم DNS

DNS namespace عالمي ومنظم من الأعلى للأسفل:

1. **Root (`.`):** لا يعرف جواب كل name؛ يوجّه إلى TLD name servers.
2. **TLD:** مثل `.com` أو `.org` أو country-code TLD؛ يقدّم delegation للـ domain.
3. **Authoritative zone:** مثل `example.com`؛ يقدّم records النهائية أو delegation أدق.
4. **Enterprise zones:** مثل `corp.example`، وقد تكون internal فقط أو split-horizon.

لا يتصل client عادةً بالـ root مباشرة. يرسل stub resolver query إلى DNS server الداخلي؛ recursive resolver يجيب من cache أو يتابع referrals/forwarders. يجب أن تكون شبكة المؤسسة قادرة على الوصول إلى resolvers المعتمدة فقط، لا إلى Internet DNS عشوائي.

## Recursive vs. Iterative | الاستعلام المتكرر مقابل التكراري

| Type | من يواصل البحث؟ | Typical use | Reply |
|---|---|---|---|
| Recursive query | DNS server الذي سُئل | client → enterprise resolver | answer نهائي أو failure مثل `SERVFAIL`/`NXDOMAIN`. |
| Iterative query | السائل يتبع referrals | recursive resolver → hierarchy | referral إلى server أقرب للجواب أو answer authoritative. |

**Authoritative** و**recursive** تصفان role/capability، وليستا نوعَي records. يمكن لخادم داخلي أن يكون authoritative لـ `corp.example` وrecursive لعملائه الموثوقين، لكن يجب منع recursion من untrusted networks لتفادي open-resolver abuse.

## DNS Records | السجلات الأساسية

| Record | Purpose | Example / caution |
|---|---|---|
| `A` | IPv4 address | `web.corp.example → 10.10.20.50` |
| `AAAA` | IPv6 address | لا تفترض أن نجاح A يعني نجاح IPv6. |
| `CNAME` | alias إلى canonical name | لا يُستخدم عند zone apex ولا مع records أخرى بالاسم نفسه. |
| `MX` | mail exchanger | يشير إلى hostname، لا IP؛ الأقل preference أفضل. |
| `PTR` | reverse name mapping | `50.20.10.10.in-addr.arpa → web.corp.example`. |
| `NS` | authoritative name server/delegation | يحتاج glue A/AAAA عندما يلزم. |
| `TXT` | نص policy/verification | SPF/DKIM/DMARC/ownership؛ انتبه لحدود ونمط record. |
| `SRV` | service discovery | AD وSIP وغيرها؛ priority, weight, port, target. |
| `SOA` | zone authority/control | primary server, serial, refresh/retry/expire, negative TTL. |

## Forward, Reverse, and Caching

**Forward lookup** يسأل عن name إلى address/metadata. **Reverse lookup** يسأل PTR من IP إلى name تحت `in-addr.arpa` في IPv4 أو `ip6.arpa` في IPv6. PTR مفيد للسجلات، mail validation، والتحقيقات، لكنه لا يثبت ملكية جهاز ولا يجب أن يكون وسيلة access control وحيدة.

TTL هو عقد cache: رفعه يقلل traffic لكنه يؤخر انتشار التغيير؛ خفضه قبل migration يسمح cutover أسرع لكنه يرفع query rate. اخفض TTL قبل تغيير مخطط له، انتظر TTL القديم حتى يختفي من caches، نفّذ change، ثم أعد قيمة مناسبة. لا تفترض أن كل resolver يطابق TTL بدقة أو أن flush عالمي ممكن.

## Enterprise DNS Design | تصميم Enterprise

| Requirement | Design choice |
|---|---|
| Internal names تختلف عن public answers | **Split DNS**: internal/external views أو zones منفصلة مع governance واضح. |
| Route a partner/private zone to a specific resolver | **Conditional forwarder** مثل `partner.example` إلى DNS partner. |
| Resilience | على الأقل resolvers مستقلان، zones replicated/secondary أو AD-integrated، ومراقبة availability. |
| Active Directory | AD-integrated zones وsecure dynamic updates؛ راقب SRV records والـ replication. |
| Internet resolution | forwarders موثوقة أو root hints حسب policy؛ egress/firewall واضح لـ UDP/TCP 53. |
| Security | recursion internal-only، restricted zone transfer، least privilege، logging، patching، DNSSEC validation/signing وفق design. |

**Split DNS** لا يعني إنشاء نفس record بلا توثيق. وثّق source of truth، مالك كل view، names التي تتباين، وخطة اختبار من internal وexternal vantage points. **Conditional forwarder** أدق من general forwarder: يطابق suffix محدداً؛ افحص availability وtimeout وسلاسل fallback.

## DNS Transport and Response Codes

DNS يستخدم غالباً UDP `53` للqueries/responses الصغيرة، وTCP `53` للـ zone transfers وكثير من الردود الكبيرة أو عند truncation (`TC=1`). لا تحجب TCP/53 ثم تفترض أن DNS “يعمل” لأن A lookup بسيط نجح. قد ترى أيضاً DNS over TLS/HTTPS وفق enterprise policy، لكن لا تخلطه مع classic DNS في troubleshooting.

| Code | Meaning | Operational interpretation |
|---|---|---|
| `NOERROR` | query processed; answer قد يكون empty | تحقق من answer/authority section، لا تعتمد على code فقط. |
| `NXDOMAIN` | name لا وجود له | غالباً typo أو record/zone غائب؛ قد يكون cached negatively. |
| `SERVFAIL` | server فشل في معالجة query | upstream, DNSSEC, delegation, zone loading، أو server health. |
| `REFUSED` | server يرفض policy | recursion/ACL/view/authorization policy. |
| timeout | لا reply | path, firewall, server listener/load، أو wrong DNS IP. |

## CCNA Notes | ملاحظات CCNA

- DNS is application-layer name resolution; it normally uses port `53` over UDP and TCP.
- Recursive resolver يعمل نيابةً عن client؛ iterative referrals يستخدمها resolver خلال hierarchy.
- Authoritative server يملك zone data؛ cache لا يجعل الخادم authoritative.
- `A=IPv4`, `AAAA=IPv6`, `PTR=reverse`, `MX=mail`, `CNAME=alias`, `NS=delegation`.
- `ip name-server` و`ip domain lookup` يضبطان Cisco IOS كـ DNS **client**؛ لا يعنيان أن router أصبح recursive DNS server.
- TTL يحدد cache lifetime، و`NXDOMAIN` يمكن أن يُخزّن (negative caching) وفق SOA policy.

## Module Links | روابط الوحدة

- [Cheatsheet | الملخص](cheatsheet.md)
- [Commands | الأوامر](commands.md)
- [Notes | الملاحظات](notes.md)
- [Lab Guide | المختبر](lab-guide.md)
- [Troubleshooting | التشخيص](troubleshooting.md)
- [Quiz | الاختبار](quiz.md)
- [Mermaid Diagrams | المخططات](mermaid-diagram.md)
- [Labs | ملفات المختبر](labs/README.md)
- [References | المراجع](references/README.md)
- [Resources | موارد التشغيل](resources/README.md)
- [Scripts | أدوات جمع الدليل](scripts/README.md)
