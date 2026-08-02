# Subnetting & VLSM Diagrams | مخططات التقسيم

## IPv4 Bit Boundary

```mermaid
flowchart LR
    N[Network bits\nCIDR prefix] --> S[Subnet boundary\nmask]
    S --> H[Host bits\nusable addresses]
    H --> B[Broadcast\nall host bits = 1]
```

## Address Calculation Flow

```mermaid
flowchart TD
    I[IPv4 address + prefix] --> M[Convert prefix to subnet mask]
    M --> O[Find interesting octet]
    O --> Z[Block size = 256 - mask octet]
    Z --> R[Find containing range]
    R --> NW[Network = range start]
    R --> BC[Broadcast = next range - 1]
    NW --> U[Usable: Network + 1 .. Broadcast - 1]
    BC --> U
```

## VLSM Allocation

```mermaid
flowchart LR
    B[Enterprise block\n10.50.0.0/23] --> S[Sort requirements\nlargest to smallest]
    S --> D[Data Center\n/24]
    D --> U[Users\n/25]
    U --> V[Voice\n/26]
    V --> G[Management\n/27]
    G --> W[WAN transit\n/30]
    W --> R[Reserve aligned space\nfor growth]
```

## Enterprise Segmentation

```mermaid
flowchart TB
    CORE[Enterprise Core / L3 Routing] --> DC[Data Center\n10.50.0.0/24]
    CORE --> USERS[Corporate Users\n10.50.1.0/25]
    CORE --> VOICE[Voice VLAN\n10.50.1.128/26]
    CORE --> MGMT[Management\n10.50.1.192/27]
    CORE --> WAN[Point-to-point transit\n10.50.1.224/30]
    USERS --> FW[Firewall policy boundary]
    VOICE --> FW
```

## Route Summarization Boundary

```mermaid
flowchart LR
    A[10.20.0.0/24] --> S[Summary boundary\n10.20.0.0/22]
    B[10.20.1.0/24] --> S
    C[10.20.2.0/24] --> S
    D[10.20.3.0/24] --> S
    S --> R[Upstream router\none summary route]
```

Summary is valid only when prefixes are contiguous and the summary start is binary-aligned.
