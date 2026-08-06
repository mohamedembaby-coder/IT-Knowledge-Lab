# DNS Notes | ملاحظات DNS

## Zone vs Domain

Domain هو جزء من DNS namespace، بينما zone هي الوحدة الإدارية التي يجيب عنها authoritative server. يمكن أن يكون `example.com` zone واحداً، أو يـُفوَّض `dev.example.com` إلى zone منفصل. عند troubleshooting delegation لا تكتفِ بوجود A record: افحص NS delegation وglue وauthority chain.

## Answer Types and Cache

- **Authoritative answer:** server أجاب من zone primary/secondary/AD-integrated التي يستضيفها.
- **Non-authoritative answer:** recursive resolver أجاب من cache أو من نتيجة recursive resolution.
- **Positive caching:** يحفظ record حتى TTL.
- **Negative caching:** يحفظ `NXDOMAIN` أو no-data طبقاً لـ SOA negative TTL؛ لذلك قد يستمر failure بعد إضافة record مباشرة.

لا تجعل flush cache أول تشخيص. سجّل query name/type، DNS server، response code، TTL، ووقت التغيير أولاً؛ flush قد يمحو دليلاً ويزيد load.

## CNAME Rules That Prevent Incidents

CNAME هو alias كامل للاسم canonical. لا يجوز للاسم نفسه أن يحمل CNAME وA/MX/TXT/SRV records أخرى في zone data. MX وSRV targets يجب أن تكون hostnames قابلة للحل، لا CNAME/IP حيث لا تسمح policy/standards أو التطبيق. تجنب CNAME chains الطويلة؛ تزيد latency وتخفي ownership.

## Forwarders, Root Hints, and Conditional Forwarders

General forwarder يرسل queries التي لا يملك server authority لها إلى resolver محدد؛ هو مفيد لمركزية egress/filtering. root hints تسمح للresolver ببدء iterative lookup من root servers. Conditional forwarder يختار resolver بحسب suffix (`branch.corp.example` أو `partner.example`) ويجب أن يكون أكثر تحديداً من أي general forwarding policy. اكتب ownership وfallback وtimeout لكل conditional forwarder.

## Active Directory DNS

AD يعتمد على DNS، خصوصاً SRV records تحت `_ldap._tcp`, `_kerberos._tcp` وغيرها. client يستطيع resolve اسم DC عادي لكن يفشل domain join/logon إذا كانت SRV records أو site/subnet mapping أو AD replication خاطئة. استخدم AD-integrated zones وsecure dynamic updates عندما يكون التصميم Active Directory، ولا تسمح dynamic updates غير الموثقة في zone حساسة.

## BIND 9 Operations

BIND يفصل global options وzones وACLs/views في ملفات configuration بحسب distribution. `named-checkconf` يتحقق من syntax/configuration و`named-checkzone` يتحقق من zone data؛ كلاهما خطوة قبل reload. لا تفتح recursion للعالم ولا تسمح `allow-transfer` إلا للـ secondaries/addresses المعتمدة. راقب `named` journal/logs وserial numbers عند عدم وصول zone change إلى secondary.

## DNS Security Notes

1. Restrict recursion to internal trusted subnets؛ open resolver هدف amplification/abuse.
2. Restrict AXFR/IXFR zone transfers وTSIG keys للـ secondary updates حيث يلزم.
3. Use DNSSEC validation/signing after compatibility and operational planning؛ DNSSEC failure قد يظهر `SERVFAIL`.
4. Separate management plane, apply patches, centralize logs, and alert on unusual NXDOMAIN/response rates.
5. Never expose internal names/addresses in public zones or screenshots/captures without review.

## IPv6 and DNS

AAAA يربط hostname بعنوان IPv6؛ reverse IPv6 يستخدم nibble-reversed `ip6.arpa`. A-only test لا يثبت أن dual-stack application يعمل: Happy Eyeballs/client preference قد يخفي AAAA failure أو يسبب delays. اختبر `A` و`AAAA` صراحة.

## CCNA Memory Anchors

- UDP/TCP `53`; TCP مهم للـ zone transfer وlarge/truncated response.
- Root → TLD → authoritative هي delegation hierarchy، لا مسار client المعتاد في كل query.
- `PTR` = reverse; `NS` = name servers; `MX` = mail; `SRV` = service discovery.
- DNS cache solves speed/scale, not correctness; TTL controls when cached data can be reused.
