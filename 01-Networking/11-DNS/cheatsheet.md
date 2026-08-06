# DNS Cheatsheet | ملخص DNS

## Ports and Roles

| Item | Quick fact |
|---|---|
| DNS | UDP `53` usually; TCP `53` for AXFR/IXFR and large/truncated replies. |
| Stub resolver | client sends recursive query to configured DNS server. |
| Recursive resolver | answers from cache, forwarder, or iterative hierarchy. |
| Authoritative server | owns zone data and answers with AA when applicable. |
| Root → TLD → authoritative | delegation hierarchy used during resolution. |

## Record Map

| Record | Remember |
|---|---|
| `A` / `AAAA` | IPv4 / IPv6 address |
| `CNAME` | alias; cannot coexist with other data at same name |
| `MX` | mail hostname + preference |
| `PTR` | reverse IP-to-name |
| `NS` | delegation/name server |
| `TXT` | policy/verification text |
| `SRV` | service: priority, weight, port, target |
| `SOA` | zone control and negative-cache policy |

## Fast Commands

```powershell
Resolve-DnsName app.corp.example -Type A -Server 10.10.100.10
Resolve-DnsName _ldap._tcp.dc._msdcs.corp.example -Type SRV
ipconfig /displaydns
```

```bash
dig @10.10.100.10 app.corp.example A +noall +answer
dig @10.10.100.10 -x 10.10.20.50 +noall +answer
dig @10.10.100.10 app.corp.example A +trace
```

```cisco
ip name-server 10.10.100.10 10.10.100.11
ip domain lookup
ping app.corp.example
```

## Troubleshooting Sequence

1. Confirm name, type, client DNS server, and expected answer.
2. Query the configured resolver, then authoritative server if appropriate.
3. Compare response code, flags, TTL, and answer/authority sections.
4. Check cache, zone/record, conditional forwarder/delegation, then path/ACL.
5. Capture DNS and test UDP **and** TCP `53` when response size/transfer matters.

## CCNA Anchors

- TTL is cache lifetime, not query timeout.
- `NXDOMAIN` means name absent; `SERVFAIL` means server failed to resolve/process.
- `ip name-server` configures an IOS DNS client.
- Split DNS provides different internal/external answers; conditional forwarding chooses resolver by suffix.
