
# OSI Model Diagrams | مخططات نموذج OSI

## Encapsulation and Decapsulation | التغليف وفك التغليف

```mermaid
sequenceDiagram
    participant C as Client
    participant SW as Switch
    participant R as Router
    participant S as Server
    C->>C: L7 data → L4 TCP segment → L3 IP packet → L2 frame
    C->>SW: Ethernet frame
    SW->>R: Forward by destination MAC
    R->>R: Remove old L2 frame; route by destination IP
    R->>S: New L2 frame, same end-to-end IP packet
    S->>S: Decapsulate frame → packet → segment → data
```

## Layer-by-Layer Troubleshooting | التشخيص الطبقي

```mermaid
flowchart TD
    A[User reports: application unavailable] --> B{L1: link and signal healthy?}
    B -->|No| C[Check cable, NIC, Wi-Fi, switch port]
    B -->|Yes| D{L2: correct VLAN and MAC learning?}
    D -->|No| E[Check access/trunk VLAN and STP]
    D -->|Yes| F{L3: valid IP, gateway, route?}
    F -->|No| G[Check DHCP, prefix, routing]
    F -->|Yes| H{L4: required port reachable?}
    H -->|No| I[Check ACL, firewall, listening service]
    H -->|Yes| J[L5-L7: DNS, TLS, authentication, application logs]
```
