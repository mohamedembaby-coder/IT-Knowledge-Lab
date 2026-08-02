# Subnetting Notes | ملاحظات أساسية

## IPv4 Structure

IPv4 عنوان 32-bit مقسم إلى أربعة octets. الـ prefix يحدد network portion، والباقي host portion. مثال `192.168.10.25/24`: أول 24 bit للشبكة وآخر 8 للـ host.

## Binary Conversion

استخدم أوزان الـ octet: `128 64 32 16 8 4 2 1`. لتحويل 173: `128 + 32 + 8 + 4 + 1 = 173` → `10101101`. لتحويل `11000000`: `128 + 64 = 192`.

## Subnetting vs VLSM

- **FLSM:** كل subnets لها نفس prefix؛ سهل لكنه يهدر عناوين.
- **VLSM:** كل requirement يأخذ prefix مناسباً؛ أكثر كفاءة ويتطلب plan ومنع overlaps.
- **CIDR:** طريقة كتابة وتوجيه prefixes؛ VLSM هو التطبيق العملي لأحجام مختلفة.

## Network and Broadcast Logic

الـ network address هو AND بين IP وmask. Broadcast يضع كل host bits إلى 1. في `10.1.8.130/26`، block size 64؛ range `.128–.191`، network `.128`, broadcast `.191`, hosts `.129–.190`.

## Enterprise Design Principles

1. استخدم summarizable blocks لكل site أو region، مثل `10.40.0.0/16`.
2. افصل User, Voice, Server, Management, Guest, وTransit subnets.
3. احجز growth وfuture sites وسجّل allocation في IPAM.
4. اجعل WAN point-to-point من `/31` أو `/30` وفق دعم المنصة.
5. وثّق prefix، VLAN/VRF، gateway، DHCP range، owner، وsummary boundary.

## Route Summarization Math

لدمج `N` شبكات متجاورة من نفس الحجم، يجب أن يكون N قوة للعدد 2 وأن تكون بداية أول شبكة aligned. دمج أربع `/24` يعطي `/22`؛ binary check يمنع summary غير صالح.

## Common Mistakes

- `/24` يعني 256 total و254 usable، وليس 256 hosts.
- `255.255.255.192` هو `/26` وليس `/28`.
- `.64` قد يكون network address في block size 64، وليس أول host.
- mask مختلف بين طرفين قد ينتج local/remote classification خاطئاً.
- overlap بين DHCP scope وstatic reservations يسبب duplicate IP.

## CCNA Exam Strategy

- اكتب powers of two على المسودة.
- حدد interesting octet من أول mask octet أقل من 255.
- افصل سؤال "كم subnet؟" عن سؤال "كم host؟".
- راجع أن broadcast يسبق network التالي مباشرة.
