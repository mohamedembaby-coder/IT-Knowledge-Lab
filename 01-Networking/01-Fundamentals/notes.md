# Notes

## Key Concepts

- A network's **topology** (physical layout) is different from its **architecture** (logical design like 3-Tier or Spine-Leaf) — don't confuse the two in the CCNA exam.

- Every network device works at a specific OSI layer: Hub = L1, Switch = L2, Router = L3. Knowing the layer tells you exactly what information the device uses to make decisions (electrical signal, MAC address, or IP address).

- Modern NICs support **Auto-MDIX**, which means you rarely need to manually pick Straight-Through vs Crossover cables anymore — but it's still a common exam/interview question.

---

## Things to Remember

- Single-Mode fiber (yellow jacket) = long distance, uses laser light. Multi-Mode fiber (orange/aqua jacket) = short distance, uses LED light. Mixing them on the same link will not work.

- A Switch creates a separate **collision domain** per port but all ports remain in the same **broadcast domain** (unless VLANs are used).

- SOHO networks typically combine Router + Switch + Access Point + Firewall functions into a single device — this is different from enterprise networks where each function is a dedicated device.

---

## Best Practices

- Always label physical cables at both ends in a real deployment (huge time-saver for troubleshooting later).

- Document the physical topology (which port connects to which device) — this is exactly what the `diagrams/` folder in this vault is for.

- When troubleshooting connectivity, always start at Layer 1 (Physical) before assuming it's a software/configuration issue — check link lights and cabling first.
