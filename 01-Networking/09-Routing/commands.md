# Routing Commands | أوامر التوجيه

> نفّذ أوامر configuration ضمن نافذة تغيير مع نسخة احتياطية من الإعداد، واستخدم عناوين المختبر فقط في الأمثلة.

## Cisco IOS Verification

```cisco
show ip interface brief
show ip route
show ip route 10.20.30.10
show ip route static
show ip cef 10.20.30.10 detail
show arp
ping 192.0.2.2 source GigabitEthernet0/0
traceroute 10.20.30.10
show running-config | include ^ip route
```

`show ip route` يعرض الـ RIB، بينما `show ip cef` يفحص forwarding information المستخدم فعلياً. استخدم source ping لتمثيل source interface الصحيح والعودة المتوقعة.

## Cisco IOS Static, Default, and Floating Routes

```cisco
configure terminal
 ip route 10.20.30.0 255.255.255.0 192.0.2.2
 ip route 0.0.0.0 0.0.0.0 192.0.2.1
 ip route 0.0.0.0 0.0.0.0 198.51.100.1 200
end
show ip route 0.0.0.0
```

Remove a route explicitly after validating the exact prefix and next hop:

```cisco
configure terminal
 no ip route 10.20.30.0 255.255.255.0 192.0.2.2
end
```

## Cisco IOS Dynamic Routing Verification

```cisco
show ip ospf neighbor
show ip ospf interface brief
show ip protocols
show ip eigrp neighbors
show ip eigrp topology
show ip bgp summary
show ip bgp
show ip route ospf
```

استخدم debug بحذر شديد في production؛ يمكن أن يستهلك CPU أو يملأ logging. ابدأ دائماً بـ `show` commands وtelemetry.

## Cisco IOS OSPF Example

```cisco
configure terminal
 router ospf 10
  router-id 10.255.255.1
  passive-interface default
  no passive-interface GigabitEthernet0/0
  network 10.10.12.0 0.0.0.3 area 0
  network 10.10.10.0 0.0.0.255 area 0
end
show ip ospf neighbor
show ip route ospf
```

## Windows Server: Inspect and Configure Routes

```powershell
Get-NetIPConfiguration
Get-NetRoute -AddressFamily IPv4 | Sort-Object DestinationPrefix, RouteMetric
Get-NetRoute -DestinationPrefix '10.20.30.0/24'
Test-NetConnection 10.20.30.10 -TraceRoute
route print -4

# Persistent route through the correct LAN next hop
New-NetRoute -DestinationPrefix '10.20.30.0/24' -InterfaceIndex 12 `
  -NextHop '192.0.2.2' -RouteMetric 25 -PolicyStore PersistentStore
```

قبل `New-NetRoute`، تحقق من `InterfaceIndex` وdefault gateway الحالي. لا تستخدم Windows Server كـ router بين الشبكات إلا عند وجود تصميم، hardening، وfirewall policy واضحين.

## Windows Server Routing (RRAS) Example

```powershell
# Install the Routing role service; reboot/change-control may be required.
Install-WindowsFeature RemoteAccess, Routing -IncludeManagementTools

# Review IPv4 forwarding state after RRAS is configured through approved tooling.
Get-NetIPInterface -AddressFamily IPv4 | Select-Object InterfaceAlias, Forwarding
```

RRAS can provide LAN routing, NAT, and VPN services, but in most Enterprise designs a dedicated router/firewall remains the preferred routing boundary.
