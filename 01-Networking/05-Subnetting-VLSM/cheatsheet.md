# Subnetting & VLSM Cheatsheet | ملخص سريع

## Fast Formulas | المعادلات السريعة

| المطلوب | Formula |
|---|---|
| Usable hosts | `2^h - 2` حيث `h` = host bits |
| Total addresses | `2^h` |
| Prefix | `32 - h` |
| Block size | `256 - mask octet` |
| Network | بداية الـ range الذي يحتوي العنوان |
| Broadcast | بداية subnet التالية − 1 |
| Usable range | Network + 1 إلى Broadcast − 1 |

## Prefix Table

| CIDR | Mask | Hosts | Increment |
|---:|---|---:|---:|
| `/30` | `255.255.255.252` | 2 | 4 |
| `/29` | `255.255.255.248` | 6 | 8 |
| `/28` | `255.255.255.240` | 14 | 16 |
| `/27` | `255.255.255.224` | 30 | 32 |
| `/26` | `255.255.255.192` | 62 | 64 |
| `/25` | `255.255.255.128` | 126 | 128 |
| `/24` | `255.255.255.0` | 254 | 256 |
| `/23` | `255.255.254.0` | 510 | 512 |
| `/22` | `255.255.252.0` | 1022 | 1024 |

## Binary Weights

`128 64 32 16 8 4 2 1`

| Decimal | Binary |
|---:|---|
| 64 | `01000000` |
| 128 | `10000000` |
| 192 | `11000000` |
| 224 | `11100000` |
| 240 | `11110000` |
| 248 | `11111000` |
| 252 | `11111100` |
| 254 | `11111110` |
| 255 | `11111111` |

## Worked Example

`172.16.35.201/20` → mask `255.255.240.0`, interesting octet = third, increment = 16. Ranges: `0–15`, `16–31`, `32–47`; network `172.16.32.0`, broadcast `172.16.47.255`, usable `172.16.32.1–172.16.47.254`.

## VLSM Order

1. Sort requirements largest to smallest.
2. Allocate the smallest valid power-of-two block.
3. Start the next subnet at the next aligned boundary.
4. Record prefix, mask, broadcast, gateway, DHCP scope, owner, and growth reserve.

## CCNA Reminders

- `/31` is commonly used for point-to-point links; `/32` is a host route.
- `10.0.0.0/8`, `172.16.0.0/12`, and `192.168.0.0/16` are private IPv4 ranges.
- Network and broadcast addresses are not normal host assignments.
- CIDR prefix length, not Class A/B/C, determines the modern subnet boundary.
