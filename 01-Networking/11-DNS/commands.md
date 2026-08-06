# DNS Commands | أوامر DNS

> استخدم names وعناوين documentation داخل الأمثلة. اجمع evidence قبل تغيير records أو flushing caches، ولا تنشر internal hostnames أو captures خارج القنوات المعتمدة.

## Cisco IOS: DNS Client

```cisco
configure terminal
 ip domain name corp.example
 ip name-server 10.10.100.10 10.10.100.11
 ip domain lookup
end

show running-config | include ^ip domain|^ip name-server
ping app.corp.example
traceroute app.corp.example
```

`ip name-server` يجعل IOS يستخدم resolvers المحددة للـ CLI features مثل ping بالاسم؛ ليس DHCP/DNS server configuration. إن كان typo في CLI يسبب lookup delay، قد تستخدم `no ip domain lookup` كقرار تشغيل مدروس، لكن لا تعطل DNS client بلا سبب.

## Windows Client: Query and Cache

```powershell
Get-DnsClientServerAddress -AddressFamily IPv4
Resolve-DnsName app.corp.example -Type A
Resolve-DnsName app.corp.example -Type AAAA -Server 10.10.100.10
Resolve-DnsName 50.20.10.10.in-addr.arpa -Type PTR -Server 10.10.100.10
Resolve-DnsName _ldap._tcp.dc._msdcs.corp.example -Type SRV
ipconfig /displaydns
ipconfig /flushdns
```

استخدم `-Server` لعزل DNS server المقصود من المشكلة. نفّذ `ipconfig /flushdns` فقط بعد تسجيل الحالة أو عند اختبار change معروف؛ لا يعالج server-side cache أو authoritative data.

## Windows Server DNS: Zones, Records, and Health

```powershell
Install-WindowsFeature DNS -IncludeManagementTools
Add-DnsServerPrimaryZone -Name 'corp.example' -ReplicationScope 'Domain' -DynamicUpdate Secure
Add-DnsServerPrimaryZone -NetworkId '10.10.20.0/24' -ReplicationScope 'Domain' -DynamicUpdate Secure
Add-DnsServerResourceRecordA -ZoneName 'corp.example' -Name 'app' -IPv4Address '10.10.20.50' -TimeToLive 01:00:00
Add-DnsServerResourceRecordPtr -ZoneName '20.10.10.in-addr.arpa' -Name '50' -PtrDomainName 'app.corp.example.'
Add-DnsServerConditionalForwarderZone -Name 'partner.example' -MasterServers 192.0.2.53,192.0.2.54 -ReplicationScope 'Forest'
Get-DnsServerZone
Get-DnsServerResourceRecord -ZoneName 'corp.example' -Name 'app'
Test-DnsServer -IPAddress 10.10.100.10 -ZoneName 'corp.example'
```

AD-integrated/secure settings require an appropriate domain environment and permissions. Confirm the reverse-zone name before adding PTR: for `10.10.20.0/24` it is `20.10.10.in-addr.arpa`.

## BIND 9: Validate, Reload, Query

```bash
sudo named-checkconf
sudo named-checkzone corp.example /etc/bind/db.corp.example
sudo rndc reload corp.example
sudo rndc status
sudo journalctl -u named -n 100 --no-pager
dig @127.0.0.1 app.corp.example A +noall +answer +authority
dig @127.0.0.1 -x 10.10.20.50 +noall +answer
dig @10.10.100.10 app.corp.example A +stats
dig @10.10.100.10 app.corp.example A +trace
```

Service name/path varies (`bind9` vs `named`, `/etc/bind` vs `/var/named`). Check syntax and zone data before reload; `+trace` is diagnostic and can bypass the normal resolver path, so do not treat it as an end-user test.

## dig, nslookup, and Network Evidence

```bash
dig @10.10.100.10 mail.corp.example MX +noall +answer
dig @10.10.100.10 corp.example NS +noall +answer
dig @10.10.100.10 txt.corp.example TXT +noall +answer
dig @10.10.100.10 _sip._tcp.corp.example SRV +noall +answer
nslookup -type=PTR 10.10.20.50 10.10.100.10
nslookup -type=MX corp.example 10.10.100.10
sudo tcpdump -ni eth0 -vv 'port 53'
```

`nslookup` remains useful for quick interactive checks, but `Resolve-DnsName`/`dig` expose types, server choice, flags, and sections more clearly. Capture on the client, resolver, or firewall path—not indiscriminately on production segments.

## Wireshark Display Filters

```text
dns
udp.port == 53 || tcp.port == 53
dns.qry.name == "app.corp.example"
dns.flags.response == 1
dns.flags.rcode == 3
dns.flags.truncated == 1
```

Inspect query name/type, source/destination, transaction ID, flags (`RD`, `RA`, `AA`, `TC`), response code, answer TTL, and UDP vs TCP retry. DNS payload can expose internal names and metadata.
