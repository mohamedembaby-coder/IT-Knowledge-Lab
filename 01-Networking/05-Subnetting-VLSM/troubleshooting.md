# Subnetting Troubleshooting | تشخيص أخطاء Subnetting

## Workflow | المنهجية

1. اجمع IP، prefix/mask، gateway، VLAN/VRF، DHCP lease، ووقت المشكلة.
2. أعد حساب Network/Broadcast للعنوان المتأثر.
3. افحص local subnet والـ ARP ثم gateway، وبعدها route وACL وDNS.
4. قارن endpoints المتناظرة؛ كثير من الأعطال mask أو return-path mismatch.
5. غيّر قيمة واحدة، اختبر، وسجّل rollback plan.

## Enterprise Scenarios

| العرض | السبب المحتمل | الدليل | المعالجة |
|---|---|---|---|
| Host لا يصل إلى gateway | Wrong mask أو gateway خارج subnet | `ipconfig /all`, ARP، `show ip interface` | صحح mask/gateway وVLAN ثم renew DHCP. |
| بعض الأجهزة تعمل وبعضها لا | DHCP scope overlap أو duplicate IP | DHCP bindings، ARP MAC changes، IPAM | افصل scopes، احجز infrastructure، عالج duplicate. |
| Same subnet يمر، remote لا يمر | Default gateway أو routing خاطئ | route print، `show ip route` | صحح gateway وconnected/return route. |
| Broadcast مستخدم كـ host | Off-by-one في الحساب | قارن range وbroadcast | استخدم أول/آخر usable صحيح. |
| VLSM subnets متداخلة | تخصيص دون ترتيب/alignment | IPAM وbinary comparison | أعد التخصيص الأكبر أولاً. |
| DHCP clients mask خاطئ | `network` أو option 1 غير صحيح | `show ip dhcp pool`, client lease | صحح pool mask وrenew lease. |
| Summary route يسقط traffic | Summary يغطي prefix غير موجود | route lookup، traceroute | اجعل summary aligned ومحدوداً. |
| Summary غير صالح | الشبكات ليست power of two أو البداية غير aligned | binary boundary check | استخدم summary صحيحاً أو عدة summaries. |
| Connected route غائبة | Interface down أو IP/mask غير صالح | `show ip interface brief`, logs | أصلح Layer 1/2 وaddressing ثم `no shutdown`. |

## Cisco Checks

```cisco
show ip interface brief
show interfaces counters errors
show running-config interface GigabitEthernet0/1
show ip route connected
show ip arp
show ip dhcp pool
show ip dhcp binding
show vlan brief
```

## Windows Checks

```powershell
Get-NetIPConfiguration
Get-NetIPAddress -AddressFamily IPv4
Get-NetRoute -AddressFamily IPv4
arp -a
ipconfig /all
ipconfig /renew
Test-NetConnection 10.50.1.1 -InformationLevel Detailed
```

أرسل إلى Network/Security team: source/destination، exact mask، gateway، VLAN، DHCP lease، route output، ARP، traceroute، affected scope، ووقت التغيير. لا ترسل credentials أو customer data.
