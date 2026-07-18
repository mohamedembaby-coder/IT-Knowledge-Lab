# Troubleshooting

| Problem | Cause | Solution |
|---------|-------|----------|
| No link light on the switch port | Damaged cable, wrong port, or NIC disabled | Replace cable, verify port, check NIC status (`ipconfig`/`ip addr`) |
| PC gets no IP address / APIPA (169.254.x.x) | Cable unplugged, DHCP server unreachable, or switch port down | Check physical connection first, then verify DHCP server/relay reachability |
| Intermittent connection drops | Cable exceeds max distance (100m for copper) or is damaged/bent sharply | Use a cable tester, replace cable, or add a repeater/switch if distance is an issue |
| Slow network speed on a link | Duplex mismatch or wrong cable category (e.g., Cat5 used for 10G link) | Match duplex settings on both ends, use the correct cable category for required speed |
| Fiber link completely down | Wrong fiber type paired (Single-Mode SFP with Multi-Mode fiber or vice versa), or dirty connector | Match SFP transceiver type to fiber type, clean connector with a proper fiber cleaning kit |

---

## Common Errors

- **CRC Errors** on an interface — usually indicates a bad cable or electrical interference (EMI).

- **Collisions** — normal in old Hub-based half-duplex networks, but abnormal (and a red flag) on a modern switched full-duplex network.

- **Duplex Mismatch** — one side set to Full-Duplex and the other to Half-Duplex, causing major performance issues and errors; always verify both ends match.

---

## References

- Cisco Troubleshooting Ethernet: https://www.cisco.com/c/en/us/support/docs/lan-switching/ethernet/10561-4.html
