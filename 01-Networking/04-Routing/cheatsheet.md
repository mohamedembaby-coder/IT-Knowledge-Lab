# Routing Cheatsheet | ملخص التوجيه

## Route Selection | اختيار المسار

`Longest Prefix Match` → lowest `Administrative Distance` → lowest `metric` → ECMP when eligible.

| Destination | Routes available | Winner | السبب |
|---|---|---|---|
| `10.10.20.25` | `10.10.0.0/16`, `10.10.20.0/24`, `0.0.0.0/0` | `10.10.20.0/24` | أطول prefix. |
| `172.16.1.10` | static `/24` AD 1, OSPF `/24` AD 110 | static | prefix متساوٍ وAD أقل. |
| `8.8.8.8` | `0.0.0.0/0` only | default | لا يوجد route أكثر تحديداً. |

## Cisco IOS Quick Reference

| Goal | Command |
|---|---|
| Display routing table | `show ip route` |
| Route lookup | `show ip route 10.20.30.10` |
| Show static routes | `show ip route static` |
| Show OSPF / EIGRP / BGP | `show ip route ospf` / `eigrp` / `bgp` |
| Add static route | `ip route PREFIX MASK NEXT-HOP` |
| Add default route | `ip route 0.0.0.0 0.0.0.0 NEXT-HOP` |
| Verify forwarding | `show ip cef PREFIX detail` |
| Test path | `traceroute IP` |
| Validate interfaces | `show ip interface brief` |

## Dynamic Protocol Snapshot

| Protocol | AD | Main metric / selection concept | Use carefully when |
|---|---:|---|---|
| RIP | 120 | Hop count | path exceeds 15 hops or modern scale is required. |
| OSPF | 110 | Cost | areas and adjacency design are unmanaged. |
| EIGRP internal | 90 | Composite metric | interoperability/policy requires another standard. |
| eBGP / iBGP | 20 / 200 | Path attributes / policy | used as a simple campus IGP. |

## Design Reminders | تذكيرات تصميمية

- Summarize only contiguous address blocks with the same forwarding direction.
- Use floating static routes with higher AD than the preferred path.
- ECMP needs equal-cost eligible paths; confirm hashing and return path symmetry.
- A route in the table is not enough: validate next-hop reachability, ARP/ND, interface state, and firewall policy.
- Document prefix, owner, next hop, AD/metric, protocol, change ticket, and rollback path.
