# DNS Troubleshooting | استكشاف أخطاء DNS

## Evidence-First Workflow | منهجية مبنية على الدليل

1. سجّل FQDN، record type، client IP/VLAN، configured DNS servers، الوقت، والجواب المتوقع.
2. افحص reachability إلى resolver (`Test-NetConnection <server> -Port 53`) وclient DNS configuration قبل تغيير record.
3. Query resolver محدد باستخدام `Resolve-DnsName -Server` أو `dig @server`; احتفظ بـ response code والـ TTL والـ server.
4. قارن cache/resolver answer مع authoritative zone answer عند وجود صلاحية لذلك.
5. افحص zone health، record، delegation/forwarder، ACL/view، UDP/TCP 53، ثم packet capture.
6. غيّر شيئاً واحداً تحت change control، اختبر من نفس client ومن resolver آخر، ووثّق propagation/TTL.

## Symptom Matrix

| Symptom | Likely cause | Evidence | Safe resolution |
|---|---|---|---|
| All names timeout | wrong DNS IP, path/ACL, resolver down | no DNS response; port 53 fails | fix client DHCP/static DNS, routing/firewall, or resolver service. |
| One name returns `NXDOMAIN` | typo, missing record/zone, negative cache | resolver response + SOA authority | correct record/name; account for negative TTL. |
| `SERVFAIL` | upstream/delegation/DNSSEC/zone issue | resolver log; `dig +trace`; authoritative check | repair failing dependency; do not replace with random public DNS. |
| Internal answer differs externally | split DNS/view expectation or leak | queries from each vantage point | verify correct view/zone and intended exposure. |
| Forward works, reverse fails | missing/wrong PTR reverse zone | `dig -x`; reverse zone data | create/correct PTR and reverse zone/delegation. |
| AD join/logon discovery fails | SRV/DNS replication/site issue | `_ldap._tcp... SRV`, DC logs | repair AD DNS/SRV registration and replication. |
| Large reply fails but simple A works | TCP/53 blocked or UDP truncation | `TC=1`, no TCP retry/reply | allow TCP and UDP 53 end-to-end. |
| Conditional domain fails only | wrong forwarder suffix/IP/policy | direct query to forwarder vs local resolver | correct suffix, reachability, and forwarding policy. |
| New record “not visible” | cached old/negative answer or wrong zone/view | TTL, answer server, zone serial | wait/flush controlled caches; verify authoritative data. |
| BIND secondary stale | serial/transfer/ACL failure | `named` logs, SOA serial, transfer denial | increment serial, fix allow-transfer/TSIG and reload. |

## Focused Checks

```powershell
Get-DnsClientServerAddress
Resolve-DnsName app.corp.example -Server 10.10.100.10 -Type A
Resolve-DnsName _ldap._tcp.dc._msdcs.corp.example -Type SRV
Test-NetConnection 10.10.100.10 -Port 53
Get-WinEvent -LogName 'DNS Server' -MaxEvents 50
```

```bash
dig @10.10.100.10 app.corp.example A +noall +answer +comments
dig @10.10.100.10 -x 10.10.20.50 +noall +answer
dig @10.10.100.10 app.corp.example A +tcp
sudo named-checkconf
sudo journalctl -u named -n 100 --no-pager
```

```cisco
show running-config | include ^ip domain|^ip name-server
ping app.corp.example
show hosts
```

## Wireshark Analysis | تحليل Wireshark

Filter `dns` and follow a query by transaction ID plus five-tuple. Verify the client asked the intended resolver and the query type is correct. In the response, inspect `RCODE`, `AA` (authoritative), `RA` (recursion available), `RD` (recursion desired), `TC` (truncated), answer count, TTL, and authority section. `NXDOMAIN` with SOA is evidence, not automatically a network failure.

When UDP response has `TC=1`, expect client retry over TCP/53; a missing TCP handshake/reply points to firewall or listener policy. Compare client capture with resolver-side log/capture before blaming a server. Encrypted DNS may hide classic port-53 traffic; establish whether enterprise policy permits it.

## Escalation Package | بيانات التصعيد

Include FQDN/type/expected record, client network, resolver IP, timestamps/time zone, command output, response code/flags/TTL, authoritative-vs-recursive comparison, relevant zone/serial or Windows/BIND logs, capture sanitized for internal data, and recent DNS/network/security changes. Do not clear zones, delete records, or disable DNSSEC/security controls as a first response.
