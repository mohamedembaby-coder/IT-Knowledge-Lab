# 🧪 Networking Fundamentals Lab Guide

> Practical hands-on labs to practice Networking Fundamentals.

---

# 📋 Lab Objectives

After completing these labs, you will be able to:

- Identify your network configuration.
- Test connectivity.
- Understand IP addressing.
- Use common networking commands.
- Troubleshoot simple network problems.

---

# 💻 Lab 1 – View Your Network Information

## Objective

Display your computer's network configuration.

---

## Windows

Open **Command Prompt** and run:

```cmd
ipconfig
```

### Expected Output

- IPv4 Address
- Subnet Mask
- Default Gateway

---

For detailed information:

```cmd
ipconfig /all
```

You will also see:

- MAC Address
- DNS Servers
- DHCP Status
- Adapter Name

---

## Questions

- What is your IPv4 Address?
- What is your Default Gateway?
- Is DHCP Enabled?

---

# 🏓 Lab 2 – Test Network Connectivity

## Objective

Verify that another device is reachable.

Run:

```cmd
ping 8.8.8.8
```

Expected result:

```text
Reply from 8.8.8.8
```

---

Now test DNS:

```cmd
ping google.com
```

---

## Discussion

If the IP works but the domain name fails, the issue is probably related to **DNS**.

---

# 🌍 Lab 3 – Discover Your Public IP

Open a browser and visit:

https://whatismyipaddress.com

Compare it with your local IP address.

### Questions

- What is your Private IP?
- What is your Public IP?
- Why are they different?

---

# 🧭 Lab 4 – Trace the Route

Run:

```cmd
tracert google.com
```

Observe:

- Number of hops
- Response time
- Final destination

---

# 🔍 Lab 5 – DNS Lookup

Run:

```cmd
nslookup google.com
```

Observe:

- DNS Server
- Resolved IP Address

---

# 📡 Lab 6 – Display ARP Cache

Run:

```cmd
arp -a
```

Observe:

- IP Address
- MAC Address
- Interface

---

# 🌐 Lab 7 – Display Active Connections

Run:

```cmd
netstat -an
```

Observe:

- Local Address
- Remote Address
- Listening Ports
- Established Connections

---

# 🔥 Lab 8 – Simulate a Network Problem

Disconnect the network cable (or disable Wi-Fi).

Run:

```cmd
ping 8.8.8.8
```

Reconnect the cable.

Run the command again.

### Observe

How does the output change?

---

# 📊 Lab Checklist

| Task | Completed |
|-------|-----------|
| View IP Configuration | ☐ |
| View Detailed Configuration | ☐ |
| Ping Local Network | ☐ |
| Ping Internet | ☐ |
| Trace Route | ☐ |
| DNS Lookup | ☐ |
| View ARP Cache | ☐ |
| View Active Connections | ☐ |

---

# 💡 Best Practices

- Always verify physical connections first.
- Check the IP configuration before troubleshooting.
- Test connectivity using both IP addresses and domain names.
- Record command outputs while troubleshooting.
- Start with simple checks before assuming complex failures.

---

# 🎯 Challenge

Answer the following:

1. What is your IPv4 Address?
2. What is your Default Gateway?
3. What DNS Server are you using?
4. What is your MAC Address?
5. Can you successfully ping 8.8.8.8?
6. How many hops does `tracert google.com` show?

---

🎉 Congratulations!

You have completed the Networking Fundamentals Lab.
