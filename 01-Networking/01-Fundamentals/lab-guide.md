# Lab Guide

## Objective

Build a simple small-office (SOHO) network topology in Cisco Packet Tracer, identify each device's role, and verify end-to-end connectivity using the commands from `commands.md`.

---

## Requirements

- Hardware: (Simulated) 1 Router, 1 Switch, 3 PCs
- Software: Cisco Packet Tracer (free from Cisco NetAcad)
- Network: A single LAN segment, e.g., 192.168.1.0/24

---

## Steps

1. Open Packet Tracer and place 1 Router, 1 Switch, and 3 PCs on the canvas.
2. Connect PC1, PC2, and PC3 to the Switch using **Copper Straight-Through** cables.
3. Connect the Switch to the Router using a **Copper Straight-Through** cable (Auto-MDIX handles it automatically on modern devices).
4. Assign static IPs to each PC: PC1 = 192.168.1.10, PC2 = 192.168.1.11, PC3 = 192.168.1.12, all with subnet mask 255.255.255.0 and default gateway 192.168.1.1.
5. Configure the router's interface (e.g., `g0/0`) with IP 192.168.1.1/24 and bring it up (`no shutdown`).

---

## Verification

- From PC1, `ping 192.168.1.11` (PC2) → should succeed (same LAN, via switch).
- From PC1, `ping 192.168.1.1` (Router) → should succeed.
- From PC1, `arp -a` → should show the MAC addresses of the Router and PC2 after pinging them.
- Check the link lights (green) on all cable connections in Packet Tracer — a red X icon means the physical link is down (wrong cable type or port shut down).

---

## Cleanup

- If this is a shared/reused lab file, remove any test static IPs before saving as a template for the next lab.
- Save the `.pkt` file inside `labs/` for future reference.


---

# Lab 1 - Verify Basic Connectivity

## Objective
Learn basic connectivity testing.

## Steps

1. Open Command Prompt.
2. Run `ipconfig /all`
3. Identify IPv4, Gateway and DNS.
4. Ping your gateway.
5. Ping 8.8.8.8.
6. Ping google.com.
7. Compare the results.

## Questions

- Why can IP ping succeed while DNS ping fails?
- What happens if the default gateway is missing?
