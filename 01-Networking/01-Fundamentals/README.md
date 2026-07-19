# Networking Fundamentals

> Category: 01-Networking

---

# 📖 Overview | نظرة عامة

## English

Networking Fundamentals is the foundation of every networking and cybersecurity career path. This topic covers the core building blocks you need before diving into OSI, TCP/IP, or Subnetting: what a network actually is, the different network types and topologies, the devices that make a network work, and the physical media (cables, connectors, wireless) that carry the data. Everything in Windows Server, FortiGate, and CCNA builds on top of these basics.

## العربية

Networking Fundamentals هو حجر الأساس لأي مسار في الشبكات أو الأمن السيبراني. الموضوع ده بيغطي اللبنات الأساسية اللي لازم تفهمها قبل ما تدخل في OSI أو TCP/IP أو Subnetting: إيه هي الشبكة أصلاً، أنواع الشبكات والطوبولوجيات المختلفة، الأجهزة اللي بتخلي الشبكة تشتغل، والوسائط الفيزيائية (كابلات، كونيكتورز، لاسلكي) اللي بتنقل البيانات. كل حاجة هتتعلمها بعدين في Windows Server وFortiGate وCCNA مبنية على الأساسيات دي.

---

# 📌 Prerequisites | المتطلبات

## English

Before studying this module, you should have:

- Basic computer knowledge.
- Familiarity with using Windows or Linux.
- No prior networking experience is required.

## العربية

قبل دراسة هذا الفصل يُفضل أن يكون لديك:

- معرفة أساسية باستخدام الكمبيوتر.
- القدرة على استخدام Windows أو Linux.
- لا يشترط وجود خبرة سابقة في الشبكات.

---

After completing this module, you will be ready to study:

- IP Addressing
- OSI Model
- TCP/IP
- Ethernet Switching
- Routing Fundamentals

# 🎯 Objectives | الأهداف

- Learn the difference between LAN, WAN, MAN, PAN, and WLAN.
- Understand the main network topologies (Bus, Star, Ring, Mesh, Hybrid) and enterprise architectures (2-Tier, 3-Tier, Spine-Leaf, SOHO).
- Identify core network devices (Hub, Switch, Router, Firewall, Access Point) and the role of each.
- Recognize physical media types (Copper vs Fiber) and cable/connector standards.
- Diagnose basic physical-layer (Layer 1) interface and cable problems.

---

# 🗺️ Learning Path | مسار التعلم

```text
Networking Fundamentals
        ↓
IP Addressing
        ↓
Subnetting
        ↓
OSI Model
        ↓
TCP/IP Model
        ↓
Ethernet Switching
        ↓
Routing Fundamentals
```

## العربية

يعرض هذا المسار ترتيب دراسة موضوعات الشبكات داخل المشروع، بحيث يبني كل فصل على المعلومات التي تعلمتها في الفصل السابق.



# 📚 Theory | الشرح

## English

### 1. Network Types by Scale
| Type | Full Name | Typical Range | Example |
|---|---|---|---|
| PAN | Personal Area Network | A few meters | Bluetooth between phone and headset |
| LAN | Local Area Network | A building/office | ATOPS internal office network |
| WLAN | Wireless LAN | A building (wireless) | Office Wi-Fi |
| MAN | Metropolitan Area Network | A city | ISP network connecting multiple branches in one city |
| WAN | Wide Area Network | Countries/continents | The Internet, MPLS link between two branches |

### 2. Network Topologies (Physical Layout)
| Topology | Description | Pros | Cons |
|---|---|---|---|
| Bus | All devices share one central cable | Cheap, simple | One cable failure = whole network down |
| Star | All devices connect to a central switch | Easy to troubleshoot, most common today | Switch failure affects all connected devices |
| Ring | Each device connects to exactly two neighbors, forming a loop | Predictable traffic flow | One break can disrupt the ring (unless dual-ring) |
| Mesh | Every device connects to every other device | Very high redundancy | Expensive, complex cabling |
| Hybrid | Combination of the above | Flexible, matches real-world needs | More complex to design |

### 3. Enterprise Network Architectures
- **2-Tier (Collapsed Core):** Core and Distribution layers merged into one — used in small/medium networks.
- **3-Tier:** Core → Distribution → Access layers separated — used in larger enterprise networks for scalability.
- **Spine-Leaf:** Modern data center architecture where every Leaf switch connects to every Spine switch — optimized for East-West (server-to-server) traffic.
- **SOHO (Small Office/Home Office):** A single router/firewall handling routing, switching, and sometimes Wi-Fi for a small number of users.

### 4. Core Network Devices
| Device | Layer | Function |
|---|---|---|
| Hub | Layer 1 | Repeats signal to all ports (legacy, rarely used today) |
| Switch | Layer 2 (some Layer 3) | Forwards frames based on MAC address, creates separate collision domains per port |
| Router | Layer 3 | Forwards packets between different networks based on IP address |
| Firewall | Layer 3-7 | Filters traffic based on security policies (e.g., FortiGate) |
| Access Point (AP) | Layer 1-2 | Provides wireless connectivity to a wired network |
| Bridge | Layer 2 | Connects and filters traffic between two network segments |

### 5. Physical Media & Cabling
| Media Type | Standard | Max Distance | Typical Use |
|---|---|---|---|
| Copper UTP | Cat5e | 100m | 1 Gbps LAN |
| Copper UTP | Cat6 | 100m (55m at 10G) | 1-10 Gbps LAN |
| Copper UTP | Cat6a | 100m | 10 Gbps LAN |
| Fiber | Multi-Mode (MMF) | ~550m | Data center, short-distance high-speed |
| Fiber | Single-Mode (SMF) | Kilometers | Long-distance/ISP backbone links |

### 6. Connectors & Cable Types
- **RJ45**: Standard connector for Ethernet copper cables.
- **T568A / T568B**: Two wiring standards for RJ45 termination. A cable using the same standard on both ends is a **Straight-Through** cable (PC-to-Switch). A cable using T568A on one end and T568B on the other is a **Crossover** cable (Switch-to-Switch, PC-to-PC directly) — though modern NICs auto-detect (Auto-MDIX) and this is rarely needed manually anymore.
- **SFP / SFP+**: Modular transceivers used in switches/routers/firewalls (like the FortiGate 200F) for fiber or high-speed copper uplinks.

### 7. Common Layer 1 (Physical) Issues
- Damaged or miswired cables.
- Wrong cable type for the distance/speed required.
- Port/interface errors: CRC errors, collisions, duplex mismatch.
- Loose or dirty fiber connectors causing signal loss (attenuation).

## العربية

### 1. أنواع الشبكات حسب الحجم
| النوع | الاسم الكامل | المدى المعتاد | مثال |
|---|---|---|---|
| PAN | شبكة شخصية | أمتار قليلة | بلوتوث بين الموبايل والسماعة |
| LAN | شبكة محلية | مبنى/مكتب | شبكة ATOPS الداخلية |
| WLAN | شبكة محلية لاسلكية | مبنى (لاسلكي) | الواي فاي في المكتب |
| MAN | شبكة مدينة | مدينة كاملة | شبكة ISP بتربط فروع في نفس المدينة |
| WAN | شبكة واسعة | دول/قارات | الإنترنت، رابط MPLS بين فرعين |

### 2. طوبولوجيات الشبكة (الشكل الفيزيائي)
| الطوبولوجي | الوصف | المميزات | العيوب |
|---|---|---|---|
| Bus | كل الأجهزة على كابل واحد مشترك | رخيص وبسيط | عطل الكابل = الشبكة كلها واقعة |
| Star | كل الأجهزة متوصلة بسويتش مركزي | سهل التتبع والصيانة، الأكثر استخدامًا حاليًا | عطل السويتش يأثر على كل الأجهزة المتصلة بيه |
| Ring | كل جهاز متوصل بجهازين بس، وبتتشكل حلقة | تدفق بيانات منظم ومتوقع | كسر واحد ممكن يعطل الحلقة كلها (إلا لو Dual-Ring) |
| Mesh | كل جهاز متوصل بكل الأجهزة التانية | أعلى درجة تكرار (Redundancy) | مكلف ومعقد في التوصيلات |
| Hybrid | خليط من الأنواع السابقة | مرن وبيناسب احتياجات الواقع | أصعب في التصميم |

### 3. معماريات الشبكات في الشركات
- **2-Tier (Collapsed Core):** دور الـ Core والـ Distribution بيتدمجوا في طبقة واحدة — بيستخدم في الشبكات الصغيرة والمتوسطة.
- **3-Tier:** فصل واضح بين Core و Distribution و Access — بيستخدم في الشبكات الكبيرة عشان قابلية التوسع.
- **Spine-Leaf:** معمارية Data Center حديثة، كل Leaf Switch متوصل بكل Spine Switch — محسّنة للترافيك بين السيرفرات (East-West).
- **SOHO:** راوتر/فايروول واحد بيقوم بدور الراوتنج والسويتشنج وأحيانًا الواي فاي لعدد قليل من المستخدمين.

### 4. أجهزة الشبكة الأساسية
| الجهاز | الطبقة | الوظيفة |
|---|---|---|
| Hub | Layer 1 | بيكرر الإشارة لكل البورتات (قديم ونادر الاستخدام حاليًا) |
| Switch | Layer 2 (وأحيانًا Layer 3) | بيوجّه الفريمات على أساس MAC Address، وبيعمل Collision Domain منفصل لكل بورت |
| Router | Layer 3 | بيوجّه الباكيتات بين شبكات مختلفة على أساس IP Address |
| Firewall | Layer 3-7 | بيفلتر الترافيك حسب سياسات الأمان (زي FortiGate) |
| Access Point | Layer 1-2 | بيوفر اتصال لاسلكي للشبكة السلكية |
| Bridge | Layer 2 | بيربط ويفلتر الترافيك بين قطعتين من الشبكة |

### 5. الوسائط الفيزيائية والكابلات
| نوع الوسط | المعيار | أقصى مسافة | الاستخدام |
|---|---|---|---|
| نحاس UTP | Cat5e | 100م | شبكة 1 جيجا |
| نحاس UTP | Cat6 | 100م (55م عند 10 جيجا) | شبكة 1-10 جيجا |
| نحاس UTP | Cat6a | 100م | شبكة 10 جيجا |
| فايبر | Multi-Mode | حوالي 550م | داتا سنتر، مسافات قصيرة عالية السرعة |
| فايبر | Single-Mode | كيلومترات | روابط ISP والمسافات الطويلة |

### 6. الكونيكتورز وأنواع الكابلات
- **RJ45**: الكونيكتور القياسي لكابلات الإيثرنت النحاسية.
- **T568A / T568B**: معياران لتوصيل أسلاك RJ45. لو الطرفين بنفس المعيار بيبقى كابل **Straight-Through** (من PC للسويتش). لو طرف T568A والتاني T568B بيبقى كابل **Crossover** (سويتش لسويتش، أو PC لPC مباشرة) — رغم إن الكروت الحديثة فيها Auto-MDIX وبقى نادر تحتاجه يدوي دلوقتي.
- **SFP / SFP+**: ترانسيفرات قابلة للتغيير بتتحط في السويتشات والراوترات والفايروولز (زي FortiGate 200F) للفايبر أو أب لينكات نحاس عالية السرعة.

### 7. مشاكل Layer 1 الشائعة
- كابلات تالفة أو موصلة غلط.
- نوع كابل غلط بالنسبة للمسافة أو السرعة المطلوبة.
- أخطاء على البورت: CRC errors, collisions, duplex mismatch.
- كونيكتورز فايبر مش نضيفة أو مش مثبتة كويس بتسبب ضعف في الإشارة (Attenuation).

---

# 🖼️ Diagrams

Store diagrams inside:

```
diagrams/
```

**Suggested diagrams for this topic:**
- Network Topologies comparison (Bus/Star/Ring/Mesh/Hybrid)
- 3-Tier vs Spine-Leaf architecture comparison
- Straight-Through vs Crossover cable wiring (T568A/T568B)

---

# 💻 Labs

Store labs inside:

```
labs/
```

See `lab-guide.md` for the full hands-on lab of this topic.

---

# ⚡ Commands

See:

```
commands.md
```

---

# 📝 Notes

See:

```
notes.md
```

---

# 🛠️ Troubleshooting

See:

```
troubleshooting.md
```

---

# 📚 References

- Cisco Networking Basics: https://www.cisco.com/c/en/us/solutions/small-business/resource-center/networking/networking-basics.html
- Microsoft Learn - Networking Fundamentals: https://learn.microsoft.com/en-us/training/paths/network-fundamentals/
- Fortinet FortiGate Documentation: https://docs.fortinet.com/product/fortigate

---

Created by **Mohamed Embaby**


---

# 🌍 History of Computer Networking

## English

Computer networking did not begin with the Internet. It evolved over decades of research, military projects,
and commercial innovation.

### Timeline

| Year | Milestone |
|------|-----------|
| 1960s | Early packet-switching research |
| 1969 | ARPANET connected its first computers |
| 1973 | TCP protocol development began |
| 1983 | TCP/IP became the ARPANET standard |
| 1989 | World Wide Web proposed by Tim Berners-Lee |
| 1995 | Commercial Internet expansion |
| Today | Cloud Computing, SD-WAN, IoT, AI Networking |

### Why ARPANET Was Important

ARPANET proved that computers located in different places could communicate reliably using packet switching.
This idea became the foundation of today's Internet.

---

## العربية

بدأت الشبكات قبل ظهور الإنترنت بسنوات طويلة من خلال أبحاث متعلقة بتبادل البيانات بين أجهزة الكمبيوتر.

أهم محطة كانت **ARPANET** والتي تعتبر الأب الحقيقي للإنترنت الحديث.

بعد ذلك ظهر بروتوكول **TCP/IP** وأصبح المعيار الأساسي لاتصال الشبكات حتى يومنا هذا.

---

# 📡 What is Data Communication?

Data Communication is the process of exchanging information between two or more devices through a transmission medium.

Every communication requires:

- Sender
- Receiver
- Message
- Transmission Medium
- Protocol

Without these five components, communication cannot occur correctly.

---

# 🔄 Communication Model

```
Sender
   │
   ▼
Encoding
   │
Transmission Medium
   │
Decoding
   │
Receiver
```

### Example

Ahmed sends an email to Mohamed.

- Ahmed = Sender
- Email = Message
- Office Network = Medium
- SMTP = Protocol
- Mohamed = Receiver

---

# 📦 Data vs Information

| Data | Information |
|------|-------------|
| Raw facts | Processed data |
| No meaning by itself | Useful and meaningful |
| Example: 192.168.1.10 | Example: IP Address of File Server |

---

# 🤝 Client-Server vs Peer-to-Peer

| Feature | Client-Server | Peer-to-Peer |
|---------|---------------|--------------|
| Central Management | Yes | No |
| Security | High | Limited |
| Scalability | Excellent | Poor |
| Backup | Centralized | Manual |
| Best For | Companies | Small Home Networks |

### Enterprise Example

An organization with 500 employees usually uses:

- Active Directory
- File Server
- DNS Server
- DHCP Server
- Backup Server
- Firewall
- Core Switches

instead of sharing files directly between employee computers.

---

# 📈 Network Performance Basics

## Bandwidth

Maximum capacity of a communication link.

## Throughput

Actual amount of transferred data.

## Latency

Time required for data to travel.

## Jitter

Variation in packet delay.

## Packet Loss

Packets that never reach the destination.

---

# 💡 Key Takeaways

- Every modern IT technology depends on networking.
- TCP/IP is the foundation of today's Internet.
- Client-Server architecture dominates enterprise environments.
- Good physical design reduces troubleshooting time.
- Understanding fundamentals makes learning CCNA, Windows Server and Cybersecurity much easier.



---

# 🌐 Common Network Services

Modern networks rely on services that automate communication and resource access.

| Service | Default Port | Purpose |
|---------|--------------|---------|
| DNS | 53 | Resolves names to IP addresses |
| DHCP | 67/68 | Automatically assigns IP configuration |
| HTTP | 80 | Web browsing |
| HTTPS | 443 | Secure web browsing |
| FTP | 21 | File transfer |
| SFTP | 22 | Secure file transfer |
| SMTP | 25 | Sending email |
| POP3 | 110 | Receiving email |
| IMAP | 143 | Synchronizing email |

### Enterprise Example

When a user opens **https://portal.company.local**:

1. DNS resolves the server name.
2. The client sends HTTPS traffic.
3. The firewall checks security policies.
4. The server returns the requested page.

---


# 🔐 Basic Network Security

Good networking always includes security.

## Core Principles

- Least Privilege
- Network Segmentation
- Strong Authentication
- Encryption
- Regular Backups
- Monitoring and Logging
- Patch Management

### Security Devices

- Firewall
- IDS
- IPS
- VPN Gateway
- Web Filter
- Endpoint Protection

---

# ✅ Networking Best Practices

- Document every device.
- Label cables clearly.
- Keep firmware updated.
- Avoid unnecessary daisy chaining.
- Separate users and servers using VLANs.
- Backup switch and firewall configurations.
- Monitor bandwidth usage.
- Test backups regularly.
- Use strong administrator passwords.
- Maintain an IP Address Management (IPAM) document.

---

# 🎤 Interview Questions

1. What is the difference between a Hub and a Switch?
2. Why is TCP/IP important?
3. Explain the difference between LAN and WAN.
4. What is the purpose of DNS?
5. What is DHCP?
6. What is the difference between Bandwidth and Throughput?
7. Why is Fiber preferred for long distances?
8. What is a Collision Domain?
9. What is the role of a Firewall?
10. What is the purpose of VLANs?

---

# 📖 Mini Glossary

| Term | Meaning |
|------|---------|
| Node | Any connected device |
| Host | Device with an IP address |
| Packet | Unit of Layer 3 data |
| Frame | Unit of Layer 2 data |
| Segment | TCP data unit |
| Port | Logical communication endpoint |
| NIC | Network Interface Card |
| Gateway | Exit point to another network |
| Broadcast | Traffic sent to all devices |
| Unicast | Traffic sent to one device |
| Multicast | Traffic sent to a selected group |



---

# 🧩 OSI Model Preview

The OSI (Open Systems Interconnection) model is a conceptual framework that explains how data travels from one device to another.

| Layer | Name | Main Responsibility | Examples |
|------:|------|---------------------|----------|
| 7 | Application | Network services for users | HTTP, FTP, SMTP |
| 6 | Presentation | Encryption, compression | TLS, SSL |
| 5 | Session | Session management | NetBIOS |
| 4 | Transport | Reliable delivery | TCP, UDP |
| 3 | Network | Logical addressing | IP, ICMP |
| 2 | Data Link | Frames & MAC addresses | Ethernet |
| 1 | Physical | Bits over media | Copper, Fiber |

> A dedicated chapter explains every layer in depth.

---

# 🌍 TCP/IP Model Preview

The TCP/IP model is the practical model used on the Internet.

| TCP/IP Layer | Related OSI Layers |
|--------------|--------------------|
| Application | 5, 6, 7 |
| Transport | 4 |
| Internet | 3 |
| Network Access | 1, 2 |

---

# 🌍 IPv6 Introduction | مقدمة عن IPv6

## English

IPv4 has a limited address space. As the number of Internet-connected devices increased, IPv6 was introduced to provide a much larger address space and improve scalability.

IPv6 uses **128-bit** addresses instead of IPv4's **32-bit** addresses.

Example:

```
2001:db8::1
```

> A dedicated chapter will explain IPv6 in detail.

---

## العربية

تم تطوير IPv6 بسبب نفاد عناوين IPv4.

يستخدم IPv6 عناوين بطول **128 بت** بدلاً من **32 بت** في IPv4، مما يسمح بعدد هائل من العناوين.

مثال:

```
2001:db8::1
```

سيتم شرح IPv6 بالكامل في فصل مستقل لاحقًا.



# 📊 Collision Domain vs Broadcast Domain

| Item | Collision Domain | Broadcast Domain |
|------|------------------|------------------|
| Created by | Switch Ports | Routers & VLANs |
| Purpose | Reduce frame collisions | Limit broadcast traffic |
| Scope | Usually one switch port | One VLAN / subnet |

Example:
- A 24-port switch creates 24 collision domains.
- One VLAN on that switch is one broadcast domain.
- Creating multiple VLANs divides the broadcast domains.

---

# 🔄 Duplex Modes

## Half Duplex
- One direction at a time.
- Older Ethernet hubs.
- More collisions.

## Full Duplex
- Send and receive simultaneously.
- Modern switches.
- No collisions.
- Maximum performance.

---

# ⚙️ QoS (Quality of Service)

QoS prioritizes important traffic.

Typical priorities:

1. Voice (VoIP)
2. Video Conferencing
3. Business Applications
4. Web Browsing
5. File Downloads
6. Backups

Without QoS, voice and video may become unstable during heavy network utilization.

---




# ✅ Chapter Summary

After completing this chapter you should be able to:

- Explain networking terminology.
- Identify common network devices.
- Distinguish LAN, WAN, MAN, WLAN and PAN.
- Compare Client-Server with Peer-to-Peer.
- Recognize common enterprise network architectures.
- Understand basic security principles.
- Interpret the OSI and TCP/IP models at a high level.
- Prepare for advanced networking topics.



---

# 🇪🇬 شرح عربي موسع | Networking Fundamentals باللغة العربية

## ما هي شبكة الحاسب؟

شبكة الحاسب هي مجموعة من الأجهزة المتصلة ببعضها بهدف **تبادل البيانات ومشاركة الموارد والخدمات**.

قد تكون هذه الأجهزة:
- أجهزة كمبيوتر
- سيرفرات
- طابعات
- كاميرات مراقبة
- هواتف IP
- نقاط وصول لاسلكية (Access Points)
- أجهزة تخزين NAS

### 💡 مثال عملي

في شركة يوجد 100 موظف.

بدون شبكة:
- كل موظف يعمل على جهازه فقط.
- مشاركة الملفات تتم عن طريق USB.
- لكل طابعة مستخدم واحد.
- لا توجد إدارة مركزية.

مع وجود شبكة:
- كل الموظفين يستخدمون File Server واحد.
- الجميع يطبع على نفس الطابعات.
- يتم تسجيل الدخول بحساب Active Directory.
- يمكن للإدارة عمل نسخ احتياطي لجميع الملفات.

---

## لماذا نستخدم الشبكات؟

الشبكات لا توفر الإنترنت فقط، بل تساعد على:

- مشاركة الملفات.
- مشاركة الطابعات.
- الوصول إلى قواعد البيانات.
- تشغيل أنظمة ERP مثل Odoo.
- إدارة المستخدمين.
- تطبيق سياسات الأمان.
- تقليل تكلفة الأجهزة والإدارة.

---

## 💡 Bandwidth بطريقة بسيطة

تخيل أن الطريق السريع مكوّن من 8 حارات.

عدد الحارات يمثل **Bandwidth**.

أما عدد السيارات التي تسير فعليًا فهو **Throughput**.

إذا كان الطريق مزدحمًا أو توجد حوادث فسيمر عدد سيارات أقل رغم أن الطريق ما زال مكونًا من 8 حارات.

---

## 💡 Latency

الـ Latency هو الزمن الذي تستغرقه البيانات للوصول من جهاز إلى آخر.

مثال:

إذا ضغطت على زر فتح موقع وانتظرت نصف ثانية حتى يبدأ الموقع في الاستجابة، فهذا جزء من الـ Latency.

كلما قل كان أداء الشبكة أفضل.

---

## ⚠️ أخطاء شائعة

### الخطأ الأول

الاعتقاد أن سرعة الإنترنت = سرعة الشبكة.

الحقيقة:

قد تكون الشبكة الداخلية بسرعة 1Gbps بينما الإنترنت 100Mbps فقط.

---

### الخطأ الثاني

الاعتقاد أن Switch و Router نفس الشيء.

- Switch يربط الأجهزة داخل نفس الشبكة.
- Router يربط بين شبكات مختلفة.

---

### الخطأ الثالث

الاعتقاد أن Firewall يمنع الفيروسات فقط.

الحقيقة أن الفايروول يتحكم في مرور البيانات ويطبق سياسات الأمان وقد يوفر VPN وWeb Filtering وIPS وغيرها.

---

## 🧠 معلومة مهمة

في أغلب الشركات يكون ترتيب الاتصال كالتالي:

Internet
→ ISP Router
→ Firewall (FortiGate)
→ Core Switch
→ Access Switch
→ User PC

إذا تعطل أي جهاز في هذا المسار سيتأثر الاتصال حسب موقع العطل.

---

## 📌 من واقع العمل

إذا اشتكى موظف أن الإنترنت لا يعمل:

لا تبدأ بتغيير إعدادات الـ Firewall مباشرة.

ابدأ بالترتيب:

1. تأكد من كابل الشبكة.
2. تحقق من لمبة Link.
3. نفذ ipconfig.
4. جرّب Ping على الـ Gateway.
5. جرّب Ping على 8.8.8.8.
6. جرّب Ping على google.com.
7. راجع DHCP وDNS.
8. افحص سجلات الـ Firewall إذا لزم الأمر.

هذه الطريقة تقلل وقت حل المشكلة وتمنع القفز إلى استنتاجات خاطئة.



---

# 🌐 شرح موسع لخدمات الشبكة | Network Services Explained

## DNS (Domain Name System)

### English
DNS translates human-readable domain names into IP addresses so computers can communicate.

Example:
`google.com` → `142.250.x.x`

### العربية

تخيل أنك تريد الاتصال بصديقك، لكنك لا تعرف رقم هاتفه وتعرف اسمه فقط.

هنا يأتي دور **DNS**.

بدلاً من أن تحفظ عنوان IP لكل موقع، تكتب اسم الموقع فقط، ويقوم DNS بتحويله إلى عنوان IP الحقيقي.

### 💡 مثال عملي

عندما تفتح:

```
https://portal.company.local
```

يحدث الآتي:

1. جهازك يسأل DNS Server.
2. DNS يعيد عنوان الـ IP.
3. يبدأ الاتصال بالسيرفر.

إذا تعطل DNS فلن تعمل أسماء المواقع حتى لو كان الاتصال بالشبكة سليمًا.

### ⚠️ خطأ شائع

يعتقد البعض أن الإنترنت لا يعمل.

لكن الحقيقة أحيانًا تكون المشكلة في DNS فقط.

اختبر ذلك بعمل:

```
ping 8.8.8.8
```

ثم:

```
ping google.com
```

إذا نجح الأول وفشل الثاني فغالبًا المشكلة DNS.

---

# 🖥️ DHCP

### العربية

DHCP هو المسؤول عن توزيع إعدادات الشبكة تلقائيًا على الأجهزة.

بدلاً من إدخال:

- IP Address
- Subnet Mask
- Gateway
- DNS

يدويًا لكل جهاز...

يقوم DHCP بكل ذلك تلقائيًا.

### خطوات العمل

1. الجهاز يتصل بالشبكة.
2. يرسل Discover.
3. السيرفر يرد Offer.
4. الجهاز يرسل Request.
5. السيرفر يرسل ACK.

وتسمى العملية DORA.

### 🧠 في الشركات

يكون DHCP غالبًا على:

- Windows Server
- FortiGate
- Cisco Router

حسب تصميم الشبكة.

---

# 🛠️ مثال عملي من بيئة العمل

موظف جديد وصل جهازه.

بدلاً من كتابة IP يدويًا:

- يشبك كابل الشبكة.
- يحصل على IP تلقائيًا.
- يستطيع الدخول للدومين.
- يستطيع الوصول للطابعات.
- يستطيع استخدام الإنترنت.

كل ذلك بفضل DHCP.

---

# 🎯 أسئلة مراجعة

1. ما الفرق بين DNS وDHCP؟
2. ماذا يحدث إذا توقف DNS؟
3. هل يمكن استخدام الشبكة بدون DHCP؟
4. لماذا تستخدم الشركات DHCP؟
5. ما هي خطوات DORA؟



---

# 🌍 IP Address Explained | شرح عنوان الـ IP

## English

An IP Address is the logical address assigned to every device on a network.
It allows devices to identify each other and communicate across local and remote networks.

Example:

```
192.168.1.10
```

---

## العربية

عنوان الـ **IP Address** هو العنوان المنطقي الذي يميز كل جهاز داخل الشبكة.

فكر فيه كأنه **عنوان المنزل**.

إذا أردت إرسال رسالة لشخص، يجب أن تعرف عنوان منزله.

بنفس الفكرة، عندما يريد جهاز إرسال بيانات إلى جهاز آخر، يجب أن يعرف عنوان الـ IP الخاص به.

بدون IP لن تستطيع الأجهزة معرفة المكان الصحيح لإرسال البيانات إليه.

### 💡 مثال عملي

يوجد في شركتك:

- File Server
- Domain Controller
- Printer
- User PC

كل جهاز يمتلك IP مختلف.

إذا كان File Server يحمل:

```
10.10.20.15
```

فأي جهاز يريد الوصول إليه يرسل البيانات لهذا العنوان.

---

# 🆚 MAC Address vs IP Address

| MAC Address | IP Address |
|-------------|------------|
| عنوان فيزيائي ثابت لكارت الشبكة | عنوان منطقي يمكن تغييره |
| يعمل داخل الشبكة المحلية | يستخدم للوصول بين الشبكات |
| Layer 2 | Layer 3 |
| Example: 00-1A-2B-3C-4D-5E | Example: 192.168.1.100 |

### 🧠 تذكر

يشبه MAC رقم الشاسيه في السيارة.

أما IP فيشبه عنوان المنزل الحالي.

يمكن تغيير عنوان المنزل، لكن رقم الشاسيه لا يتغير.

---

# 🌐 Public IP vs Private IP

## Private IP

يستخدم داخل الشبكات الداخلية.

النطاقات:

- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16

## Public IP

هو العنوان الذي يراه الإنترنت.

يتم توفيره بواسطة مزود خدمة الإنترنت (ISP).

---

# 🚪 Default Gateway

الـ Default Gateway هو الباب الذي تخرج منه البيانات إذا كانت الوجهة خارج الشبكة المحلية.

### مثال

إذا كان جهازك:

IP

```
192.168.1.100
```

Gateway

```
192.168.1.1
```

فعند محاولة فتح Google لن يذهب الجهاز مباشرة إلى الإنترنت، بل سيرسل البيانات أولاً إلى الـ Gateway ثم يقوم الراوتر أو الفايروول بتوجيهها.

---

# 📦 رحلة الباكيت داخل الشركة

```
PC
 │
 ▼
Access Switch
 │
 ▼
Core Switch
 │
 ▼
FortiGate Firewall
 │
 ▼
ISP Router
 │
 ▼
Internet
```

### شرح بالعربي

عندما يفتح الموظف موقعًا إلكترونيًا:

1. الجهاز ينشئ Packet.
2. يتم إرسالها إلى السويتش.
3. تصل إلى الـ Core Switch.
4. تمر على الـ FortiGate.
5. يطبق سياسات الأمان.
6. يرسلها إلى مزود الخدمة.
7. تصل إلى الموقع المطلوب.
8. يعود الرد بنفس المسار تقريبًا.

---

# 🎯 أسئلة مراجعة إضافية

1. ما الفرق بين MAC Address وIP Address؟
2. لماذا نحتاج Default Gateway؟
3. ما الفرق بين Public وPrivate IP؟
4. هل يمكن لجهازين امتلاك نفس IP داخل نفس الشبكة؟
5. لماذا يستخدم الراوتر Layer 3؟



---

# 🚚 TCP vs UDP | شرح عربي احترافي

## لماذا يوجد بروتوكولان؟

طبقة **Transport (Layer 4)** مسؤولة عن نقل البيانات بين الأجهزة. أشهر بروتوكولين هما:

- **TCP (Transmission Control Protocol)**
- **UDP (User Datagram Protocol)**

---

## مقارنة سريعة

| TCP | UDP |
|------|------|
| موثوق | سريع |
| يتأكد من وصول البيانات | لا يتأكد من وصول البيانات |
| يعيد إرسال الحزم المفقودة | لا يعيد الإرسال |
| أبطأ نسبيًا | أسرع |
| يستخدم في نقل الملفات والويب | يستخدم في البث والألعاب وVoIP |

---

## 📦 كيف يعمل TCP؟

قبل إرسال البيانات، ينشئ اتصالًا بين الطرفين.

1. SYN
2. SYN-ACK
3. ACK

يسمى ذلك **Three-Way Handshake**.

بعدها يبدأ إرسال البيانات مع التأكد من وصول كل جزء.

### 💡 مثال عملي

عند تنزيل ملف أو إرسال بريد إلكتروني، فقدان جزء واحد من البيانات غير مقبول، لذلك يُستخدم TCP.

---

## ⚡ كيف يعمل UDP؟

يرسل البيانات مباشرة دون إنشاء اتصال مسبق.

إذا ضاعت بعض الحزم فلن يعيد إرسالها.

### 💡 مثال عملي

في اجتماع Microsoft Teams أو مكالمة VoIP، ضياع جزء صغير من الصوت أفضل من انتظار إعادة الإرسال، لذلك يستخدم UDP في كثير من تطبيقات الصوت والفيديو.

---

# 📦 ARP Protocol

## ما هو ARP؟

يقوم ARP بالربط بين:

- عنوان IP
- عنوان MAC

إذا عرف الجهاز عنوان IP ولم يعرف عنوان MAC، فإنه يستخدم ARP للحصول عليه.

### مثال

يريد الجهاز إرسال بيانات إلى:

IP = 192.168.1.20

يرسل Broadcast:

> من يملك هذا الـ IP؟

يرد الجهاز:

> أنا، وهذا هو عنوان MAC الخاص بي.

بعدها تُحفظ النتيجة في **ARP Cache** لتسريع الاتصالات اللاحقة.

---

# 📡 ICMP و Ping

يستخدم ICMP لاختبار الاتصال وتشخيص الشبكات.

أشهر الأدوات:

- ping
- tracert / traceroute

### أوامر مفيدة

```bash
ping 8.8.8.8
ping google.com
tracert google.com
arp -a
ipconfig /all
```

---

# 💼 سيناريو من بيئة الشركات

الموظف يقول:

"الإنترنت لا يعمل."

ابدأ بالترتيب:

1. ipconfig /all
2. تحقق من IP وGateway.
3. ping Gateway.
4. ping 8.8.8.8.
5. ping google.com.
6. arp -a.
7. tracert إذا استمرت المشكلة.

بهذه الطريقة ستعرف إن كانت المشكلة في Layer 1 أو Layer 2 أو Layer 3 أو DNS أو الاتصال بالإنترنت.

---

# 🎓 أسئلة مقابلات

1. ما الفرق بين TCP وUDP؟
2. لماذا يستخدم DNS غالبًا UDP؟
3. متى يستخدم TCP بدلًا من UDP؟
4. ما وظيفة ARP؟
5. لماذا يفشل ping أحيانًا رغم أن الخدمة تعمل؟



---

# 📦 Data Encapsulation | تغليف البيانات داخل الشبكة

## ما المقصود بـ Encapsulation؟

عند إرسال البيانات عبر الشبكة، لا يتم إرسالها كما هي.

كل طبقة من طبقات OSI تضيف معلومات خاصة بها تسمى **Header** (وأحيانًا Trailer)، حتى تتمكن الطبقة المقابلة في الجهاز الآخر من فهم البيانات.

## رحلة البيانات

```
Application Data
      │
      ▼
Transport
Data + TCP Header
      │
      ▼
Network
Packet = IP Header + Data
      │
      ▼
Data Link
Frame = MAC Header + Packet + FCS
      │
      ▼
Physical
Bits (0 و 1)
```

### شرح عربي

- **Layer 7-5:** يتم إنشاء البيانات.
- **Layer 4:** يضيف TCP أو UDP معلومات المنافذ (Ports).
- **Layer 3:** يضيف عنواني IP للمصدر والوجهة.
- **Layer 2:** يضيف عنواني MAC ويحسب قيمة FCS لاكتشاف الأخطاء.
- **Layer 1:** يحول كل ذلك إلى إشارات كهربائية أو ضوئية أو لاسلكية.

---

# 🔄 Decapsulation | فك التغليف

عند وصول البيانات للطرف الآخر، تتم العملية بالعكس:

1. Physical تستقبل الإشارات.
2. Data Link تتحقق من سلامة الـ Frame.
3. Network تقرأ عنوان IP.
4. Transport تعيد ترتيب البيانات عند الحاجة.
5. Application تعرض البيانات للمستخدم.

---

# 📦 PDU لكل طبقة

| الطبقة | اسم وحدة البيانات (PDU) |
|---------|--------------------------|
| Application | Data |
| Transport | Segment (TCP) / Datagram (UDP) |
| Network | Packet |
| Data Link | Frame |
| Physical | Bits |

💡 **سؤال مقابلة:** ما اسم الـ PDU في Layer 3؟  
الإجابة: **Packet**.

---

# 🔢 أشهر أرقام الـ Ports

| الخدمة | المنفذ |
|---------|-------:|
| HTTP | 80 |
| HTTPS | 443 |
| FTP | 21 |
| SSH | 22 |
| Telnet | 23 |
| SMTP | 25 |
| DNS | 53 |
| DHCP Server | 67 |
| DHCP Client | 68 |
| RDP | 3389 |

### من واقع العمل

إذا كان المستخدم لا يستطيع فتح Remote Desktop، تأكد أولًا أن المنفذ **3389** غير محجوب على الـ Firewall وأن الخدمة تعمل على الجهاز الهدف.

---

# 🧰 Mini Lab

## الهدف

التعرف على إعدادات الشبكة الحالية.

### على Windows

```powershell
ipconfig /all
ping 8.8.8.8
ping google.com
arp -a
tracert 8.8.8.8
netstat -ano
```

### المطلوب

- حدد عنوان IP.
- حدد Default Gateway.
- حدد DNS Server.
- اعرف هل DNS يعمل أم لا.
- اعرف أول Hop في مسار الاتصال.

---

# 📝 Chapter Summary

بعد هذا الفصل أصبحت تعرف:

- الفرق بين OSI وTCP/IP.
- وظيفة كل طبقة.
- TCP وUDP.
- ARP وICMP.
- IP وMAC Address.
- Encapsulation وDecapsulation.
- أشهر أرقام المنافذ.
- خطوات تشخيص أعطال الشبكات الأساسية.



---

# 🌍 IPv4 Subnet Mask & CIDR | شرح عربي مبسط

## ما هو Subnet Mask؟

الـ **Subnet Mask** هو الذي يحدد أي جزء من عنوان الـ IP يمثل **الشبكة (Network)** وأي جزء يمثل **الجهاز (Host)**.

### مثال

```
IP Address     : 192.168.10.25
Subnet Mask    : 255.255.255.0
CIDR Notation  : /24
```

في هذا المثال:

- Network ID = 192.168.10.0
- Host ID = 25
- Broadcast = 192.168.10.255

---

## لماذا نستخدم Subnet Mask؟

بدونه لن يعرف الجهاز:

- هل الجهاز الآخر داخل نفس الشبكة؟
- أم يجب إرسال البيانات إلى الـ Default Gateway؟

ولهذا فإن الـ Subnet Mask عنصر أساسي في أي اتصال شبكي.

---

# 🏢 مثال من شركة

لدينا قسمان:

## قسم المحاسبة

```
192.168.10.0/24
```

## قسم الموارد البشرية

```
192.168.20.0/24
```

كل قسم في شبكة مستقلة.

إذا أراد جهاز من المحاسبة التواصل مع الموارد البشرية، فسيتم إرسال البيانات إلى الـ Router أو Layer 3 Switch ليقوم بعملية Routing.

---

# 🔀 ما هو Routing؟

الـ Routing هو عملية اختيار أفضل مسار لإرسال البيانات بين شبكات مختلفة.

### من يقوم بها؟

- Router
- Layer 3 Switch
- Firewall (مثل FortiGate)

---

# 🛡️ Routing داخل الشركات

```
Accounting VLAN 10
        │
HR VLAN 20
        │
Sales VLAN 30
        │
     Core Switch
        │
    FortiGate
        │
     Internet
```

كل VLAN تعتبر شبكة مستقلة، ولا يمكنها التواصل مع الأخرى إلا عن طريق جهاز يقوم بالـ Routing.

---

# 🧩 VLAN مقدمة

## ما هي VLAN؟

هي تقسيم منطقي للشبكة الواحدة إلى عدة شبكات مستقلة.

### الفوائد

- تحسين الأمان.
- تقليل Broadcast.
- تنظيم الأقسام.
- تسهيل الإدارة.

### مثال

| VLAN | القسم |
|------|--------|
| 10 | Accounting |
| 20 | HR |
| 30 | IT |
| 40 | Management |
| 50 | Guest Wi-Fi |

---

# 💼 سيناريو عملي

إذا كان موظف في VLAN 10 لا يستطيع الوصول إلى سيرفر في VLAN 30:

افحص بالترتيب:

1. هل الجهاز حصل على IP صحيح؟
2. هل الـ Gateway صحيح؟
3. هل يوجد Route؟
4. هل توجد Firewall Policy تسمح بالاتصال؟
5. هل الـ VLAN مضافة على منفذ السويتش؟

---

# 🎓 Interview Questions

1. ما الفرق بين Network ID و Host ID؟
2. لماذا نستخدم Subnet Mask؟
3. ما وظيفة Default Gateway؟
4. ما هي VLAN؟
5. ما الفرق بين Switch Layer 2 و Layer 3 Switch؟
6. متى تحتاج إلى Routing؟

---

# 🚀 Next Chapter Preview

في الفصل القادم سيتم التعمق في:

- Ethernet Frames
- Switching
- MAC Address Table
- CAM Table
- VLAN Configuration
- Trunk Ports
- Access Ports
- STP (Spanning Tree Protocol)
- EtherChannel
- عمليًا على Cisco Packet Tracer



---

# 🔀 Ethernet Switching | شرح احترافي لعمل السويتش

## ما هو Switch؟

السويتش هو جهاز يعمل غالبًا في **Layer 2 (Data Link Layer)** ويقوم بربط الأجهزة داخل نفس الشبكة المحلية (LAN).

على عكس الـ Hub، فإن السويتش يرسل البيانات إلى الجهاز المطلوب فقط، مما يحسن الأداء ويقلل الازدحام.

---

## كيف يعرف السويتش مكان كل جهاز؟

يمتلك السويتش جدولًا يسمى:

- **MAC Address Table**
- أو **CAM Table**

يقوم بتسجيل:

| MAC Address | Port |
|-------------|------|
| AA-BB-CC-11-22-33 | Fa0/1 |
| DD-EE-FF-44-55-66 | Fa0/2 |

كلما استقبل Frame من جهاز، يتعلم عنوان الـ MAC الخاص به ويربطه بالمنفذ.

---

## رحلة Frame داخل السويتش

```
PC-A
  │
  ▼
Switch
  │
  ├── يتعلم MAC Address
  ├── يبحث في MAC Table
  └── يرسل Frame إلى المنفذ الصحيح
  │
  ▼
PC-B
```

### 💡 ماذا لو لم يجد MAC؟

يقوم السويتش بعملية **Flooding**.

أي يرسل الـ Frame إلى جميع المنافذ (عدا منفذ الدخول).

وعندما يرد الجهاز الهدف، يتعلم السويتش عنوانه ويضيفه إلى الجدول.

---

# 📚 أنواع الإرسال

## Unicast

إرسال من جهاز واحد إلى جهاز واحد.

مثال:
- فتح ملف من File Server.

---

## Broadcast

إرسال إلى جميع الأجهزة داخل نفس الشبكة.

أمثلة:
- ARP Request
- DHCP Discover

⚠️ الـ Broadcast لا يعبر الراوتر بشكل افتراضي.

---

## Multicast

إرسال إلى مجموعة محددة فقط.

يستخدم في:
- IPTV
- Video Streaming
- بعض تطبيقات المؤتمرات.

---

# 🔌 Access Port vs Trunk Port

## Access Port

- يحمل VLAN واحدة فقط.
- يستخدم لتوصيل:
  - أجهزة الكمبيوتر
  - الطابعات
  - الهواتف

## Trunk Port

يحمل أكثر من VLAN في نفس الوقت باستخدام IEEE 802.1Q.

يستخدم بين:
- Switch ↔ Switch
- Switch ↔ Firewall
- Switch ↔ Hypervisor

---

# 🌳 مقدمة عن STP

إذا تم توصيل سويتشين بأكثر من كابل، فقد يحدث **Loop** داخل الشبكة.

النتيجة:

- Broadcast Storm
- بطء شديد
- توقف الشبكة

لهذا يستخدم **Spanning Tree Protocol (STP)** لمنع الحلقات مع الاحتفاظ بمسارات احتياطية.

---

# 💼 Enterprise Scenario

شركة لديها ثلاثة سويتشات متصلة معًا.

أحد الفنيين أضاف كابلًا إضافيًا بين سويتشين دون إعداد مناسب.

بعد دقائق:

- الإنترنت توقف.
- الـ Ping أصبح متقطعًا.
- استخدام المعالج على السويتش ارتفع.

السبب: Layer 2 Loop.

الحل:
- تفعيل STP.
- إزالة الوصلة الخاطئة.
- مراجعة تصميم الشبكة.

---

# 🧪 Mini Lab

## على Cisco Packet Tracer

1. أضف Switch و3 أجهزة PC.
2. اربط الأجهزة بكابلات Straight-Through.
3. أعطِ كل جهاز IP من نفس الشبكة.
4. نفذ Ping بين الأجهزة.
5. راقب تعلم السويتش لعناوين MAC باستخدام:

```text
show mac address-table
```

---

# 🎓 Interview Questions

1. ما الفرق بين Hub وSwitch؟
2. لماذا يعتبر السويتش أكثر كفاءة؟
3. ما وظيفة MAC Address Table؟
4. متى يحدث Flooding؟
5. ما الفرق بين Access Port وTrunk Port؟
6. ما وظيفة STP؟
7. لماذا لا يعبر Broadcast الراوتر؟



---

# 🌐 Network Troubleshooting Methodology | منهجية احترافية لاستكشاف أعطال الشبكات

## لا تبدأ بالتخمين

أحد أكبر الأخطاء التي يقع فيها المبتدئون هو تغيير إعدادات الشبكة أو الـ Firewall قبل تحديد مكان المشكلة.

المهندس المحترف يبدأ دائمًا بجمع المعلومات ثم يفحص طبقات الشبكة بالتسلسل.

---

# 🔍 خطوات استكشاف الأعطال

## الخطوة 1: تحديد المشكلة

اسأل المستخدم:

- هل المشكلة في جهاز واحد أم جميع الأجهزة؟
- هل المشكلة في الإنترنت فقط أم الشبكة الداخلية أيضًا؟
- متى بدأت المشكلة؟
- هل تم تغيير أي إعدادات؟

---

## الخطوة 2: فحص Layer 1

تحقق من:

- كابل الشبكة.
- لمبة Link.
- منفذ السويتش.
- كارت الشبكة.
- الواي فاي إن وجد.

أوامر مفيدة:

```powershell
Get-NetAdapter
```

---

## الخطوة 3: فحص Layer 2

- هل يوجد MAC Address؟
- هل المنفذ في VLAN الصحيحة؟
- هل المنفذ Up؟

على Cisco:

```text
show interfaces status
show mac address-table
show vlan brief
```

---

## الخطوة 4: فحص Layer 3

```cmd
ipconfig /all
ping <gateway>
route print
```

تأكد من:

- IP Address
- Subnet Mask
- Default Gateway
- DNS

---

## الخطوة 5: اختبار DNS

```cmd
ping 8.8.8.8
ping google.com
nslookup google.com
```

إذا نجح Ping على 8.8.8.8 وفشل على google.com فالمشكلة غالبًا في DNS.

---

## الخطوة 6: اختبار المنافذ

```powershell
Test-NetConnection google.com -Port 443
```

يمكن استخدامه لمعرفة هل المنفذ مفتوح ويمكن الوصول إليه.

---

# 🧰 جدول سريع للأوامر

| الأمر | الاستخدام |
|--------|-----------|
| ipconfig /all | عرض إعدادات الشبكة |
| ping | اختبار الاتصال |
| tracert | تتبع المسار |
| arp -a | عرض ARP Cache |
| nslookup | اختبار DNS |
| netstat -ano | الاتصالات الحالية |
| route print | جدول التوجيه |

---

# 💼 سيناريو عملي

**المشكلة:** موظف لا يستطيع فتح Outlook.

### خطوات التشخيص

1. تأكد من اتصال الشبكة.
2. Ping على الـ Gateway.
3. Ping على DNS.
4. nslookup لاسم خادم البريد.
5. Test-NetConnection على المنفذ المطلوب (مثل 443 أو 587 حسب الخدمة).
6. راجع سياسات الـ Firewall.
7. راجع سجلات Outlook إذا استمرت المشكلة.

---

# 🧠 أفضل الممارسات

- لا تغيّر أكثر من إعداد في نفس الوقت.
- وثّق كل تغيير تقوم به.
- احتفظ بنسخة احتياطية من إعدادات الأجهزة.
- ابدأ دائمًا بالأسباب البسيطة قبل المعقدة.
- استخدم أوامر التشخيص قبل إعادة تشغيل الأجهزة.

---

# 📋 Checklist قبل تصعيد المشكلة

- [ ] الكابل سليم.
- [ ] المنفذ Up.
- [ ] عنوان IP صحيح.
- [ ] Gateway صحيح.
- [ ] DNS يعمل.
- [ ] Ping ناجح.
- [ ] لا توجد سياسة Firewall تمنع الاتصال.
- [ ] تم توثيق جميع خطوات الفحص.



---

# 🔥 Firewall Fundamentals | أساسيات جدار الحماية

## ما هو الـ Firewall؟

الـ **Firewall** هو جهاز أو برنامج يقوم بمراقبة حركة البيانات الداخلة والخارجة ويقرر السماح بها أو منعها وفقًا لسياسات (Policies) محددة.

### تشبيه بسيط

تخيل أن شركتك عبارة عن مبنى.

- الباب الرئيسي = Firewall
- الموظفون = Users
- الزوار = Internet Traffic
- رجل الأمن = Firewall Policy

لا يدخل أي شخص إلا بعد التحقق من القواعد الموضوعة.

---

## لماذا نحتاج Firewall؟

- حماية الشبكة من الهجمات.
- منع الوصول غير المصرح به.
- التحكم في استخدام الإنترنت.
- إنشاء VPN.
- تسجيل الأحداث (Logs).
- فلترة المواقع والتطبيقات.

---

# 🧭 كيف يقرر الـ Firewall السماح أو المنع؟

يمر كل اتصال بعدة خطوات:

1. يقرأ عنوان IP للمصدر.
2. يقرأ عنوان IP للوجهة.
3. يحدد البروتوكول (TCP/UDP).
4. يحدد رقم المنفذ (Port).
5. يقارن الاتصال بالسياسات الموجودة.
6. أول Policy مطابقة يتم تطبيقها.

> **قاعدة ذهبية:** ترتيب الـ Policies مهم جدًا، لأن أول قاعدة تطابق الاتصال هي التي تُنفذ.

---

# 🛡️ Stateful vs Stateless Firewall

| Stateful | Stateless |
|----------|-----------|
| يتتبع حالة الاتصال | يفحص كل Packet منفصلة |
| أكثر أمانًا | أسرع في بعض السيناريوهات |
| الأكثر استخدامًا في الشركات | أقل شيوعًا |

---

# 🌐 NAT (Network Address Translation)

## لماذا نحتاج NAT؟

معظم الأجهزة داخل الشركات تستخدم **Private IP** ولا يمكنها الوصول إلى الإنترنت مباشرة.

يقوم الـ Firewall أو Router بتحويل العنوان الداخلي إلى **Public IP**.

### مثال

قبل NAT:

```
192.168.10.25
```

بعد NAT:

```
102.x.x.x
```

وهكذا يستطيع الجهاز الوصول إلى الإنترنت.

---

# 💼 مثال من بيئة العمل

شركة بها:

- 250 جهاز كمبيوتر
- Public IP واحد فقط من مزود الخدمة

كيف يخرج الجميع إلى الإنترنت؟

الإجابة:

باستخدام **PAT (Port Address Translation)** حيث يشترك الجميع في Public IP واحد مع استخدام أرقام منافذ مختلفة.

---

# 🚨 سيناريو Troubleshooting

المستخدم يستطيع:

✅ Ping على Gateway

✅ الوصول إلى السيرفرات الداخلية

❌ لا يستطيع فتح أي موقع على الإنترنت

ابدأ بالتحقق من:

- Default Route
- NAT Policy
- Firewall Policy
- DNS
- WAN Interface Status

---

# 🎓 Interview Questions

1. ما الفرق بين Firewall وRouter؟
2. ما الفرق بين Stateful وStateless Firewall؟
3. ما هو NAT؟
4. ما هو PAT؟
5. لماذا يكون ترتيب الـ Firewall Policies مهمًا؟
6. ما الفرق بين Allow وDeny Rule؟



---

# 🌍 Internet Journey | رحلة البيانات من جهازك إلى الإنترنت

## ماذا يحدث عند كتابة www.google.com؟

يعتقد الكثير أن الصفحة تفتح مباشرة، لكن في الحقيقة تمر البيانات بعدة مراحل.

```
PC
 │
 ▼
Switch
 │
 ▼
Default Gateway
 │
 ▼
Firewall
 │
 ▼
ISP
 │
 ▼
DNS Server
 │
 ▼
Google Servers
 │
 ▼
الاستجابة تعود بنفس المسار
```

---

## المرحلة الأولى: فحص الشبكة المحلية

يقارن الجهاز بين عنوانه وعنوان الوجهة باستخدام:

- IP Address
- Subnet Mask

إذا كانت الوجهة خارج الشبكة المحلية، يرسل البيانات إلى:

**Default Gateway**

---

## المرحلة الثانية: الحصول على عنوان MAC

إذا لم يكن عنوان MAC الخاص بالـ Gateway معروفًا، يرسل الجهاز:

```
ARP Request
```

فيرد الـ Gateway برسالة:

```
ARP Reply
```

ثم يحفظ النتيجة في ARP Cache.

---

## المرحلة الثالثة: DNS Resolution

المستخدم كتب:

```
www.google.com
```

لكن الشبكة تتعامل مع:

```
142.250.x.x
```

لذلك يستعلم الجهاز أولًا من خادم DNS للحصول على عنوان IP.

---

## المرحلة الرابعة: إنشاء اتصال TCP

إذا كانت الخدمة تستخدم HTTPS:

1. TCP Three-Way Handshake
2. TLS Handshake
3. تبادل البيانات المشفرة

---

## المرحلة الخامسة: المرور عبر Firewall

يقوم الـ Firewall بفحص:

- Source IP
- Destination IP
- Protocol
- Port
- Security Policy
- NAT

إذا كانت القواعد تسمح، يمر الاتصال إلى الإنترنت.

---

## المرحلة السادسة: الوصول إلى الخادم

يستقبل خادم Google الطلب ثم يرسل:

- HTML
- CSS
- JavaScript
- Images
- Fonts

ليبدأ المتصفح في عرض الصفحة.

---

# 🔐 مقدمة عن TLS وHTTPS

## HTTP

- غير مشفر.
- يستخدم المنفذ 80.

## HTTPS

- مشفر باستخدام TLS.
- يستخدم المنفذ 443.

### لماذا هو مهم؟

يحمي:

- كلمات المرور.
- بيانات البطاقات البنكية.
- البريد الإلكتروني.
- البيانات الحساسة.

---

# 📦 Packet Capture

أثناء هذه الرحلة يمكن استخدام أدوات مثل:

- Wireshark
- tcpdump
- Microsoft Message Analyzer (قديم)

لمشاهدة كل Packet تمر داخل الشبكة.

---

# 💼 Enterprise Case Study

**المشكلة:**

المستخدم يستطيع فتح المواقع الداخلية، لكن المواقع الخارجية لا تعمل.

### خطوات التحليل

- Ping على Gateway ✔
- Ping على Public IP ✔
- DNS Lookup ✖

الاستنتاج:

المشكلة في DNS وليست في الإنترنت.

---

# 🧪 Hands-on Lab

نفذ الأوامر التالية:

```cmd
ipconfig /all
arp -a
nslookup www.google.com
ping 8.8.8.8
ping google.com
tracert google.com
```

ثم أجب:

1. ما عنوان الـ DNS؟
2. كم عدد الـ Hops؟
3. هل يعمل ARP؟
4. هل المشكلة في Layer 2 أم Layer 3 أم DNS؟

---

# 🏁 Chapter Wrap-up

في هذا الفصل تعلمت:

- رحلة البيانات داخل الشبكة.
- دور DNS.
- دور ARP.
- دور Default Gateway.
- دور Firewall.
- NAT.
- HTTPS وTLS.
- خطوات تحليل الاتصال حتى الوصول إلى خادم الإنترنت.



---

# 🔬 Wireshark Fundamentals | أساسيات تحليل الشبكات

## ما هو Wireshark؟

Wireshark هو أشهر برنامج في العالم لتحليل حركة الشبكات (Packet Analyzer).

يستخدمه:

- Network Engineers
- Security Engineers
- SOC Analysts
- System Administrators
- Incident Response Teams

---

# 🧱 مكونات الـ Packet

عند التقاط أي Packet ستجدها غالبًا بهذا الترتيب:

```
Ethernet Header
        │
        ▼
IP Header
        │
        ▼
TCP / UDP Header
        │
        ▼
Application Data
```

كل طبقة تضيف معلومات تساعد الأجهزة على فهم البيانات.

---

# 📦 مثال عملي

عند فتح:

```
https://www.google.com
```

قد ترى التسلسل التالي داخل Wireshark:

1. ARP Request
2. ARP Reply
3. DNS Query
4. DNS Response
5. TCP SYN
6. TCP SYN-ACK
7. TCP ACK
8. TLS Handshake
9. HTTP GET (داخل TLS)
10. Server Response

هذا التسلسل يعتبر من أهم ما يجب أن يفهمه أي مهندس شبكات.

---

# 🎯 أشهر الفلاتر (Display Filters)

| Filter | الاستخدام |
|---------|-----------|
| arp | عرض ARP فقط |
| dns | عرض DNS |
| tcp | عرض TCP |
| udp | عرض UDP |
| icmp | عرض Ping |
| http | عرض HTTP |
| tls | عرض TLS |
| ip.addr == 192.168.1.10 | فلترة عنوان IP |
| tcp.port == 443 | فلترة منفذ معين |

---

# 🔍 كيف تقرأ Packet؟

## Ethernet

يعرض:

- Source MAC
- Destination MAC
- EtherType

---

## IP

يعرض:

- Source IP
- Destination IP
- TTL
- Protocol

---

## TCP

يعرض:

- Source Port
- Destination Port
- Sequence Number
- Acknowledgment Number
- Flags (SYN / ACK / FIN / RST)

---

# 🚩 أشهر TCP Flags

| Flag | المعنى |
|------|---------|
| SYN | بدء الاتصال |
| ACK | تأكيد الاستلام |
| FIN | إنهاء الاتصال |
| RST | إعادة ضبط الاتصال |
| PSH | دفع البيانات للتطبيق |

---

# 💼 Enterprise Scenario

المستخدم يشكو من بطء تطبيق داخلي.

بعد التقاط الترافيك لاحظت:

- DNS سريع.
- TCP Handshake ناجح.
- إعادة إرسال TCP (TCP Retransmissions) كثيرة.

الاستنتاج المحتمل:

- ازدحام بالشبكة.
- Packet Loss.
- مشكلة في الكابل أو السويتش.
- حمل مرتفع على الخادم.

---

# 🧪 Wireshark Lab

## الهدف

تحليل فتح موقع ويب.

### الخطوات

1. افتح Wireshark.
2. اختر كارت الشبكة الصحيح.
3. Start Capture.
4. افتح https://example.com
5. Stop Capture.

### ابحث عن:

- أول ARP.
- DNS Query.
- TCP Handshake.
- TLS Handshake.
- أول Packet تحمل بيانات.

---

# 🎓 Interview Questions

1. ما وظيفة Wireshark؟
2. ما الفرق بين Capture Filter وDisplay Filter؟
3. كيف تميز TCP Handshake؟
4. ما وظيفة ARP داخل الالتقاط؟
5. ماذا يعني TCP Retransmission؟
6. ما المقصود بـ Packet Capture؟



---


# 🖥️ الشكل العام لمركز البيانات

```
                Internet
                    │
              Edge Router
                    │
             Firewall Cluster
                    │
            Core Switch Stack
             ┌─────────────┐
             │             │
      VMware Cluster   Storage Network
             │             │
          Virtual Machines  SAN/NAS
```

---

# 🗄️ Rack

معظم الأجهزة تُركب داخل Rack قياسي بقياس **19 بوصة**.

قياس الارتفاع يكون بوحدة:

```
1U = 1.75 inch
```

أمثلة:

| الجهاز | الحجم |
|---------|-------|
| Firewall | 1U |
| Switch | 1U |
| Dell PowerEdge Server | 2U |
| Storage Array | 2U - 4U |

---

# ⚡ الطاقة داخل الـ Data Center

يجب ألا يعتمد مركز البيانات على مصدر كهرباء واحد.

لذلك يتم استخدام:

- UPS
- مولد كهربائي (Generator)
- Dual Power Supply
- وحدات توزيع الطاقة (PDU)

### الهدف

استمرار تشغيل الخدمات حتى أثناء انقطاع الكهرباء.

---

# ❄️ أنظمة التبريد

الخوادم تولد حرارة مرتفعة.

لذلك يتم استخدام:

- Precision Air Conditioning
- Hot Aisle / Cold Aisle
- مراقبة درجة الحرارة والرطوبة

ارتفاع الحرارة قد يؤدي إلى:

- بطء الأداء
- إعادة تشغيل الأجهزة
- تلف المكونات

---

# 💾 Storage

## NAS

يقدم ملفات مشتركة عبر الشبكة.

أمثلة الاستخدام:

- File Server
- النسخ الاحتياطي
- مشاركة الملفات

## SAN

يوفر أقراصًا مباشرة للخوادم بسرعة عالية.

يستخدم غالبًا مع:

- VMware
- Hyper-V
- قواعد البيانات

---

# 🖥️ Virtualization

بدل تشغيل تطبيق على Server مستقل لكل خدمة، يتم تشغيل عدة خوادم افتراضية على جهاز قوي واحد.

أشهر المنصات:

- VMware ESXi
- Microsoft Hyper-V
- Proxmox VE

### المزايا

- تقليل التكلفة
- سهولة النسخ الاحتياطي
- سرعة إنشاء الخوادم
- استغلال أفضل للموارد

---

# 💼 Enterprise Case Study

شركة لديها:

- Domain Controller
- File Server
- SQL Server
- ERP Server

بدل شراء أربعة أجهزة منفصلة، تم إنشاء أربع Virtual Machines على خادمين داخل VMware Cluster مع تخزين مشترك وHA.

النتيجة:

- تقليل التكلفة.
- زيادة الاعتمادية.
- سهولة الإدارة.

---

# 🧪 Hands-on Lab

إذا كان لديك VMware Workstation أو Hyper-V:

1. أنشئ Virtual Machine.
2. ثبّت Windows Server.
3. أضف كارتَي شبكة.
4. جرّب Snapshot.
5. جرّب استعادة Snapshot.

---

# 🎓 Interview Questions

1. ما الفرق بين NAS وSAN؟
2. ما المقصود بـ Rack؟
3. ما فائدة UPS؟
4. لماذا نستخدم Virtualization؟
5. ما الفرق بين VMware ESXi وHyper-V؟
6. ما المقصود بـ High Availability داخل الـ Data Center؟
