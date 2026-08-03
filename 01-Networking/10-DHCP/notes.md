# DHCP Notes | ملاحظات DHCP

## Broadcast Domain وRelay

DHCP Discover لا يعبر Layer 3 broadcast boundary. relay لا "يمد VLAN"؛ هو ينهي broadcast محلياً ويحوّل الطلب إلى unicast، ثم يستخدم DHCP server قيمة `giaddr` لاختيار scope. لهذا يجب أن يكون لكل VLAN subnet فريد وscope صحيح وroute عائد إلى relay.

## Renewal/Rebinding Details

في renewal، العميل لديه عنوان ويعرف server identifier لذلك يرسل unicast DHCPREQUEST غالباً. إذا لم يصل server، لا يبدّل gateway عشوائياً؛ ينتظر T2 ثم يبث rebind. عند expiry لا يحق له الاستمرار باستعمال العنوان. راقب clock/NTP وlease durations، فالقيم القصيرة ترفع traffic والسجل، والطويلة تبطئ استرداد العناوين.

## Reservation مقابل Static IP

Reservation يبقي control plane في DHCP: نفس IP، options مركزية، وتاريخ lease واضح. static IP مناسب فقط عندما يتطلب design ذلك ويجب أن يكون خارج dynamic allocation أو excluded وموثقاً. لا تحجز عنواناً مستعملاً ولا تنشئ reservation اعتماداً على MAC تم نسخه أو تغيّر دون تحديث inventory.

## Option 82

Option 82 يضيف relay/switch معلومات عن مكان العميل، مثل circuit ID. يساعد policy والتتبع لكنه قد يسبب failure إن كان server يرفضه أو لا يتوقعه. فعّل insert/validation/trust فقط بعد اختبار end-to-end ومعرفة سلوك المنصة.

## DHCP Failover

Windows DHCP failover يمكن أن يستخدم load balance أو hot standby بين serverين لنفس scopes. لا تخلط leases يدوياً بين servers؛ صمم peer relationship، firewall/DNS/AD requirements، monitoring، وخطوات recovery حسب توثيق المنصة. DHCP على Cisco IOS أو Linux يحتاج نموذج redundancy مختلفاً بحسب software.

## Wireshark Reading Order

ابدأ من أول Discover للـ MAC أو `xid` نفسه، ثم اربط Offer وRequest وACK. تحقق أن Offer جاء من server مقصود، وأن Request اختار Option 54 نفسه، وأن ACK يحوي mask/router/DNS المتوقعة. وجود Discover فقط يشير غالباً إلى VLAN/relay/path؛ وجود ACK لكن client بلا اتصال يشير إلى options، VLAN port، duplicate IP، أو policy لاحقة.

## CCNA Memory Anchors

- DORA = Discover → Offer → Request → ACK.
- UDP `67` server و`68` client.
- `ip helper-address` على router/SVI gateway للـ remote VLAN.
- DHCP Snooping يمنع untrusted DHCP server messages؛ uplink الشرعي trusted.
- APIPA `169.254.0.0/16` علامة على عدم نجاح DHCP، وليس default gateway قابل للاستخدام.
