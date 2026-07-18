# 📋 Networking Fundamentals Cheat Sheet

> **Quick Reference for Networking Fundamentals**
>
> A compact guide containing the most important networking commands, protocols, ports, OSI model, IP addressing, and troubleshooting tips.

---

# 🌐 Network Types

| Type | Full Name | Coverage | Example |
|------|-----------|----------|---------|
| PAN | Personal Area Network | Few meters | Bluetooth |
| LAN | Local Area Network | Home / Office | Company Network |
| MAN | Metropolitan Area Network | City | ISP City Network |
| WAN | Wide Area Network | Country / Worldwide | Internet |

---

# 🏗️ OSI Model

| Layer | Name | Examples |
|------:|------|----------|
| 7 | Application | HTTP, FTP, SMTP, DNS |
| 6 | Presentation | SSL/TLS, Encryption |
| 5 | Session | NetBIOS |
| 4 | Transport | TCP, UDP |
| 3 | Network | IP, ICMP |
| 2 | Data Link | Ethernet, MAC |
| 1 | Physical | Cable, Fiber, Wireless |

### Easy to Remember

```
7 Application
6 Presentation
5 Session
4 Transport
3 Network
2 Data Link
1 Physical
```

---

# 🌍 TCP/IP Model

| Layer | Protocols |
|---------|-----------|
| Application | HTTP, HTTPS, FTP, DNS, SMTP |
| Transport | TCP, UDP |
| Internet | IP, ICMP |
| Network Access | Ethernet, Wi-Fi |

---

# 🔌 Common Ports

| Port | Protocol | Service |
|------:|----------|----------|
| 20/21 | TCP | FTP |
| 22 | TCP | SSH |
| 23 | TCP | Telnet |
| 25 | TCP | SMTP |
| 53 | TCP/UDP | DNS |
| 67 | UDP | DHCP Server |
| 68 | UDP | DHCP Client |
| 80 | TCP | HTTP |
| 110 | TCP | POP3 |
| 143 | TCP | IMAP |
| 161 | UDP | SNMP |
| 389 | TCP/UDP | LDAP |
| 443 | TCP | HTTPS |
| 445 | TCP | SMB |
| 3389 | TCP | RDP |

---

# 📦 Common Protocols

| Protocol | Purpose |
|-----------|---------|
| HTTP | Web Browsing |
| HTTPS | Secure Web Browsing |
| FTP | File Transfer |
| SSH | Secure Remote Access |
| Telnet | Remote Access |
| DNS | Name Resolution |
| DHCP | Automatic IP Assignment |
| ICMP | Connectivity Testing |
| ARP | IP to MAC Resolution |
| SMTP | Send Email |
| POP3 | Receive Email |
| IMAP | Synchronize Email |

---

# 🖥️ Network Devices

| Device | Function |
|---------|----------|
| Hub | Broadcasts traffic to all devices |
| Switch | Forwards traffic using MAC Address |
| Router | Connects different networks |
| Firewall | Filters network traffic |
| Access Point | Provides Wireless Access |
| Modem | Connects to ISP |

---

# 🌐 Private IPv4 Address Ranges

| Network | CIDR |
|----------|------|
| 10.0.0.0 | /8 |
| 172.16.0.0 – 172.31.255.255 | /12 |
| 192.168.0.0 | /16 |

---

# 📍 IPv4 Classes

| Class | Range | Default Mask |
|------|--------|--------------|
| A | 1 – 126 | 255.0.0.0 |
| B | 128 – 191 | 255.255.0.0 |
| C | 192 – 223 | 255.255.255.0 |
| D | 224 – 239 | Multicast |
| E | 240 – 255 | Experimental |

---

# ⚡ TCP vs UDP

| Feature | TCP | UDP |
|---------|-----|-----|
| Connection | ✅ | ❌ |
| Reliable | ✅ | ❌ |
| Ordered Delivery | ✅ | ❌ |
| Fast | ❌ | ✅ |
| Error Recovery | ✅ | ❌ |

---

# 💻 Essential Networking Commands

## Windows

| Command | Description |
|----------|-------------|
| ipconfig | Display IP configuration |
| ipconfig /all | Detailed IP configuration |
| ping | Test connectivity |
| tracert | Trace network route |
| pathping | Analyze route and packet loss |
| arp -a | Show ARP Table |
| netstat -an | Active connections |
| nslookup | DNS Lookup |
| hostname | Show Computer Name |
| getmac | Show MAC Address |
| netsh | Configure Network Settings |

---

## Linux

| Command | Description |
|----------|-------------|
| ip addr | Show IP Address |
| ifconfig | Interface Configuration |
| ping | Test Connectivity |
| traceroute | Trace Route |
| arp | Show ARP Table |
| netstat | Active Connections |
| ss | Socket Statistics |
| dig | Advanced DNS Lookup |
| nslookup | DNS Lookup |

---

# 🔧 Common Cable Types

| Cable | Use |
|--------|-----|
| Straight Through | PC ↔ Switch |
| Crossover | Switch ↔ Switch / PC ↔ PC |
| Fiber Single Mode | Long Distance |
| Fiber Multi Mode | Short Distance |

---

# 🛠️ Basic Troubleshooting Workflow

```text
Check Cable
      ↓
Check Link LED
      ↓
Check IP Address
      ↓
Ping 127.0.0.1
      ↓
Ping Local IP
      ↓
Ping Default Gateway
      ↓
Ping External IP
      ↓
Test DNS
      ↓
Check Firewall
```

---

# 📖 Common Acronyms

| Acronym | Meaning |
|----------|---------|
| IP | Internet Protocol |
| TCP | Transmission Control Protocol |
| UDP | User Datagram Protocol |
| DNS | Domain Name System |
| DHCP | Dynamic Host Configuration Protocol |
| NAT | Network Address Translation |
| MAC | Media Access Control |
| LAN | Local Area Network |
| WAN | Wide Area Network |
| VPN | Virtual Private Network |
| VLAN | Virtual Local Area Network |
| ISP | Internet Service Provider |

---

# ✅ Quick Facts

- Every device needs a unique IP Address.
- MAC Address is burned into the Network Interface Card (NIC).
- Switches work with MAC Addresses.
- Routers work with IP Addresses.
- DNS translates names into IP addresses.
- DHCP automatically assigns IP addresses.
- TCP is reliable.
- UDP is faster.
- Firewalls protect networks by filtering traffic.
- Private IP addresses cannot be routed directly over the Internet.

---

> **💡 Tip:** Keep this file as your quick reference during labs, troubleshooting, interviews, and daily IT operations.