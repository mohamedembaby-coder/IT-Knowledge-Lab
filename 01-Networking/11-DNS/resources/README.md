# DNS Operations Resources | موارد تشغيل DNS

## Change Record Minimum

وثّق FQDN, zone/view, record type/value/TTL, owner, business reason, ticket, approval, change window، وrollback. للـ delegation/conditional forwarder وثّق NS/target IPs وfirewall paths وtest result من كل network view.

## Monitoring Signals

| Signal | Why it matters |
|---|---|
| Query latency/timeouts | resolver capacity or path failure. |
| `SERVFAIL`, `REFUSED`, NXDOMAIN rate | dependency/policy/typo or attack indicators. |
| Cache hit ratio | sizing/tuning signal, not success metric alone. |
| Zone transfer/replication status | authoritative consistency. |
| TCP fallback/TC responses | firewall and response-size compatibility. |

## Capture Checklist

Record time zone, client/resolver IP, FQDN/type, query ID, UDP/TCP, flags, RCODE, answer TTL, and anonymized packet excerpt. Treat internal names, TXT data, and client addresses as sensitive.
