# Routing Diagrams | مخططات التوجيه

## Enterprise Forwarding Path

```mermaid
flowchart LR
    C[Windows Client\n10.20.20.10] -->|default gateway| B[R2 Branch\n10.20.20.1]
    B -->|OSPF / Static next hop| H[R1 HQ\n192.0.2.1]
    H -->|specific route or default route| F[Firewall / Edge]
    F --> A[Application\n10.10.10.50:443]
    A -. return route .-> C
```

## Route Selection Decision

```mermaid
flowchart TD
    P[IP packet arrives] --> M{Matching prefixes?}
    M -->|No| D{Default route present?}
    D -->|Yes| F[Forward via 0.0.0.0/0]
    D -->|No| U[Drop and generate ICMP unreachable if allowed]
    M -->|Yes| L[Choose longest prefix]
    L --> A{Same prefix length: multiple routes?}
    A -->|No| X[Install/forward selected route]
    A -->|Yes| AD[Choose lowest Administrative Distance]
    AD --> MET[Choose lowest protocol metric]
    MET --> ECMP{Equal-cost eligible paths?}
    ECMP -->|Yes| E[ECMP per-flow forwarding]
    ECMP -->|No| X
```

## Primary and Floating Static Failover

```mermaid
flowchart LR
    R[Branch Router] -->|Primary: AD 1 or OSPF AD 110| M[MPLS / Primary WAN]
    M --> H[HQ]
    R -. Backup static: AD 200, only when primary route removed .-> I[Internet VPN / LTE]
    I -.-> H
    T[IP SLA / Object Tracking] --> R
```

## Control Plane vs Data Plane

```mermaid
flowchart TB
    O[OSPF / EIGRP / BGP updates\nor static configuration] --> RIB[Routing Information Base\nBest route selection]
    RIB --> FIB[FIB / CEF]
    FIB --> D[Data-plane forwarding]
    D --> N[ARP or NDP for next hop\nLayer 2 rewrite]
    N --> W[Wire]
```

## OSPF Enterprise Area View

```mermaid
flowchart LR
    BR[Branch\nArea 10] --> ABR1[ABR]
    ABR1 --> BB[Backbone\nArea 0]
    BB --> ABR2[ABR]
    ABR2 --> DC[Data Center\nArea 20]
    SUM[Inter-area summary\n10.20.0.0/16] -. advertised by ABR .-> BB
```
