# Routing Lab Guide | دليل مختبر التوجيه

## الهدف | Objective

تكوين شبكة HQ وBranch، تطبيق static/default/floating routes، ثم مقارنة السلوك مع OSPF والتحقق من Longest Prefix Match وECMP بشكل آمن في Packet Tracer, CML, EVE-NG، أو أجهزة معزولة.

## Topology and Addressing

| Node | Interface / LAN | Address |
|---|---|---|
| R1-HQ | G0/0 to R2 | `192.0.2.1/30` |
| R2-Branch | G0/0 to R1 | `192.0.2.2/30` |
| R1-HQ | HQ LAN | `10.10.10.1/24` |
| R2-Branch | Branch LAN | `10.20.20.1/24` |
| Windows client | Branch LAN | `10.20.20.10/24`, gateway `10.20.20.1` |

## Part 1: Base Connectivity

1. Configure the interfaces, descriptions, addresses, and `no shutdown` on R1/R2.
2. Verify both WAN interface states with `show ip interface brief`.
3. Ping the directly connected peer addresses from each router.

```cisco
R1(config)# interface g0/0
R1(config-if)# ip address 192.0.2.1 255.255.255.252
R1(config-if)# no shutdown
R1(config)# interface g0/1
R1(config-if)# ip address 10.10.10.1 255.255.255.0
R1(config-if)# no shutdown
```

## Part 2: Static Routes and Default Route

Configure reachability between LANs:

```cisco
R1(config)# ip route 10.20.20.0 255.255.255.0 192.0.2.2
R2(config)# ip route 10.10.10.0 255.255.255.0 192.0.2.1
```

On R2, replace the specific route with a default route and confirm it still reaches HQ:

```cisco
R2(config)# no ip route 10.10.10.0 255.255.255.0 192.0.2.1
R2(config)# ip route 0.0.0.0 0.0.0.0 192.0.2.1
```

## Part 3: Longest Prefix Match

On R1, add a broad route and a more-specific test route. Do not use a reachable production prefix.

```cisco
R1(config)# ip route 10.20.0.0 255.255.0.0 192.0.2.2
R1(config)# ip route 10.20.20.0 255.255.255.0 192.0.2.2
R1# show ip route 10.20.20.10
```

Document that `/24` wins over `/16`, even if the broader route were learned from a lower-AD source.

## Part 4: OSPF Migration

Remove the LAN static routes, retain only the lab management route if required, then configure OSPF area 0:

```cisco
R1(config)# router ospf 10
R1(config-router)# router-id 1.1.1.1
R1(config-router)# network 192.0.2.0 0.0.0.3 area 0
R1(config-router)# network 10.10.10.0 0.0.0.255 area 0

R2(config)# router ospf 10
R2(config-router)# router-id 2.2.2.2
R2(config-router)# network 192.0.2.0 0.0.0.3 area 0
R2(config-router)# network 10.20.20.0 0.0.0.255 area 0
```

Verify `show ip ospf neighbor`, `show ip route ospf`, then end-to-end ping and traceroute. Confirm the return route; one-way forwarding is not success.

## Part 5: Floating Static Backup

Add a backup route only after the preferred OSPF path is verified:

```cisco
R1(config)# ip route 10.20.20.0 255.255.255.0 192.0.2.2 200
```

Shut the OSPF-facing test interface only in the lab. Observe the static route installation, restore the interface, and verify OSPF reclaims forwarding. Record convergence and restoration behaviour.

## Windows Verification

```powershell
Get-NetRoute -AddressFamily IPv4
Test-NetConnection 10.10.10.1 -TraceRoute
ping 10.10.10.1
```

## Success Criteria and Cleanup

- Each router has connected networks and exactly the expected learned/static routes.
- HQ and Branch hosts communicate in both directions.
- OSPF neighbor reaches `FULL`; floating route appears only when intended.
- Remove lab routes/processes or restore the saved baseline configuration after testing.
