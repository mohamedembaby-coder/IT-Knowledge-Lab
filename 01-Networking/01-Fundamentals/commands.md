# Networking Fundamentals Commands

> IT-Knowledge-Lab
>
> Complete Networking Commands Reference
>
> Version 1.0

---

# Table of Contents

1. Introduction
2. CMD vs PowerShell vs Linux
3. Network Troubleshooting Workflow
4. IPConfig
5. Ping
6. Tracert
7. PathPing
8. ARP
9. Route
10. Netstat
11. Nslookup
12. Hostname
13. Getmac
14. Netsh

---

# Introduction

Networking commands are the first tools every IT Support Engineer, System Administrator, Help Desk Engineer, and Network Engineer should master.

Understanding these commands allows you to diagnose connectivity problems, verify configurations, troubleshoot routing issues, and identify DNS or network failures without requiring advanced monitoring software.

---

## بالعربي

أوامر الشبكات تعتبر من أهم الأدوات التي يستخدمها أي متخصص IT بشكل يومي.

إذا أتقنت هذه الأوامر ستستطيع اكتشاف أغلب مشاكل الشبكات بدون الحاجة إلى برامج خارجية.

---

# CMD vs PowerShell vs Linux

| Tool | Main Purpose |
|----------|----------------|
| CMD | Basic Windows administration |
| PowerShell | Advanced scripting and administration |
| Linux Terminal | Linux server administration |

---

# Network Troubleshooting Workflow

```
Layer 1
↓
Cable Connected?

↓

NIC Enabled?

↓

IP Address Correct?

↓

Gateway Reachable?

↓

DNS Working?

↓

Internet Reachable?

↓

Application Working?
```

---

# IPConfig

---

## Purpose

Displays and manages TCP/IP configuration.

---

## بالعربي

يعرض إعدادات كارت الشبكة الحالية.

---

## Syntax

```cmd
ipconfig
```

---

## Advanced Syntax

```cmd
ipconfig /all

ipconfig /release

ipconfig /renew

ipconfig /flushdns

ipconfig /displaydns

ipconfig /registerdns
```

---

## Parameters

| Parameter | Description |
|------------|-------------|
| /all | Display complete configuration |
| /release | Release DHCP lease |
| /renew | Request new IP |
| /flushdns | Clear DNS Cache |
| /displaydns | Show DNS Cache |
| /registerdns | Register DNS Again |

---

## Example 1

```cmd
ipconfig
```

Output

```
IPv4 Address

Subnet Mask

Default Gateway
```

---

## Example 2

```cmd
ipconfig /all
```

Displays

- MAC Address

- DHCP Status

- DNS Servers

- Lease Time

- Gateway

- IPv6

---

## Enterprise Scenario

User cannot access the internet.

First step:

```cmd
ipconfig
```

Verify

✔ Correct IP

✔ Correct Gateway

✔ Correct DNS

---

## Common Problems

169.254.x.x

Means

DHCP Failed

---

No Default Gateway

Means

Cannot reach outside network

---

Wrong DNS

Means

Internet works

Websites don't

---

## Best Practices

Always run

```cmd
ipconfig /all
```

before escalating any network ticket.

---

## Related Commands

```
ping

arp

route

netstat

nslookup
```

---

## Interview Questions

### Q1

Difference between

```
ipconfig

and

ipconfig /all
```

---

### Q2

What causes

```
169.254.x.x
```

---

### Q3

What does

```
flushdns
```

do?

---

# Ping

---

## Purpose

Tests connectivity using ICMP Echo Request.

---

## بالعربي

يختبر الاتصال بين جهازين.

---

## Syntax

```cmd
ping 8.8.8.8
```

---

## Examples

```cmd
ping google.com
```

```cmd
ping 192.168.1.1
```

```cmd
ping -t google.com
```

```cmd
ping -n 20 8.8.8.8
```

```cmd
ping -l 1500 google.com
```

---

## Parameters

| Option | Description |
|----------|-------------|
| -t | Continuous Ping |
| -n | Number of packets |
| -l | Packet Size |
| -4 | Force IPv4 |
| -6 | Force IPv6 |

---

## Output

```
Reply from 8.8.8.8

Bytes=32

Time=18ms

TTL=118
```

---

## Output Meaning

Bytes

Packet Size

---

Time

Latency

---

TTL

Remaining packet lifetime

---

Request Timed Out

Destination unreachable

No response

---

General Failure

NIC Problem

Firewall

VPN

---

## Enterprise Scenario

Employee says

"I can't access ERP"

Steps

```
Ping Gateway

↓

Ping DNS

↓

Ping ERP Server

↓

Ping Internet
```

---

## Common Mistakes

Ping works

Application still fails

Reason

Application uses TCP

Ping uses ICMP

---

## Security Note

Many enterprise firewalls block ICMP.

Failed ping does NOT always mean network failure.

---

## Best Practices

Always test

```
Gateway

↓

DNS

↓

Internet

↓

Server
```

---

## Related Commands

```
tracert

pathping

netstat

route
```

---

## Interview Questions

Difference between

```
Ping

Traceroute
```

---

What is TTL?

---

What protocol does Ping use?

(ICMP)

---

# Tracert

---

## Purpose

Displays the path (route) that packets take from your computer to a remote destination.

---

## بالعربي

يعرض جميع أجهزة الشبكة (Routers) التي تمر بها البيانات حتى تصل إلى الجهاز الهدف.

يساعد في معرفة مكان المشكلة داخل الشبكة أو عند مزود خدمة الإنترنت.

---

## How It Works

Tracert sends ICMP Echo Requests while gradually increasing the **TTL (Time To Live)** value.

Every router decreases the TTL by one.

When TTL reaches zero, that router replies with an ICMP Time Exceeded message.

By repeating this process, Windows discovers every hop between your PC and the destination.

---

## Syntax

```cmd
tracert <hostname>
```

or

```cmd
tracert <IP Address>
```

---

## Examples

### Trace Google

```cmd
tracert google.com
```

---

### Trace Public DNS

```cmd
tracert 8.8.8.8
```

---

### Prevent DNS Name Resolution

```cmd
tracert -d 8.8.8.8
```

---

### Increase Maximum Hops

```cmd
tracert -h 40 google.com
```

---

### Wait Longer for Replies

```cmd
tracert -w 5000 google.com
```

---

## Parameters

| Option | Description |
|---------|-------------|
| -d | Don't resolve host names |
| -h | Maximum number of hops |
| -w | Timeout in milliseconds |
| -4 | Force IPv4 |
| -6 | Force IPv6 |

---

## Example Output

```text
Tracing route to google.com

1    <1 ms     <1 ms      <1 ms    192.168.1.1

2     4 ms      5 ms       4 ms    10.20.0.1

3    12 ms     11 ms      12 ms    ISP Router

4    18 ms     17 ms      18 ms    Google
```

---

## Output Explanation

### Hop

Number of routers crossed.

---

### Time

Latency to each router.

Lower values are better.

---

### IP Address

Router interface address.

---

### Host Name

DNS name of the router (if available).

---

## What Does * Mean?

```text
* * *
```

Means the router did not respond.

Possible reasons:

- Firewall
- ICMP Disabled
- Router configured not to reply
- Packet lost

One or two stars do **not always indicate a problem**.

---

## Enterprise Scenario

User reports:

> "VPN is disconnected."

Run:

```cmd
tracert vpn.company.com
```

Result:

```
Hop 1  OK

Hop 2  OK

Hop 3  OK

Hop 4  Timeout

Hop 5  Timeout
```

Conclusion:

Traffic is stopping after ISP Router.

Problem is **outside** the company network.

---

## Troubleshooting Workflow

```
Ping Gateway

↓

Ping Internet

↓

Tracert Destination

↓

Identify Last Reachable Hop

↓

Contact ISP if Needed
```

---

## Common Problems

### Stops at First Hop

Possible causes:

- Wrong Gateway
- Router Down
- Local Firewall

---

### Stops Inside ISP

Usually ISP issue.

---

### Stops Near Destination

Possible:

- Remote Firewall
- Remote Network Failure

---

### High Latency

Possible:

- Congestion
- Bad Link
- WAN Problem

---

## Best Practices

✔ Run several times.

✔ Compare results from another computer.

✔ Save results before contacting ISP.

---

## Save Output

```cmd
tracert google.com > trace.txt
```

---

## Related Commands

```
ping

pathping

route

netstat
```

---

## Interview Questions

### What protocol does Tracert use?

ICMP.

---

### Why does Tracert change TTL?

To discover every router between source and destination.

---

### Does a timeout always indicate a failure?

No.

Many routers intentionally ignore ICMP.

---

# PathPing

---

## Purpose

Combines **Ping** and **Tracert**.

It identifies:

- Every hop
- Packet loss
- Latency

---

## بالعربي

يجمع بين Ping و Tracert.

لا يعرض فقط مسار البيانات، بل يحدد أيضًا نسبة فقدان الحزم عند كل Router.

---

## Syntax

```cmd
pathping google.com
```

---

## Examples

```cmd
pathping 8.8.8.8
```

---

```cmd
pathping server01
```

---

## Parameters

| Option | Description |
|---------|-------------|
| -n | Don't resolve names |
| -h | Maximum hops |
| -q | Number of queries |
| -w | Timeout |
| -4 | IPv4 |
| -6 | IPv6 |

---

## How It Works

Step 1

Discovers the route.

↓

Step 2

Pings every router for several minutes.

↓

Step 3

Calculates packet loss.

---

## Sample Output

```text
Hop

Lost/Sent

Address

1

0%

192.168.1.1

2

2%

ISP

3

15%

Core Router

4

0%

Destination
```

---

## Output Explanation

Loss %

Percentage of dropped packets.

---

Latency

Average response time.

---

Hop

Router number.

---

## Enterprise Scenario

Employees complain:

"The ERP is very slow."

Run:

```cmd
pathping erp.company.local
```

Result:

```
Hop 6

Packet Loss

22%
```

Conclusion

WAN link between Branch Office and Data Center is dropping packets.

---

## Common Problems

### High Packet Loss

Possible:

- Bad Cable
- ISP Issue
- Congested Link
- Overloaded Router

---

### High Latency

Possible:

- WAN Congestion
- VPN Overload
- Slow ISP

---

## Best Practices

Run PathPing for at least 5 minutes.

Do not interrupt the command.

---

## Related Commands

```
ping

tracert

netstat

route
```

---

## Interview Questions

### Why is PathPing slower than Ping?

Because it collects statistics for every hop before producing the final report.

---

### When should you use PathPing instead of Ping?

When you need to identify **where** packet loss occurs rather than simply confirming connectivity.

---

# ARP (Address Resolution Protocol)

---

## Purpose

Displays and manages the ARP (Address Resolution Protocol) cache.

ARP is responsible for mapping **IPv4 addresses** to **MAC addresses** within the local network.

---

## بالعربي

يعرض أو يعدل جدول ARP الموجود على الجهاز.

يقوم ARP بتحويل عنوان الـ IP إلى عنوان الـ MAC حتى يتمكن الجهاز من إرسال البيانات داخل الشبكة المحلية (LAN).

---

## How ARP Works

When a computer wants to communicate with another device in the same subnet:

1. It checks the ARP Cache.
2. If the MAC address exists, communication starts immediately.
3. If not, it broadcasts an ARP Request.
4. The destination replies with its MAC address.
5. The information is stored temporarily in the ARP Cache.

---

## Syntax

```cmd
arp -a
```

---

## Additional Syntax

```cmd
arp -d *
```

```cmd
arp -d 192.168.1.50
```

```cmd
arp -s 192.168.1.100 00-11-22-33-44-55
```

---

## Parameters

| Parameter | Description |
|------------|-------------|
| -a | Display ARP cache |
| -d | Delete an entry |
| -s | Create a static ARP entry |
| -N | Display entries for a specific interface |

---

## Example 1

```cmd
arp -a
```

Output:

```text
Internet Address      Physical Address      Type

192.168.1.1          98-ab-cd-11-22-33     Dynamic

192.168.1.15         54-12-78-aa-bb-cc     Dynamic
```

---

## Output Explanation

### Internet Address

IPv4 Address

---

### Physical Address

MAC Address

---

### Type

Dynamic

Automatically learned.

Static

Configured manually.

---

## Example 2

Delete All Entries

```cmd
arp -d *
```

---

## Example 3

Delete One Entry

```cmd
arp -d 192.168.1.20
```

---

## Example 4

Static Mapping

```cmd
arp -s 192.168.1.100 00-11-22-33-44-55
```

---

## Enterprise Scenario

User reports:

> Cannot communicate with a printer.

Run

```cmd
arp -a
```

Verify that the printer IP is associated with the correct MAC address.

If the MAC is incorrect, clear the cache:

```cmd
arp -d *
```

Try again.

---

## Common Problems

### Duplicate IP Address

Two devices respond with different MAC addresses.

Symptoms:

- Random disconnects
- Network instability

---

### ARP Cache Corruption

Incorrect MAC stored.

Solution:

```cmd
arp -d *
```

---

### ARP Spoofing

Attackers send fake ARP replies.

Result:

Traffic is redirected through the attacker's machine.

---

## Security Notes

ARP has **no authentication**.

Because of this, it is vulnerable to:

- ARP Spoofing
- ARP Poisoning
- Man-in-the-Middle (MITM) attacks

Enterprise networks often mitigate these risks using:

- Dynamic ARP Inspection (DAI)
- DHCP Snooping
- Port Security

---

## Best Practices

✔ Clear ARP cache after IP changes.

✔ Verify MAC addresses before troubleshooting.

✔ Investigate duplicate MAC/IP entries.

---

## Related Commands

```text
ipconfig
ping
getmac
netstat
```

---

## Interview Questions

### What does ARP do?

Maps IPv4 addresses to MAC addresses.

---

### Does ARP work across routers?

No.

ARP works only within the local broadcast domain (LAN).

---

### Why is ARP vulnerable?

Because it has no built-in authentication.

---

# Route

---

## Purpose

Displays and manages the local IP routing table.

---

## بالعربي

يعرض جدول التوجيه الموجود داخل نظام التشغيل.

كل جهاز يحتفظ بجدول يحدد أفضل طريق لإرسال البيانات.

---

## Syntax

```cmd
route print
```

---

## Additional Syntax

```cmd
route add
```

```cmd
route delete
```

```cmd
route change
```

---

## Display Routing Table

```cmd
route print
```

---

## Add Static Route

```cmd
route add 10.0.0.0 mask 255.255.255.0 192.168.1.1
```

---

## Delete Route

```cmd
route delete 10.0.0.0
```

---

## Modify Route

```cmd
route change 10.0.0.0 mask 255.255.255.0 192.168.1.254
```

---

## Parameters

| Parameter | Description |
|------------|-------------|
| print | Display routing table |
| add | Add new route |
| delete | Delete route |
| change | Modify existing route |
| -p | Persistent route after reboot |

---

## Example Output

```text
Network Destination

Netmask

Gateway

Interface

Metric
```

---

## Output Explanation

### Network Destination

Destination network.

---

### Netmask

Subnet mask.

---

### Gateway

Next hop router.

---

### Interface

Local network adapter.

---

### Metric

Lower metric = Higher priority.

---

## Enterprise Scenario

Company has:

Office LAN

192.168.1.0/24

VPN Network

10.10.0.0/16

A static route is required:

```cmd
route add 10.10.0.0 mask 255.255.0.0 192.168.1.1
```

---

## Persistent Route

```cmd
route -p add 10.10.0.0 mask 255.255.0.0 192.168.1.1
```

The route remains after reboot.

---

## Common Problems

Wrong Gateway

↓

Traffic goes to the wrong router.

---

Wrong Metric

↓

Unexpected routing decisions.

---

Missing Route

↓

Destination network is unreachable.

---

## Best Practices

✔ Document all static routes.

✔ Prefer dynamic routing in enterprise environments.

✔ Verify routes after VPN installation.

---

## Security Notes

Incorrect routes can:

- Redirect traffic
- Break VPN connectivity
- Cause routing loops
- Expose internal networks

---

## Related Commands

```text
tracert
pathping
ipconfig
netstat
```

---

## Interview Questions

### What is a routing table?

A database that determines where IP packets should be forwarded.

---

### What does the Metric represent?

Route priority.

Lower metric = Preferred route.

---

### What is the difference between Dynamic and Static Routes?

Static routes are manually configured.

Dynamic routes are learned automatically through routing protocols.

---

# Netstat

---

## Purpose

Displays active network connections, listening ports, and per-protocol statistics on the local machine.

---

## بالعربي

يعرض الاتصالات النشطة والبورتات المفتوحة (Listening Ports) وإحصائيات البروتوكولات على الجهاز.

يُستخدم بكثرة لمعرفة البرامج التي تتصل بالإنترنت، والتأكد من عدم وجود اتصالات مشبوهة تتجه إلى سيرفرات خارجية.

---

## Syntax

```cmd
netstat
```

---

## Advanced Syntax

```cmd
netstat -a

netstat -n

netstat -o

netstat -b

netstat -an

netstat -ano

netstat -r

netstat -e

netstat -p tcp
```

---

## Parameters

| Parameter | Description |
|------------|-------------|
| -a | Display all connections and listening ports |
| -n | Show addresses and ports numerically (no name resolution) |
| -o | Show the Process ID (PID) owning each connection |
| -b | Show the executable involved in creating each connection |
| -p | Filter connections by protocol (tcp/udp) |
| -r | Display the routing table |
| -e | Display Ethernet statistics |
| -s | Display statistics per protocol |

---

## Example 1

```cmd
netstat -an
```

Output

```text
Proto  Local Address        Foreign Address       State

TCP    192.168.1.10:445     0.0.0.0:0             LISTENING

TCP    192.168.1.10:3389    41.32.10.5:52344      ESTABLISHED

UDP    192.168.1.10:137     *:*
```

---

## Example 2

```cmd
netstat -ano
```

Same output as above, with an added PID column used to trace a connection back to the exact process in Task Manager.

---

## Output Explanation

### Proto

Protocol used (TCP or UDP).

---

### Local Address

Local IP address and port.

---

### Foreign Address

Remote IP address and port the connection is talking to.

---

### State

Connection status:

- LISTENING — waiting for incoming connections
- ESTABLISHED — active, ongoing connection
- TIME_WAIT — connection is closing
- CLOSE_WAIT — waiting for the local application to close

---

## Enterprise Scenario

Antivirus raises an alert about suspicious outbound traffic.

Run:

```cmd
netstat -ano
```

Identify the foreign IP and the PID, then match the PID in Task Manager to find the responsible process.

---

## Common Problems

### Too Many ESTABLISHED Connections

Possible causes:

- Malware beaconing to a command-and-control server
- Misconfigured application stuck in a retry loop

---

### Port Already in Use

An application fails to start because another process is already listening on the same port.

Use `netstat -ano` to find and stop the conflicting process.

---

## Security Notes

Netstat is one of the first commands used during incident response to spot unauthorized outbound connections.

Always confirm any unfamiliar foreign IP against threat intelligence before dismissing it as normal traffic.

---

## Best Practices

✔ Use `-ano` together with Task Manager or Resource Monitor.

✔ Baseline the normal connections for critical servers.

✔ Investigate any unfamiliar high-numbered foreign ports.

---

## Related Commands

```text
arp
ipconfig
route
tasklist
```

---

## Interview Questions

### What does the LISTENING state mean?

The port is open and waiting for incoming connections.

---

### How do you find which process owns a connection?

Run `netstat -ano` to get the PID, then match it against Task Manager.

---

### What is the difference between TCP and UDP in netstat output?

TCP is connection-oriented and shows a State column; UDP is connectionless and has no state.

---

# Nslookup

---

## Purpose

Queries DNS servers to resolve hostnames to IP addresses (and vice versa), and to inspect specific DNS record types.

---

## بالعربي

يُستخدم للتأكد من أن خدمة الـ DNS تعمل بشكل صحيح، ولمعرفة العنوان الذي يتم تحويل اسم الموقع إليه.

يساعد في تشخيص مشكلة "الإنترنت شغال لكن المواقع مش بتفتح".

---

## Syntax

```cmd
nslookup google.com
```

---

## Advanced Syntax

```cmd
nslookup

nslookup google.com 8.8.8.8

nslookup -type=MX google.com

nslookup -type=NS google.com

nslookup -type=TXT google.com

nslookup -type=PTR 8.8.8.8
```

---

## Interactive Mode

```cmd
nslookup
> server 8.8.8.8
> google.com
> exit
```

---

## Query Types

| Type | Description |
|------|-------------|
| A | IPv4 address record |
| AAAA | IPv6 address record |
| MX | Mail exchange record |
| NS | Name server record |
| TXT | Text record (SPF, domain verification, etc.) |
| PTR | Reverse lookup (IP to hostname) |
| CNAME | Alias record |

---

## Example 1

```cmd
nslookup google.com
```

Output

```text
Server:  dns.google

Address: 8.8.8.8

Non-authoritative answer:

Name:    google.com

Address: 142.250.185.14
```

---

## Example 2 — Specify a DNS Server

```cmd
nslookup google.com 1.1.1.1
```

Resolves the name using Cloudflare's DNS server instead of the system default. Useful for comparing results between resolvers.

---

## Example 3 — Reverse Lookup

```cmd
nslookup 8.8.8.8
```

Returns the hostname associated with an IP address.

---

## Output Explanation

### Server / Address

The DNS server that answered the query.

---

### Non-authoritative answer

The response came from a cached record on a resolving server, not directly from the domain's authoritative name server.

---

### Name / Address

The resolved hostname and its IP address.

---

## Enterprise Scenario

User reports:

> "The website doesn't open, but the internet works."

Run:

```cmd
nslookup companyportal.com
```

If nslookup fails to resolve the name, but pinging the IP address directly succeeds, the problem is DNS — not general connectivity.

---

## Common Problems

### DNS Server Not Responding

Possible causes:

- Wrong DNS server configured
- DNS server is down
- Firewall blocking port 53

---

### Non-Existent Domain

The domain name is misspelled, expired, or has not propagated yet.

---

## Security Notes

DNS queries can leak internal domain names if misconfigured. Enterprises should restrict recursive DNS queries to trusted internal networks only, and monitor for DNS tunneling used in data exfiltration.

---

## Best Practices

✔ Test with more than one DNS server (internal and public) to isolate the problem.

✔ Use `nslookup -type=MX` when troubleshooting email delivery issues.

✔ Compare internal DNS results against public DNS to confirm split-DNS is working correctly.

---

## Related Commands

```text
ipconfig /flushdns
ping
tracert
netsh
```

---

## Interview Questions

### What port does DNS use?

UDP/TCP port 53.

---

### What does "Non-authoritative answer" mean?

The result came from a cached copy on a resolving DNS server rather than from the domain's authoritative server.

---

### How would you troubleshoot an email delivery issue using nslookup?

By querying the MX record of the recipient's domain to confirm the correct mail server is configured.

---

# Hostname

---

## Purpose

Displays the computer's hostname (device name) configured in the operating system.

---

## بالعربي

يعرض اسم الجهاز (Computer Name) المستخدم داخل الشبكة.

يُستخدم لتحديد الأجهزة داخل الشبكات المحلية، والدومين، وأدوات الإدارة المركزية.

---

## Syntax

```cmd
hostname
```

---

## Example

```cmd
hostname
```

Output

```text
PC-HR-015
```

---

## What is a Hostname?

A hostname is a human-readable name assigned to a computer.

Instead of remembering an IP address like:

```text
192.168.10.25
```

Administrators can simply use:

```text
PC-HR-015
```

---

## Enterprise Naming Examples

| Department | Example |
|------------|---------|
| HR | HR-PC-01 |
| Finance | FIN-PC-10 |
| IT | IT-LAP-07 |
| Server | SRV-DC01 |
| Database | DB01 |
| File Server | FS01 |

---

## Enterprise Scenario

A user calls IT Support.

Instead of asking:

> What is your IP Address?

Support asks:

> What is your Computer Name?

The technician then searches Active Directory, SCCM, Intune, or RMM using the hostname.

---

## Common Problems

### Duplicate Hostname

Two devices share the same name.

Possible issues:

- Domain Join Problems
- DNS Registration Errors
- Remote Management Conflicts

---

### Wrong Hostname

A laptop was assigned to another employee without being renamed.

Inventory systems become inaccurate.

---

## Best Practices

✔ Use a consistent naming convention.

✔ Avoid spaces.

✔ Avoid Arabic characters.

✔ Include department or location.

Example

```text
CAI-HR-PC-021
```

---

## Related Commands

```text
ipconfig
getmac
whoami
systeminfo
```

---

## Interview Questions

### What is the purpose of the hostname?

To uniquely identify a computer on the network.

---

### Can two computers have the same hostname?

Not in the same Active Directory domain.

---

# Getmac

---

## Purpose

Displays the MAC Address of network adapters installed on the computer.

---

## بالعربي

يعرض عنوان الـ MAC الخاص بكل كارت شبكة موجود على الجهاز.

---

## What is a MAC Address?

A MAC (Media Access Control) Address is a unique hardware identifier assigned to every network interface.

Example:

```text
00-1A-2B-3C-4D-5E
```

Length:

48 bits

12 Hexadecimal digits

---

## Syntax

```cmd
getmac
```

---

## Detailed Output

```cmd
getmac /v
```

---

## Display Using CSV

```cmd
getmac /fo csv
```

---

## Display Using Table

```cmd
getmac /fo table
```

---

## Parameters

| Parameter | Description |
|------------|-------------|
| /v | Verbose Output |
| /fo table | Table Format |
| /fo csv | CSV Format |
| /fo list | List Format |
| /nh | Hide Header |

---

## Example Output

```text
Physical Address

Transport Name

00-15-5D-01-22-88
```

---

## Enterprise Scenario

A company uses MAC Address Filtering.

Employee cannot connect.

IT Engineer runs

```cmd
getmac
```

Compares the MAC against the allowed list.

---

## Security Investigation

An unknown device appears on the network.

Administrator compares

Switch MAC Table

↓

Computer MAC

↓

DHCP Lease

↓

Asset Inventory

---

## Common Problems

Virtual Adapters

VPN software may create additional MAC addresses.

---

Disabled Adapter

May not appear correctly.

---

Spoofed MAC Address

Attackers can change MAC addresses.

Never rely solely on MAC filtering for security.

---

## Best Practices

✔ Record MAC addresses during asset inventory.

✔ Verify wireless and wired adapters separately.

✔ Compare with switch CAM tables when troubleshooting.

---

## Related Commands

```text
arp
ipconfig
hostname
netsh
```

---

## Interview Questions

### What is the difference between MAC Address and IP Address?

MAC identifies the hardware.

IP identifies the logical network location.

---

### Is the MAC Address globally unique?

Usually yes, unless manually spoofed.

---

# Netsh (Network Shell)

---

## Purpose

Netsh is a command-line utility used to configure and troubleshoot Windows networking components.

---

## بالعربي

يعتبر Netsh واحدًا من أقوى أوامر إدارة الشبكات في Windows.

يمكن استخدامه لإدارة:

- Network Interfaces
- IP Configuration
- Firewall
- WLAN
- DHCP
- Routing
- Winsock
- Proxy
- TCP/IP

---

## Basic Syntax

```cmd
netsh
```

Enter interactive mode.

Exit

```cmd
exit
```

---

## Show Network Interfaces

```cmd
netsh interface show interface
```

---

## Show IP Configuration

```cmd
netsh interface ipv4 show config
```

---

## Configure Static IP

```cmd
netsh interface ip set address name="Ethernet" static 192.168.1.20 255.255.255.0 192.168.1.1
```

---

## Return to DHCP

```cmd
netsh interface ip set address name="Ethernet" dhcp
```

---

## Configure DNS

```cmd
netsh interface ip set dns name="Ethernet" static 8.8.8.8
```

---

## Return DNS to DHCP

```cmd
netsh interface ip set dns name="Ethernet" dhcp
```

---

## Reset TCP/IP

```cmd
netsh int ip reset
```

---

## Reset Winsock

```cmd
netsh winsock reset
```

Restart Windows after running the command.

---

## Export Wi-Fi Profiles

```cmd
netsh wlan export profile key=clear
```

---

## Show Saved Wi-Fi Profiles

```cmd
netsh wlan show profiles
```

---

## Show Wi-Fi Password

```cmd
netsh wlan show profile name="OfficeWiFi" key=clear
```

---

## Enterprise Scenario

Employee loses Internet access.

Troubleshooting Steps

```text
ipconfig

↓

ping Gateway

↓

nslookup

↓

netsh winsock reset

↓

netsh int ip reset

↓

Restart PC
```

---

## Common Problems

Incorrect Static IP

↓

No Internet

---

Broken Winsock

↓

Applications cannot connect

---

Wrong DNS

↓

Internet works by IP only

---

Firewall Misconfiguration

↓

Applications blocked

---

## Security Notes

Netsh requires Administrator privileges.

Changes affect the operating system immediately.

Always document configuration changes in enterprise environments.

---

## Best Practices

✔ Export configuration before making changes.

✔ Use Administrator Command Prompt.

✔ Test connectivity after each modification.

✔ Restart when resetting Winsock or TCP/IP.

---

## Related Commands

```text
ipconfig
ping
route
netstat
nslookup
```

---

## Interview Questions

### What does `netsh winsock reset` do?

Resets the Windows Winsock catalog to its default state.

---

### When should `netsh int ip reset` be used?

When the TCP/IP stack is corrupted or network settings are damaged.

---

### Why is Netsh considered powerful?

Because it can configure almost every major networking component in Windows from the command line.

---

# Command Comparison

| Command | Main Purpose |
|---------|--------------|
| ipconfig | View and manage IP configuration |
| ping | Test connectivity |
| tracert | Discover packet path |
| pathping | Analyze latency and packet loss |
| arp | View ARP cache |
| route | Manage routing table |
| netstat | View connections and ports |
| nslookup | Test DNS |
| hostname | Display computer name |
| getmac | Display MAC addresses |
| netsh | Configure Windows networking |

---

# Quick Troubleshooting Checklist

```text
Check Cable / Wi-Fi
        │
        ▼
Run ipconfig
        │
        ▼
Valid IP?
        │
   Yes / No
        │
        ▼
Ping Gateway
        │
        ▼
Ping DNS
        │
        ▼
Run nslookup
        │
        ▼
Run tracert
        │
        ▼
Check netstat
        │
        ▼
Reset Winsock/TCP-IP if required
        │
        ▼
Verify Application
```

---

# Summary

By mastering these commands, an IT professional can diagnose and resolve the majority of day-to-day Windows networking issues without relying on third-party tools. These commands form the foundation for more advanced topics such as Windows Server administration, Active Directory, Cisco networking, FortiGate firewalls, and enterprise network troubleshooting.

---

**End of Windows CMD Networking Commands**

---

# أوامر Enterprise الأساسية (Enterprise Command Playbook)

> نفّذ الأوامر بصلاحيات مناسبة، وسجّل الـ output في ticket. لا تستخدم أوامر reset أو تغييرات Cisco في الإنتاج قبل تحديد الأثر وخطة rollback.

## Windows PowerShell

| الهدف | الأمر | ماذا يثبت؟ |
|---|---|---|
| عرض التكوين الفعّال | `Get-NetIPConfiguration` | IPv4/IPv6، gateway، DNS، interface |
| فحص interfaces | `Get-NetAdapter` | الحالة والسرعة وMAC |
| اختبار DNS | `Resolve-DnsName erp.corp.example` | resolver والسجل وIP الناتج |
| اختبار TCP | `Test-NetConnection erp.corp.example -Port 443` | DNS، route، TCP port |
| عرض المسارات | `Get-NetRoute -AddressFamily IPv4` | route والـ next hop والـ metric |
| فحص sockets | `Get-NetTCPConnection -State Established` | الاتصالات والـ owning process |
| فحص ملف جدار ناري | `Get-NetFirewallProfile` | حالة Windows Firewall |

```powershell
# اجمع baseline قبل أي تغيير
Get-NetIPConfiguration
Get-NetAdapter | Format-Table Name, Status, LinkSpeed, MacAddress -Auto
Get-DnsClientServerAddress -AddressFamily IPv4
Test-NetConnection erp.corp.example -Port 443 -InformationLevel Detailed
```

### معالجة DNS بصورة آمنة

```powershell
Resolve-DnsName erp.corp.example
Clear-DnsClientCache
ipconfig /registerdns
```

لا تجعل `Clear-DnsClientCache` تشخيصاً وحيداً: قارن اسم FQDN بسجل DNS، وتحقق من DNS suffix وIPv4/IPv6 والـ forwarder.

## Windows CMD: تسلسل اختبار قابل لإعادة الاستخدام

```cmd
ipconfig /all
ping <default-gateway>
ping <known-server-ip>
nslookup erp.corp.example
tracert -d <known-server-ip>
netstat -ano | findstr :443
```

| نتيجة شائعة | التفسير الأولي | الخطوة التالية |
|---|---|---|
| `169.254.x.x` | DHCP lease غير متاح | افحص VLAN وDHCP scope/relay |
| gateway لا يرد | Layer 1/2 أو ACL أو gateway | افحص link/VLAN وswitch port |
| IP يعمل والاسم يفشل | DNS path/record/suffix | `nslookup` و`Resolve-DnsName` |
| TCP 443 يفشل وping ينجح | خدمة أو firewall/ACL | `Test-NetConnection` وlogs |

## Cisco IOS: أوامر تحقق آمنة (Read-only Verification)

```cisco
show interfaces status
show interfaces counters errors
show ip interface brief
show vlan brief
show interfaces trunk
show mac address-table dynamic
show ip arp
show ip route
show cdp neighbors detail
show logging
```

| الأمر | استخدامه في incident |
|---|---|
| `show interfaces counters errors` | كشف CRC/input errors وduplex/cable symptoms |
| `show vlan brief` | التأكد من VLAN الخاصة بمنفذ المستخدم |
| `show interfaces trunk` | التحقق من allowed VLANs وnative VLAN |
| `show mac address-table dynamic` | التحقق من تعلم MAC في المنفذ المتوقع |
| `show ip route` | إثبات وجود route قبل اتهام firewall |

### مثال Cisco: تشخيص جهاز Finance

```cisco
show interfaces gigabitEthernet1/0/10 status
show interfaces gigabitEthernet1/0/10 switchport
show mac address-table interface gigabitEthernet1/0/10
show interfaces counters errors
```

**تفسير:** إذا كان المنفذ up لكن VLAN ليست `20`، فالمشكلة Layer 2 وليست DNS. إذا ظهرت CRC errors متزايدة، اختبر الكابل والـ transceiver والسرعة/duplex قبل تغيير IP.

## Linux للمقارنة مع Windows

```bash
ip address show
ip route show
resolvectl query erp.corp.example
ss -tulpn
ping -c 4 <default-gateway>
traceroute -n <server-ip>
```

## أوامر تتطلب حذراً (Change / Recovery Commands)

| الأمر | الأثر | قاعدة تشغيلية |
|---|---|---|
| `ipconfig /release` | يفصل lease الحالي | لا تنفذه على خادم إنتاج عن بعد |
| `netsh winsock reset` | يحتاج restart وقد يغيّر connectivity | بعد baseline وموافقة تغيير |
| `netsh int ip reset` | يعيد TCP/IP settings | استخدمه كآخر حل على endpoint |
| `shutdown` في Cisco | يقطع الخدمة | لا ينفذ إلا ضمن change مع rollback |

## أسئلة مقابلات للأوامر

### لماذا تفضّل `Test-NetConnection -Port 443` على `ping` لاختبار تطبيق ويب؟

**الإجابة:** لأنه يختبر مسار TCP والمنفذ الذي يستخدمه التطبيق، بينما `ping` يختبر ICMP فقط وقد يكون محجوباً أو مسموحاً بشكل مستقل عن HTTPS.

### ما الفرق بين `tracert` و`pathping`؟

**الإجابة:** `tracert` يعرض hops بسرعة، أما `pathping` فيجمع قياسات أطول لتقدير الفقد على المسار؛ لذلك الأخير أبطأ لكنه مفيد في التشخيص المتقطع.
