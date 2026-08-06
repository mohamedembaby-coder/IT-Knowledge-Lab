# DHCP Commands | أوامر DHCP

> نفّذ تغييرات DHCP ضمن change control وبعد حفظ configuration. الأمثلة تستخدم documentation/private addresses ولا تُنسخ إلى production دون مراجعة scope، VLAN، وsecurity policy.

## Cisco IOS: DHCP Server and Verification

```cisco
configure terminal
 ip dhcp excluded-address 10.10.10.1 10.10.10.49
 ip dhcp pool USERS-10
  network 10.10.10.0 255.255.255.0
  default-router 10.10.10.1
  dns-server 10.10.100.10 10.10.100.11
  domain-name corp.example
  lease 8
end
show ip dhcp pool
show ip dhcp binding
show ip dhcp conflict
show running-config | section ^ip dhcp
```

للحجز في IOS، استخدم client identifier الذي يراه الجهاز؛ تحقّق من format في `show ip dhcp binding` قبل كتابة configuration:

```cisco
configure terminal
 ip dhcp pool PRINTER-01
  host 10.10.10.60 255.255.255.0
  client-identifier 0100.1122.3344.55
  default-router 10.10.10.1
end
```

## Cisco IOS: Relay (IP Helper)

```cisco
configure terminal
 interface Vlan10
  ip address 10.10.10.1 255.255.255.0
  ip helper-address 10.10.100.20
end
show running-config interface Vlan10
ping 10.10.100.20 source Vlan10
```

ضع `ip helper-address` على L3 gateway لكل client VLAN. تأكد من routes وACL/VRF في الاتجاهين؛ لا تحتاج access ports إلى helper.

## Cisco IOS: DHCP Snooping

```cisco
configure terminal
 ip dhcp snooping
 ip dhcp snooping vlan 10,20,30
 interface GigabitEthernet1/0/48
  description Uplink-to-DHCP-Relay-or-Server
  ip dhcp snooping trust
 interface GigabitEthernet1/0/10
  ip dhcp snooping limit rate 15
end
show ip dhcp snooping
show ip dhcp snooping binding
show ip dhcp snooping statistics
```

## Windows Server DHCP PowerShell

```powershell
Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerInDC -DnsName 'dhcp01.corp.example' -IPAddress '10.10.100.20'
Add-DhcpServerv4Scope -Name 'USERS-10' -StartRange 10.10.10.50 -EndRange 10.10.10.220 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -ScopeId 10.10.10.0 -Router 10.10.10.1 -DnsServer 10.10.100.10,10.10.100.11 -DnsDomain 'corp.example'
Add-DhcpServerv4ExclusionRange -ScopeId 10.10.10.0 -StartRange 10.10.10.1 -EndRange 10.10.10.49
Get-DhcpServerv4Scope
Get-DhcpServerv4ScopeStatistics
Get-DhcpServerv4Lease -ScopeId 10.10.10.0
```

`Add-DhcpServerInDC` يتطلب AD permissions وDNS name صحيحاً. راجع authorization وscope state قبل تشخيص relay أو clients.

## Windows Client

```powershell
ipconfig /all
ipconfig /release
ipconfig /renew
Get-NetIPConfiguration
Get-DnsClientServerAddress -AddressFamily IPv4
Get-WinEvent -LogName System -MaxEvents 100 | Where-Object ProviderName -Match 'Dhcp'
```

## Linux: Kea and Client Verification

```bash
sudo systemctl status kea-dhcp4
sudo journalctl -u kea-dhcp4 -n 100 --no-pager
sudo kea-dhcp4 -t /etc/kea/kea-dhcp4.conf
ip -4 addr show
sudo dhclient -v -r eth0
sudo dhclient -v eth0
sudo tcpdump -ni eth0 -vv 'udp port 67 or udp port 68'
```

مسارات وأوامر Kea قد تختلف حسب distribution/package؛ اختبر syntax ولا تعِد تشغيل الخدمة قبل أخذ نسخة configuration والتحقق من service name.

## Linux: ISC DHCP (Legacy Reference)

مثال مختصر لـ `dhcpd.conf`، مناسب فقط لبيئة legacy/lab. اجعل الخدمة تستمع إلى interface المقصود وفق إعدادات نظام التشغيل، ولا تنسَ أن relay سيجعل الخادم يختار subnet من معلومات relay.

```conf
authoritative;
default-lease-time 28800;
max-lease-time 86400;

subnet 10.10.10.0 netmask 255.255.255.0 {
  range 10.10.10.50 10.10.10.220;
  option routers 10.10.10.1;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.10.100.10, 10.10.100.11;
  option domain-name "corp.example";
}
```

```bash
sudo dhcpd -t -cf /etc/dhcp/dhcpd.conf
sudo systemctl status isc-dhcp-server
sudo journalctl -u isc-dhcp-server -n 100 --no-pager
```

اسم service وbinary قد يكونان `dhcpd` أو `isc-dhcp-server` حسب distribution. لا تشغّل ISC DHCP وKea على UDP/67 وinterface نفسيهما.

## Windows Server: Reservation and Failover Checks

```powershell
Add-DhcpServerv4Reservation -ScopeId 10.10.10.0 -IPAddress 10.10.10.60 -ClientId '00-11-22-33-44-55' -Name 'PRINTER-01'
Get-DhcpServerv4Reservation -ScopeId 10.10.10.0
Get-DhcpServerv4Failover
Get-DhcpServerv4FailoverStatistics
```

تأكد من client identifier الفعلي قبل إنشاء reservation؛ قد لا يكون مجرد MAC بالشكل المتوقع. أنشئ أو غيّر failover فقط وفق نافذة تغيير وخطة recovery مختبرة.

## Wireshark Display Filters

```text
dhcp || bootp
udp.port == 67 || udp.port == 68
bootp.option.dhcp == 1
bootp.option.dhcp == 5
bootp.option.dhcp == 6
bootp.option.dhcp == 3
```

افحص transaction ID، `yiaddr`، Option 54، Option 3/6، `giaddr`، ورسالة ACK/NAK. لا تشارك packet captures تحتوي MACs أو hostnames أو internal addressing خارج القنوات المعتمدة.

لـ DHCPv6 استخدم:

```text
dhcpv6 || udp.port == 546 || udp.port == 547
icmpv6.type == 134
```

اطابق client DUID وIA_NA/IA_PD مع relay-forward/reply ورسائل Router Advertisement؛ gateway الافتراضي مصدره RA، لا DHCPv6.
