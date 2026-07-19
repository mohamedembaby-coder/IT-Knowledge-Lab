# OSI Model

> Category: 01-Networking / 02-OSI-Model

---

# 📖 Overview | نظرة عامة

## English

The OSI (Open Systems Interconnection) Model is a conceptual framework that explains how data moves between devices across a network. It divides network communication into seven layers, each responsible for a specific function.

Although modern networks primarily use the TCP/IP model, the OSI model remains the industry standard for learning, designing, and troubleshooting computer networks.

Understanding the OSI Model makes it much easier to identify where network problems occur and how different protocols interact.

## العربية

يُعد نموذج **OSI (Open Systems Interconnection)** أحد أهم النماذج المستخدمة لفهم كيفية انتقال البيانات بين الأجهزة عبر الشبكات.

يقسم النموذج عملية الاتصال إلى **سبع طبقات**، بحيث تكون كل طبقة مسؤولة عن وظيفة محددة، مما يسهل تصميم الشبكات واستكشاف الأعطال وفهم البروتوكولات المختلفة.

ورغم أن الإنترنت يعتمد عمليًا على نموذج **TCP/IP**، فإن نموذج OSI لا يزال المرجع الأساسي لتعلم الشبكات ودراسة CCNA والعمل في بيئات الشركات.

---

# 💡 Why Learn the OSI Model? | لماذا نتعلم OSI؟

## English

Although real-world networks use the TCP/IP model, the OSI Model provides a common language for understanding, designing, and troubleshooting networks.

Most networking certifications, including CCNA, Network+, and many enterprise training programs, use the OSI model to explain how network communication works.

---

## العربية

رغم أن الشبكات الحديثة تعتمد عمليًا على TCP/IP، فإن نموذج OSI يُستخدم عالميًا كمرجع لفهم الشبكات وتصميمها واستكشاف أعطالها.

يعتمد عليه معظم مهندسي الشبكات عند تحليل المشكلات لأنه يقسم عملية الاتصال إلى طبقات واضحة.

---


# 📌 Prerequisites | المتطلبات

Before studying this module, you should understand:

- Networking Fundamentals
- Basic Network Devices
- IP Address basics
- Basic Network Communication

---

بعد دراسة هذا الفصل ستكون مستعدًا لدراسة:

- TCP/IP Model
- Ethernet Switching
- Routing
- Network Troubleshooting

---

# 🎯 Objectives | الأهداف

After completing this module, you will be able to:

- Explain the purpose of the OSI Model.
- Describe the responsibilities of each OSI layer.
- Identify common protocols at every layer.
- Understand Protocol Data Units (PDUs).
- Explain Encapsulation and Decapsulation.
- Compare the OSI Model with the TCP/IP Model.
- Troubleshoot network problems using the OSI approach.

---

# 🗺️ Learning Path | مسار التعلم

```text
Networking Fundamentals
        ↓
OSI Model
        ↓
TCP/IP Model
        ↓
Ethernet Switching
        ↓
Routing
        ↓
Network Services
```

---

# 📚 Theory | نظرة عامة

The OSI Model consists of seven layers:

| Layer | Name | Primary Function |
|------:|----------------|-----------------------------|
| 7 | Application | User-facing network services |
| 6 | Presentation | Encryption, Compression |
| 5 | Session | Session establishment and management |
| 4 | Transport | Reliable communication (TCP/UDP) |
| 3 | Network | Logical addressing and Routing |
| 2 | Data Link | Frames and MAC Addresses |
| 1 | Physical | Transmission of Bits |

---

## لماذا يعتبر OSI مهمًا؟

يساعد نموذج OSI على:

- تقسيم عملية الاتصال إلى مراحل واضحة.
- تسهيل فهم البروتوكولات.
- تسهيل اكتشاف الأعطال.
- تحسين تصميم الشبكات.
- توفير لغة مشتركة بين مهندسي الشبكات.

---

## Example

If a user cannot open a website:

- Layer 1 → Cable problem?
- Layer 2 → Switch problem?
- Layer 3 → IP or Routing problem?
- Layer 4 → Port blocked?
- Layer 7 → Application problem?

Using the OSI model helps engineers isolate the exact layer where the failure occurs.

---

## 🏢 Enterprise Scenario

An employee reports that Outlook cannot connect.

Instead of guessing, an IT engineer analyzes the problem layer by layer:

- Layer 1 → Is the cable connected?
- Layer 2 → Is the switch port active?
- Layer 3 → Does the PC have a valid IP address?
- Layer 4 → Is the required port open?
- Layer 7 → Is the mail server running?

Using the OSI Model reduces troubleshooting time and helps identify the root cause efficiently.

---



## Common Protocols by Layer

| Layer | Examples | Common Devices |
|--------|----------|----------------|
| 7 | HTTP, HTTPS, FTP, SMTP, DNS | PC, Server |
| 6 | TLS, SSL, JPEG, MPEG | Gateway |
| 5 | NetBIOS, RPC | Gateway |
| 4 | TCP, UDP | Firewall |
| 3 | IP, ICMP, IPSec | Router |
| 2 | Ethernet, PPP, ARP | Switch |
| 1 | UTP, Fiber, Radio Signals | Hub, Repeater, Cable |

---



# 🖼️ Diagrams

Store diagrams inside:

```
diagrams/
```

Suggested diagrams:

- Complete OSI Model
- Encapsulation
- Decapsulation
- OSI vs TCP/IP Comparison

---

# 💻 Labs

Store practical labs inside:

```
labs/
```

See:

```
lab-guide.md
```

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

## Official Documentation

- Cisco Networking Academy
- Microsoft Learn
- RFC Documentation

## Recommended Books

- CCNA 200-301 Official Cert Guide
- TCP/IP Illustrated
- Computer Networking: A Top-Down Approach

---

# ✅ Chapter Summary

After completing this module, you should understand:

- The purpose of the OSI Model.
- All seven OSI layers.
- Layer responsibilities.
- Common protocols.
- Encapsulation and Decapsulation.
- Protocol Data Units (PDUs).
- Basic troubleshooting using the OSI approach.

---

# 🚀 Next Module

# 03-TCP-IP-Model

The next chapter is:

**03-TCP-IP-Model**

Topics include:

- TCP/IP Architecture
- Layer Mapping
- Internet Protocol Suite
- TCP vs UDP
- Real-world implementation