# DHCP Quiz | اختبار DHCP

## Questions | الأسئلة

1. ما ترتيب DORA ولماذا يكون DHCPREQUEST الأولي broadcast غالباً؟
2. ما UDP ports المستخدمة من DHCP client وDHCP server؟
3. ما الفرق بين DHCP reservation وstatic IP؟
4. متى يستخدم client renewal ومتى يستخدم rebinding؟
5. لماذا لا يصل Discover إلى DHCP server في VLAN أخرى من دون relay؟
6. أين يوضع `ip helper-address` في تصميم VLAN متعدد؟
7. ما الخيارات التي توفر subnet mask وdefault gateway وDNS؟
8. Client يحصل على `169.254.25.10`. ما الذي يدل عليه ذلك وما أول evidence تجمعه؟
9. ما خطر وضع access port كـ DHCP Snooping trusted؟
10. DHCP ACK يعرض gateway خاطئاً. هل تبدأ بفحص routing أم scope options؟ ولماذا؟
11. ما فائدة `giaddr`؟
12. اذكر سببين قد يؤديان إلى pool exhaustion أو duplicate IPs.

## Answers | الإجابات

1. Discover → Offer → Request → ACK؛ broadcast يعلن اختيار العرض ويتيح للـ servers الأخرى سحب عروضها.
2. Client UDP `68` وserver UDP `67`.
3. reservation يوزع DHCP العنوان نفسه بناءً على identity؛ static يضبط محلياً ويحتاج ضبط/توثيق منفصلين.
4. T1 تقريباً 50%: unicast إلى original server؛ T2 تقريباً 87.5%: broadcast إلى أي server.
5. لأن DHCP broadcast لا يعبر router؛ relay يحوله إلى unicast ويملأ `giaddr`.
6. على SVI/router interface الذي يعمل default gateway للـ client VLAN.
7. Option 1 mask، Option 3 router، Option 6 DNS.
8. APIPA بسبب فشل DHCP؛ اجمع VLAN/link و`ipconfig /all` وDORA capture/relay evidence.
9. يمكن للـ rogue DHCP server إرسال Offers/ACKs إلى clients.
10. scope options أولاً؛ ACK نفسه يثبت أن server أعطى Option 3 خاطئاً، ثم راجع L3 عند صحة option.
11. يحدد relay subnet للـ server كي يختار scope الصحيح.
12. static IP داخل pool، leases طويلة/عدم كفاية range، stale records، أو overlap بين scopes.
