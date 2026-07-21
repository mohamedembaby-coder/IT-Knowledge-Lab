# OSI Model Lab Guide - Part 1

## Introduction
This guide contains the practical labs for the OSI Model.

## Required Software
- Cisco Packet Tracer
- Wireshark
- Windows CMD
- PowerShell
- Web Browser

---

# Lab 1 - Exploring the OSI Model

## Objective
Understand how data travels through all seven OSI layers.

## Steps
1. Open https://example.com
2. Draw the seven OSI layers.
3. Explain Encapsulation and Decapsulation.

---

# Lab 2 - Ping & ICMP

```cmd
ping 8.8.8.8
ping google.com
```

Tasks:
- Compare latency.
- Observe TTL.
- Disconnect the network and test again.

---

# Lab 3 - DNS Resolution

```cmd
nslookup google.com
nslookup microsoft.com
```

Record the returned IP addresses.

---

# Lab 4 - HTTP vs HTTPS

Visit:
- http://neverssl.com
- https://google.com

Capture traffic with Wireshark and compare.

---

# Lab 5 - TCP Three-Way Handshake

Wireshark filter:

```text
tcp
```

Open https://example.com and identify:
- SYN
- SYN/ACK
- ACK

---

# Lab 6 - UDP

Wireshark filter:

```text
udp
```

Play a YouTube video and observe UDP packets.

---

# Lab 7 - Common Ports

```cmd
netstat -ano
```

Identify ports:
- 53
- 80
- 443
- 445
- 3389

---

# Lab 8 - Netstat

```cmd
netstat -a
netstat -an
netstat -ano
netstat -b
```

---

# Lab 9 - Tracert

```cmd
tracert google.com
```

Explain every hop.

---

# Lab 10 - PathPing

```cmd
pathping google.com
```

Compare with tracert.

---

# Lab 11 - ipconfig

```cmd
ipconfig
ipconfig /all
```

Find:
- IPv4
- Gateway
- DNS
- MAC Address

---

# Lab 12 - Basic Troubleshooting

Run:

```cmd
ipconfig
ping 127.0.0.1
ping localhost
ping <Default Gateway>
ping 8.8.8.8
ping google.com
```

Determine where connectivity fails.

---

## Next Part
- Binary
- IPv4
- Classes
- Subnet Mask
- CIDR
- Subnetting
- Magic Number
- VLSM
- FLSM
- Route Summarization


---

# OSI Model Lab Guide - Part 2
# IPv4, Binary, Subnetting & VLSM Labs

# Lab 13 – Binary Conversion

## Objective
Convert decimal numbers to binary and back.

## Exercises
| Decimal | Binary |
|---:|:---|
|10|________|
|25|________|
|64|________|
|128|________|
|192|________|
|255|________|

---

# Lab 14 – Binary to Decimal

Convert:

```
00001010
11000000
11111111
10000000
```

---

# Lab 15 – IPv4 Classes

Identify the class of each address:

- 10.0.0.1
- 172.16.10.5
- 192.168.1.1
- 8.8.8.8
- 224.0.0.5

---

# Lab 16 – Private vs Public IP

Mark each address as Private or Public.

- 192.168.10.10
- 172.31.10.5
- 172.50.1.1
- 10.1.1.1
- 1.1.1.1

---

# Lab 17 – Subnet Masks

Match each prefix:

- /8
- /16
- /24
- /25
- /26
- /27
- /28
- /29
- /30

---

# Lab 18 – CIDR Practice

Write the subnet mask for:

- /20
- /21
- /22
- /23
- /24
- /27
- /30

---

# Lab 19 – Easy Subnetting

Network: 192.168.1.0/24

Find:

- Network Address
- First Host
- Last Host
- Broadcast
- Number of Hosts

Repeat for:

- 192.168.10.0/26
- 192.168.20.0/27
- 10.0.0.0/30

---

# Lab 20 – Magic Number

Calculate the magic number for:

- /25
- /26
- /27
- /28
- /29
- /30

---

# Lab 21 – FLSM

Split 192.168.100.0/24 into:

- 2 subnets
- 4 subnets
- 8 subnets
- 16 subnets

Document every subnet.

---

# Lab 22 – VLSM

Company Requirements:

- HR = 50 Hosts
- Finance = 25 Hosts
- IT = 12 Hosts
- Servers = 6 Hosts

Use network:

192.168.10.0/24

Create an efficient VLSM plan.

---

# Lab 23 – Route Summarization

Summarize:

- 192.168.0.0/24
- 192.168.1.0/24
- 192.168.2.0/24
- 192.168.3.0/24

Repeat with additional address groups.

---

# Lab 24 – Enterprise Scenario

A company has exhausted IP addresses.

Tasks:

1. Identify the cause.
2. Recommend VLSM.
3. Reduce address waste.
4. Produce a new addressing plan.

---

# Challenge Section

1. Design a network for 100 users.
2. Design a network for 4 branches.
3. Build the topology in Packet Tracer.
4. Verify connectivity.
5. Document the addressing table.

---

# CCNA Review Checklist

- Binary
- IPv4
- Classes
- Private/Public
- Subnet Masks
- CIDR
- Subnetting
- Magic Number
- FLSM
- VLSM
- Route Summarization



---

# OSI Model Lab Guide - Part 3
# Layer 2 Labs (Data Link Layer)

## Lab 25 – View Your MAC Address

### Objective
Identify the MAC address of your network adapter.

### Commands
```cmd
ipconfig /all
getmac
```

### Tasks
- Record the Physical Address.
- Compare wired and wireless adapters.

---

## Lab 26 – ARP Cache

### Commands
```cmd
arp -a
arp -d *
ping 8.8.8.8
arp -a
```

### Tasks
- Observe ARP entries before and after pinging.
- Explain why new entries appear.

---

## Lab 27 – Ethernet Frame Analysis

### Tool
Wireshark

### Filter
```text
eth
```

### Tasks
- Capture traffic.
- Locate Source MAC.
- Locate Destination MAC.
- Identify EtherType.

---

## Lab 28 – Switch MAC Address Table

### Cisco IOS
```text
show mac address-table
```

### Tasks
- Connect two PCs.
- Generate traffic.
- Observe learned MAC addresses.

---

## Lab 29 – VLAN Basics

### Objective
Create two VLANs.

### Cisco IOS
```text
enable
configure terminal
vlan 10
name HR
vlan 20
name IT
```

### Verify
```text
show vlan brief
```

---

## Lab 30 – Access Ports

```text
interface fa0/1
switchport mode access
switchport access vlan 10
```

Repeat for another VLAN.

---

## Lab 31 – Trunk Port

```text
interface g0/1
switchport mode trunk
```

Verify:
```text
show interfaces trunk
```

---

## Lab 32 – STP Basics

Commands:
```text
show spanning-tree
```

Tasks:
- Identify the Root Bridge.
- Find blocked ports.

---

## Lab 33 – Enterprise Scenario

A user in VLAN 10 cannot reach another user in VLAN 10.

Investigate:
- VLAN assignment
- Switchport mode
- Cable
- MAC table

Document your findings.

---

## Lab 34 – Challenge Lab

Build a Packet Tracer topology:

- 2 Switches
- 4 PCs
- VLAN 10
- VLAN 20
- One trunk link

Verify:
- Same VLAN communication works.
- Different VLAN communication fails (until routing is configured).

---

## CCNA Review

- MAC Address
- Ethernet
- ARP
- VLAN
- Access Port
- Trunk
- STP
- MAC Address Table


---

# OSI Model Lab Guide - Part 4
# Layer 3 Labs (Network Layer)

## Lab 35 – Verify IP Configuration

### Commands
```cmd
ipconfig /all
```

Tasks:
- Record IPv4 Address
- Subnet Mask
- Default Gateway
- DNS Server

---

## Lab 36 – Test Connectivity

```cmd
ping 127.0.0.1
ping localhost
ping <Default Gateway>
ping 8.8.8.8
ping google.com
```

Explain what each test verifies.

---

## Lab 37 – Static Route (Cisco IOS)

Topology:
PC1 --- R1 --- R2 --- PC2

Commands on R1:

```text
conf t
ip route 192.168.2.0 255.255.255.0 10.0.0.2
end
```

Verify:

```text
show ip route
```

---

## Lab 38 – Default Route

```text
conf t
ip route 0.0.0.0 0.0.0.0 10.0.0.2
```

Verify Internet connectivity.

---

## Lab 39 – Routing Table

```text
show ip route
```

Identify:
- Connected Routes (C)
- Static Routes (S)
- Default Route (S*)

---

## Lab 40 – NAT (PAT)

```text
show ip nat translations
show ip nat statistics
```

Tasks:
- Generate Internet traffic.
- Observe translated addresses.

---

## Lab 41 – ICMP Analysis

Wireshark Filter:

```text
icmp
```

Run:

```cmd
ping 8.8.8.8
```

Identify:
- Echo Request
- Echo Reply

---

## Lab 42 – Traceroute Analysis

```cmd
tracert 8.8.8.8
```

Compare each hop with the routing path.

---

## Lab 43 – IPv6 Basics

```cmd
ipconfig
ping -6 localhost
```

If available:

```cmd
ping -6 ipv6.google.com
```

Record the IPv6 address and gateway.

---

## Lab 44 – Enterprise Routing Scenario

Scenario:

Branch A cannot communicate with Branch B.

Checklist:

- IP Address
- Subnet Mask
- Default Gateway
- Routing Table
- Static Routes
- NAT
- ACL (if configured)

Document the root cause and fix.

---

## Lab 45 – Packet Tracer Challenge

Build:

- 2 Routers
- 2 Switches
- 4 PCs

Requirements:
- Configure IPv4 addressing.
- Configure static routing.
- Verify end-to-end connectivity.
- Save the Packet Tracer file.

---

## CCNA Review

- IPv4 Addressing
- Default Gateway
- Static Routing
- Default Route
- Routing Table
- ICMP
- NAT
- IPv6


---

# OSI Model Lab Guide - Part 5
# Enterprise Labs, Wireshark & Final Challenges

# Lab 46 – Wireshark Capture Basics

## Objective
Capture live network traffic.

### Steps
1. Open Wireshark.
2. Select the active network adapter.
3. Start capturing.
4. Browse to several websites.
5. Stop the capture.

### Tasks
- Count captured packets.
- Identify TCP, UDP, ARP and ICMP traffic.

---

# Lab 47 – HTTP Analysis

Filter:
```text
http
```

Tasks:
- Locate an HTTP GET request.
- Find the Host header.
- Record the destination IP.

---

# Lab 48 – HTTPS Analysis

Filter:
```text
tls
```

Tasks:
- Identify the TLS handshake.
- Compare it with plain HTTP traffic.
- Explain why application data is encrypted.

---

# Lab 49 – DNS Analysis

Filter:
```text
dns
```

Tasks:
- Capture a DNS query.
- Identify Query Name.
- Identify the returned IP address.

---

# Lab 50 – DHCP Analysis

Filter:
```text
bootp
```

Identify the DORA process:

- Discover
- Offer
- Request
- Acknowledge

---

# Lab 51 – End-to-End OSI Analysis

Open a website while capturing traffic.

For each OSI layer identify:

- Protocol
- Address Used
- Device Involved
- PDU

---

# Lab 52 – Enterprise Troubleshooting

Scenario:

Users report:
- Internet is unavailable.
- Internal file server works.

Checklist:
- ipconfig
- ping gateway
- ping DNS
- nslookup
- tracert
- Wireshark capture

Document:
- Symptoms
- Root Cause
- Resolution

---

# Lab 53 – Packet Tracer Enterprise Network

Build:

- 3 Routers
- 3 Switches
- 12 PCs
- 2 VLANs
- DHCP
- Static Routing
- NAT

Verify:
- Internet access
- Inter-VLAN communication
- End-to-end connectivity

---

# Lab 54 – Final Challenge

Create a network for:

- Head Office
- Branch A
- Branch B

Requirements:

- IPv4 Addressing
- VLSM
- VLANs
- Static Routing
- NAT
- Internet Access

Prepare:
- IP Addressing Table
- Topology Diagram
- Test Results

---

# Practical Interview Questions

1. Explain the OSI Model.
2. What is the difference between TCP and UDP?
3. Explain ARP.
4. Explain NAT.
5. How do you troubleshoot a network?
6. What is the purpose of DNS?
7. What is the default gateway?
8. Explain VLANs.
9. What is a trunk port?
10. Explain VLSM.

---

# Final Assessment

Complete all labs without assistance.

Checklist:

- Binary
- IPv4
- Subnetting
- VLSM
- FLSM
- Routing
- NAT
- ARP
- VLAN
- STP
- DNS
- DHCP
- TCP
- UDP
- Wireshark
- Packet Tracer

---

# Congratulations

You have completed the OSI Model Lab Guide.

Next recommended module:
03-TCP-IP-Model
