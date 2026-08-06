# DNS Lab Guide | دليل مختبر DNS

## الهدف | Objective

بناء DNS design صغير للمؤسسة: forward/reverse zone، resolver client، conditional forwarder، وcapture لتحليل recursive lookup. نفّذ فقط في Packet Tracer/CML/EVE-NG أو شبكة معزولة. لا تستخدم domain حقيقي أو public records أثناء التدريب.

## Topology and Addressing

| Node | Address | Role |
|---|---|---|
| DNS01 | `10.10.100.10/24` | Windows DNS أو BIND 9 authoritative/recursive resolver |
| DNS02 | `10.10.100.11/24` | secondary/alternate resolver (optional) |
| R1 | `10.10.20.1/24` | client VLAN gateway; IOS DNS client test |
| Client01 | DHCP/static | DNS client in `10.10.20.0/24` |
| Partner DNS | `192.0.2.53` | simulated conditional forwarder target |

Use `corp.example` only as a lab namespace. Create `app.corp.example → 10.10.20.50`, `mail.corp.example → 10.10.20.60`, and reverse PTR for `10.10.20.50`.

## Part 1: Windows Server DNS (Option A)

```powershell
Install-WindowsFeature DNS -IncludeManagementTools
Add-DnsServerPrimaryZone -Name 'corp.example' -ReplicationScope 'Domain' -DynamicUpdate Secure
Add-DnsServerPrimaryZone -NetworkId '10.10.20.0/24' -ReplicationScope 'Domain' -DynamicUpdate Secure
Add-DnsServerResourceRecordA -ZoneName 'corp.example' -Name 'app' -IPv4Address '10.10.20.50'
Add-DnsServerResourceRecordMX -ZoneName 'corp.example' -MailExchange 'mail.corp.example.' -Preference 10
Add-DnsServerResourceRecordPtr -ZoneName '20.10.10.in-addr.arpa' -Name '50' -PtrDomainName 'app.corp.example.'
```

If no AD exists, create a standard primary zone through DNS Manager or adapt the PowerShell options to your Windows version. Do not claim secure dynamic updates are configured unless the zone is AD-integrated.

## Part 2: BIND 9 (Option B)

Use `labs/named.conf.local` and `labs/db.corp.example` as a starting point. Copy them only into an isolated lab, update local paths/IPs, then validate:

```bash
sudo named-checkconf
sudo named-checkzone corp.example /etc/bind/db.corp.example
sudo rndc reload corp.example
dig @127.0.0.1 app.corp.example A +noall +answer
```

Choose **one** authoritative implementation for `corp.example`; do not let Windows DNS and BIND both act as unrelated primaries for the same production zone.

## Part 3: Client and Cisco IOS Verification

Set Client01 DNS to `10.10.100.10`, then query A, MX, PTR, and a deliberately absent name. On R1:

```cisco
configure terminal
 ip domain name corp.example
 ip name-server 10.10.100.10
 ip domain lookup
end
ping app.corp.example
```

On Windows client:

```powershell
Resolve-DnsName app.corp.example -Server 10.10.100.10 -Type A
Resolve-DnsName mail.corp.example -Server 10.10.100.10 -Type MX
Resolve-DnsName 50.20.10.10.in-addr.arpa -Server 10.10.100.10 -Type PTR
```

## Part 4: Conditional Forwarder and Split-DNS Discussion

Add a conditional forwarder for `partner.example` only if you have a simulated partner resolver. Verify local `corp.example` queries stay authoritative and `partner.example` queries are sent to the specified target. Then document a split-DNS design for `vpn.corp.example`: what internal answer, external answer, zone owner, and test sources would be needed. Do not create conflicting public/private data without that design.

## Part 5: Wireshark and Failure Drill

1. Capture on Client01, filter `dns`, and resolve `app.corp.example`.
2. Record query type, transaction ID, `RD/RA/AA` flags, answer IP, and TTL.
3. Query an absent name; record `NXDOMAIN`, authority SOA, and negative-cache behaviour.
4. In the lab only, stop the DNS service or block UDP/53 briefly. Repeat the query and identify timeout versus `SERVFAIL`.
5. Restore service/policy, clear only the test client cache if required, and record successful recovery.

## Success Criteria and Cleanup

- Forward A/MX and reverse PTR lookups return expected data from intended DNS server.
- Client and IOS use only the lab resolver.
- A nonexistent record demonstrates `NXDOMAIN` rather than an assumed “network outage”.
- Conditional forwarding (if built) matches only its configured suffix.
- Save sanitized capture/evidence, remove test zones/records or restore baseline, and re-enable any lab service/firewall rule changed.
