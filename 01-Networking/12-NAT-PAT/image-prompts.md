# NAT/PAT Illustration Prompts | مطالبات توليد الصور

Use these prompts with an approved image-generation system when a polished raster illustration is needed. Keep labels exact, use documentation networks only, and review generated text/IP addresses before publishing. For editable repository diagrams, prefer the accompanying SVG files in `images/`.

## Shared Art Direction

```text
Create a clean enterprise networking training infographic in a wide 16:9 layout. Use a light slate background, crisp vector-like shapes, accessible contrast, blue for inside/private networks, violet for NAT translation, and green for outside/public networks. Use modern sans-serif typography, generous spacing, directional arrows, and concise English labels with small Arabic subtitle labels where they remain legible. No vendor logos, no decorative server racks, no photorealism, no random text, and no real public IP addresses. Use only RFC 5737 documentation addresses.
```

## NAT Overview

```text
Enterprise networking education diagram explaining NAT overview. Show an inside client labeled 10.10.10.25, a NAT router/firewall, and an Internet web server labeled 198.51.100.80. At the NAT edge show the mapping 10.10.10.25 to 203.0.113.10. Clearly label inside local, inside global, outside global, and outside local. Add two clear packet arrows: outbound source translation and return traffic state match. Include a small Arabic subtitle: نظرة عامة على NAT. Follow the shared art direction.
```

## Static NAT

```text
Enterprise networking education diagram explaining static NAT one-to-one translation. Show an internal application server 10.10.20.50 permanently mapped to public address 203.0.113.50, with an external Internet client 198.51.100.25 initiating a connection to the public address. Emphasize permanent 1:1 mapping, inbound publishing, and a warning that NAT does not replace firewall policy. Add Arabic subtitle: ترجمة ثابتة 1:1. Follow the shared art direction.
```

## Dynamic NAT

```text
Enterprise networking education diagram explaining dynamic NAT using a finite public address pool. Show three private clients 10.10.10.21, .22, .23 and a NAT pool 203.0.113.100 through .102. Show .100 allocated to .21, .101 allocated to .22, and .102 available. Make clear that each simultaneous host needs a unique public address and show a short pool-exhaustion warning. Add Arabic subtitle: ترجمة ديناميكية من Pool. Follow the shared art direction.
```

## PAT Overload

```text
Enterprise networking education diagram explaining PAT/NAT overload. Show three private clients sharing one public IP 203.0.113.10. Display a compact translation table where different TCP source ports map to different translated ports: 10.10.10.21:49152 to 203.0.113.10:30001, .22:49153 to :30002, and .23:49154 to :30003. Destination is 198.51.100.80:443. Emphasize that ports and protocol distinguish flows and mention port/state capacity. Add Arabic subtitle: ترجمة العناوين مع المنافذ. Follow the shared art direction.
```

## Packet Translation Flow

```text
Create a six-step enterprise networking packet-flow diagram for PAT. Outbound: client packet source 10.10.10.25:51514 to destination 198.51.100.80:443; NAT state maps it to 203.0.113.10:30001; outside packet shows the translated source. Return: server replies to 203.0.113.10:30001; NAT matches state and restores destination 10.10.10.25:51514; client receives reply. Use solid blue arrows outbound and dashed green arrows return. Add Arabic subtitle: تدفق ترجمة الحزم. Follow the shared art direction.
```

## Quality Checklist

- Ensure all labels and port numbers are exactly readable; regenerate if text is garbled.
- Do not imply NAT is a security control or that it replaces an ACL/firewall.
- Preserve direction: source translation outbound, destination restoration inbound.
- Use one translation concept per image; avoid mixing Static NAT, Dynamic NAT, and PAT.
- Export at least 1920×1080 for raster versions; retain accessible SVG alternatives when possible.
