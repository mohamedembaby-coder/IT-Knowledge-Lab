# 🛠️ Networking Fundamentals Troubleshooting Guide

> A practical guide to diagnosing and resolving common networking issues.

---

# 🎯 Troubleshooting Methodology

When troubleshooting a network problem, always follow a logical sequence.

```
Identify the Problem
        ↓
Gather Information
        ↓
Check Physical Connections
        ↓
Check IP Configuration
        ↓
Test Connectivity
        ↓
Test DNS
        ↓
Verify Network Devices
        ↓
Implement Solution
        ↓
Verify Resolution
        ↓
Document the Issue
```

---

# 🔍 Issue 1 – No Internet Connection

## Symptoms

- Websites do not open.
- Teams or Outlook cannot connect.
- Windows displays "No Internet".

---

## Possible Causes

- Loose network cable
- Wi-Fi disconnected
- Router failure
- ISP outage
- Incorrect IP configuration

---

## Troubleshooting Steps

### Step 1

Check the cable or Wi-Fi connection.

---

### Step 2

Run:

```cmd
ipconfig
```

Verify:

- IPv4 Address
- Subnet Mask
- Default Gateway

---

### Step 3

Ping the gateway.

```cmd
ping <Default Gateway>
```

---

### Step 4

Ping Google's DNS.

```cmd
ping 8.8.8.8
```

---

### Step 5

Test DNS.

```cmd
nslookup google.com
```

---

# 🔍 Issue 2 – Limited Connectivity

## Symptoms

- Connected to the network.
- Internet unavailable.

---

## Possible Causes

- DHCP failure
- Wrong Gateway
- Wrong DNS

---

## Solution

Renew the IP Address.

```cmd
ipconfig /release

ipconfig /renew
```

---

# 🔍 Issue 3 – DNS Problem

## Symptoms

```
ping 8.8.8.8
```

Works.

```
ping google.com
```

Fails.

---

## Cause

DNS Server problem.

---

## Verify

```cmd
nslookup google.com
```

---

## Fix

```cmd
ipconfig /flushdns
```

Then test again.

---

# 🔍 Issue 4 – IP Address Conflict

## Symptoms

Windows displays:

```
IP Address Conflict
```

---

## Cause

Two devices use the same IP Address.

---

## Solution

If DHCP is enabled:

```cmd
ipconfig /release

ipconfig /renew
```

If Static IP is configured:

Assign a unique IP address.

---

# 🔍 Issue 5 – Cannot Reach Another Computer

## Checklist

- Same Network?
- Correct IP?
- Firewall Enabled?
- Device Powered On?
- Network Discovery Enabled?

---

## Commands

```cmd
ping <IP>
```

```cmd
arp -a
```

---

# 🔍 Issue 6 – Slow Network

## Possible Causes

- High bandwidth usage
- Faulty cable
- Duplex mismatch
- Old switch
- Malware

---

## Check

```cmd
netstat -an
```

Look for excessive active connections.

---

# 🔍 Issue 7 – Default Gateway Not Available

## Symptoms

Windows Network Troubleshooter displays:

```
Default Gateway is not available.
```

---

## Possible Causes

- Router issue
- Driver problem
- Incorrect configuration

---

## Solutions

Restart:

- Computer
- Router
- Switch

Update the Network Adapter driver.

---

# 🔍 Issue 8 – Unable to Obtain an IP Address

## Symptoms

IP Address:

```
169.254.x.x
```

---

## Meaning

The computer failed to receive an address from the DHCP Server.

---

## Solution

Run:

```cmd
ipconfig /release

ipconfig /renew
```

If the problem continues:

- Check DHCP Server.
- Check switch port.
- Check cable.

---

# 🔍 Issue 9 – High Packet Loss

## Test

```cmd
ping 8.8.8.8 -t
```

Observe:

- Time
- Packet Loss

---

## Possible Causes

- Weak Wi-Fi
- Cable damage
- ISP issue
- Network congestion

---

# 📋 Essential Troubleshooting Commands

| Command | Purpose |
|----------|---------|
| ipconfig | View IP configuration |
| ipconfig /all | Detailed configuration |
| ipconfig /release | Release DHCP address |
| ipconfig /renew | Request new DHCP address |
| ipconfig /flushdns | Clear DNS cache |
| ping | Test connectivity |
| tracert | Trace packet path |
| pathping | Detect packet loss |
| nslookup | Test DNS |
| arp -a | Display ARP cache |
| netstat -an | Display active connections |

---

# 💡 Troubleshooting Tips

- Start with the simplest checks.
- Verify physical connections first.
- Test using an IP address before a domain name.
- Compare the affected computer with a working one.
- Change only one setting at a time.
- Document every step.

---

# 🎯 Interview Questions

### What is the first thing you should check when a user reports no network connection?

**Answer**

Physical connectivity (network cable or Wi-Fi).

---

### What does an IP address starting with 169.254 mean?

**Answer**

The computer failed to obtain an IP address from the DHCP Server.

---

### If you can ping 8.8.8.8 but not google.com, what is the most likely issue?

**Answer**

DNS Resolution Problem.

---

### Which command clears the DNS cache?

```cmd
ipconfig /flushdns
```

---

### Which command requests a new IP address from DHCP?

```cmd
ipconfig /renew
```

---

# ✅ Summary

After completing this guide, you should be able to:

- Identify common network problems.
- Follow a structured troubleshooting methodology.
- Use Windows networking commands effectively.
- Diagnose IP, DNS, DHCP, and Gateway issues.
- Resolve basic connectivity problems in a professional IT environment.

---

🎉 **Congratulations!**

You have successfully completed the **Networking Fundamentals** module.
