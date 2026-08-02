# Subnetting Commands | أوامر التحقق والتطبيق

## Cisco IOS Verification

```cisco
show ip interface brief
show interfaces GigabitEthernet0/1
show running-config interface GigabitEthernet0/1
show ip route
show ip route connected
show ip protocols
show ip arp
show ip dhcp pool
show ip dhcp binding
```

تحقق من الـ address وmask الفعليين على interface. `show ip route connected` يثبت أن الشبكة ظهرت كـ connected route.

## Cisco IOS Interface and DHCP

```cisco
configure terminal
 interface GigabitEthernet0/1
  description USERS-VLAN-20
  ip address 10.40.0.1 255.255.255.192
  no shutdown
 ip dhcp excluded-address 10.40.0.1 10.40.0.10
 ip dhcp pool USERS-VLAN-20
  network 10.40.0.0 255.255.255.192
  default-router 10.40.0.1
  dns-server 10.40.10.10
end
```

`network` و`default-router` يجب أن يتطابقا مع subnet الفعلية. لا تخلط `/26` (`.0–.63`) مع `/27` (`.0–.31`).

## Cisco IOS SVI

```cisco
interface Vlan30
 description MANAGEMENT
 ip address 10.40.0.193 255.255.255.224
 no shutdown
ip routing
```

## Windows PowerShell

```powershell
Get-NetIPConfiguration
Get-NetIPAddress -AddressFamily IPv4
Get-NetIPInterface -AddressFamily IPv4
Get-NetRoute -AddressFamily IPv4 | Sort-Object DestinationPrefix
route print -4
Test-NetConnection 10.40.0.1
```

## Windows Server Address Example

```powershell
New-NetIPAddress -InterfaceAlias 'Ethernet' -IPAddress 10.40.0.10 `
  -PrefixLength 26 -DefaultGateway 10.40.0.1
Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ServerAddresses 10.40.10.10
```

قبل التنفيذ تحقق من interface alias، DHCP state، وعدم وجود duplicate address. استخدم `Get-NetIPAddress` بعد التغيير.

## Linux Reference (Optional)

```bash
ip -4 addr show
ip route
ipcalc 192.168.50.77/27
```
