# IPv4 Subnetting & VLSM | تقسيم شبكات IPv4

> **Category:** 01-Networking / 05-Subnetting-VLSM
> **Level:** CCNA foundation → CCNP enterprise design
> **Language:** العربية مع English networking terminology

## نظرة عامة | Overview

Subnetting هو تقسيم IPv4 address space إلى شبكات أصغر (subnets) لها Network ID وBroadcast domain مستقلان. يحدد الـ subnet mask عدد network bits وعدد host bits. أما **VLSM (Variable Length Subnet Mask)** فيسمح باستخدام prefix مختلف لكل subnet وفق حجم القسم أو الموقع، فيقلل هدر العناوين ويجعل التصميم قابلاً للتلخيص.

This module covers calculation by binary and block size, enterprise address planning, VLSM allocation, route summarization, and troubleshooting evidence.

## أهداف التعلم | Learning Objectives

- تمييز IPv4 classes التاريخية عن التصميم الحديث باستخدام CIDR.
- تحويل octets بين decimal وbinary، وحساب subnet mask وblock size.
- حساب usable host range وNetwork وBroadcast address.
- إنشاء VLSM plan مرتب من أكبر requirement إلى أصغر requirement.
- تصميم Enterprise IP plan يدعم summarization وgrowth وsecurity boundaries.
- اكتشاف overlap، wrong gateway، mask mismatch، وoff-by-one.
- حل أسئلة CCNA المتعلقة بـ CIDR وsubnetting under time pressure.

## المفاهيم الأساسية | Core Concepts

| الموضوع | الشرح |
|---|---|
| IPv4 | عنوان 32-bit مكوّن من أربعة octets. |
| CIDR | كتابة prefix مثل `/24` بدلاً من classful mask. |
| Subnet mask | يحدد network bits مقابل host bits. |
| Host calculation | usable hosts = `2^host bits - 2` في subnet التقليدية. |
| Network/Broadcast | أول وآخر عنوان في كل subnet. |
| VLSM | أحجام subnets مختلفة ضمن address block واحد. |
| Summarization | دمج prefixes متجاورة في summary route أكبر. |

## IPv4 Classes (Historical)

| Class | First octet | Default mask | الاستخدام التاريخي |
|---|---:|---|---|
| A | 1–126 | `/8` (`255.0.0.0`) | شبكات كبيرة. |
| B | 128–191 | `/16` (`255.255.0.0`) | شبكات متوسطة. |
| C | 192–223 | `/24` (`255.255.255.0`) | شبكات صغيرة. |
| D | 224–239 | N/A | IPv4 multicast. |
| E | 240–255 | N/A | Experimental/reserved. |

`127.0.0.0/8` هو loopback. في Enterprise وCCNA، **CIDR** هو الأساس؛ لا تستنتج prefix من class فقط.

## CIDR and Subnet Masks

CIDR `/n` يعني أن أول `n` bits هي network bits. مثال: `/26` = 26 network bits و6 host bits، mask `255.255.255.192`، و`2^6 - 2 = 62` usable hosts.

| Prefix | Subnet mask | Usable hosts | Block size |
|---:|---|---:|---:|
| `/30` | `255.255.255.252` | 2 | 4 |
| `/29` | `255.255.255.248` | 6 | 8 |
| `/28` | `255.255.255.240` | 14 | 16 |
| `/27` | `255.255.255.224` | 30 | 32 |
| `/26` | `255.255.255.192` | 62 | 64 |
| `/25` | `255.255.255.128` | 126 | 128 |
| `/24` | `255.255.255.0` | 254 | 256 |
| `/23` | `255.255.254.0` | 510 | 512 |

## Calculation Method | طريقة الحل

1. أضف network وbroadcast reservation إلى host requirement.
2. ابحث عن أقل `h` يحقق `2^h - 2 >= required hosts`.
3. احسب prefix = `32 - h` ثم subnet mask.
4. احسب block size = `256 - interesting mask octet`.
5. قرّب عنوان البداية إلى مضاعفات block size؛ هذا هو Network address.
6. Broadcast = عنوان subnet التالي ناقص 1؛ usable range بينهما.

**Example:** `192.168.50.77/27` → ranges `.0–.31`, `.32–.63`, `.64–.95`; network `.64`, broadcast `.95`, usable `.65–.94`.

## VLSM Enterprise Design

ابدأ بأكبر LAN ثم الأصغر، مع الاحتفاظ بالـ unused space. مثال على `10.40.0.0/24`:

| Requirement | Prefix | Allocated subnet | Usable range |
|---|---|---|---|
| Data center 100 hosts | `/25` | `10.40.0.0/25` | `.1–.126` |
| Voice 50 hosts | `/26` | `10.40.0.128/26` | `.129–.190` |
| Management 25 hosts | `/27` | `10.40.0.192/27` | `.193–.222` |
| WAN point-to-point | `/30` | `10.40.0.224/30` | `.225–.226` |
| Future reserve | `/28` | `10.40.0.240/28` | Document before use. |

اجعل boundaries واضحة (site/VRF/VLAN)، واحجز growth، واستخدم summary boundaries مثل `/20` أو `/16` حيث يسمح address plan. لا تجعل summary يغطي subnets غير موجودة في نفس الاتجاه.

## Route Summarization

`10.20.0.0/24` إلى `10.20.3.0/24` يمكن تلخيصها إلى `10.20.0.0/22`: أربع شبكات contiguous، وبداية aligned على block size 4. لا تستخدم `10.20.1.0/22` كملخص صحيح.

## Common Mistakes | أخطاء شائعة

- استخدام default class mask بدلاً من CIDR prefix المطلوب.
- نسيان `-2` للـ network وbroadcast في subnet عادية.
- اعتبار broadcast address قابلاً للتخصيص.
- اختيار VLSM order عشوائياً مما يسبب fragmentation أو overlap.
- حساب block size في octet خطأ.
- وضع default gateway خارج subnet أو DHCP scope غير مطابق للـ mask.
- افتراض أن `/31` و`/32` يتصرفان مثل LAN؛ لهما حالات خاصة.
- تلخيص prefixes غير contiguous أو summary غير aligned.

## CCNA Exam Tips | نصائح الاختبار

- احفظ powers of two وجدول `/30` إلى `/24`.
- ابدأ بالـ interesting octet، وحدد ranges، ثم network/broadcast.
- إذا كان السؤال يطلب hosts، ابحث عن host bits؛ وإذا يطلب subnets، احسب borrowed bits.
- راجع الإجابة بحدود subnet التالية: broadcast يجب أن يسبق network التالي مباشرة.

## روابط الوحدة | Module Links

- [Cheatsheet | الملخص](cheatsheet.md)
- [Commands | الأوامر](commands.md)
- [Notes | الملاحظات](notes.md)
- [Lab Guide | المختبر](lab-guide.md)
- [Troubleshooting | التشخيص](troubleshooting.md)
- [Mermaid Diagrams | المخططات](mermaid-diagram.md)
