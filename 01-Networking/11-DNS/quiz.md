# DNS Quiz | اختبار DNS

## Questions | الأسئلة

1. ما الفرق بين recursive query وiterative query؟
2. ما الفرق بين authoritative answer وnon-authoritative cached answer؟
3. رتب root وTLD وauthoritative server ضمن DNS hierarchy.
4. ما record types المناسبة لـ IPv4، IPv6، reverse lookup، mail، وservice discovery؟
5. لماذا لا يجوز وضع CNAME وA record بالاسم نفسه؟
6. ما معنى TTL، وما أثر خفضه قبل migration؟
7. ما الفرق بين `NXDOMAIN` و`SERVFAIL` وtimeout؟
8. متى يجب اختبار TCP/53 إضافة إلى UDP/53؟
9. ما استخدام conditional forwarder، وما الفرق عن general forwarder؟
10. ما معنى split DNS وما الخطر التشغيلي إن لم يوثق؟
11. ما الذي يفعله `ip name-server` في Cisco IOS؟
12. لماذا يحتاج Active Directory إلى SRV records؟

## Answers | الإجابات

1. recursive server يبحث نيابةً عن client ويعيد نتيجة نهائية؛ iterative query يعيد referral أو answer ويتابع السائل البحث.
2. authoritative server يجيب من zone يملكها؛ cached answer من resolver لا يملك zone لكنه قد يكون صحيحاً حتى TTL.
3. Root ثم TLD ثم authoritative zone/server للـ domain.
4. `A`, `AAAA`, `PTR`, `MX`, `SRV` بالترتيب.
5. CNAME يجعل الاسم alias فقط؛ وجود data أخرى بالاسم نفسه يخلق ambiguity ومخالف لقواعد DNS zone data.
6. TTL مدة cache. خفضه قبل migration يسمح انتشار التغيير أسرع لكنه يزيد query load؛ يجب انتظار TTL القديم.
7. `NXDOMAIN`: name غير موجود؛ `SERVFAIL`: server فشل؛ timeout: لم يصل reply.
8. عند zone transfer أو response كبير/truncated (`TC=1`) وأي application/path policy قد يستخدم TCP DNS.
9. conditional forwarder يرسل suffix محدداً إلى resolver محدد؛ general forwarder يعالج queries غير المحلية بصورة أوسع.
10. answers داخلية وخارجية مختلفة للاسم نفسه؛ بلا ownership/testing قد ينتج exposure أو answers خاطئة.
11. يضبط router كـ DNS client لاستخدام resolvers للأوامر المعتمدة على الاسم؛ لا يحوله إلى DNS recursive server.
12. AD clients تستخدم SRV لاكتشاف domain controllers وخدمات مثل LDAP/Kerberos.
