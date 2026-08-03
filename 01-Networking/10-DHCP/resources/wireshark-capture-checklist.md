# Wireshark DHCP Capture Checklist

1. سجّل الوقت والمنفذ/VLAN وMAC للـ client قبل الالتقاط.
2. استخدم `dhcp || bootp` وحدد transaction ID (`xid`).
3. تحقق من Discover → Offer → Request → ACK/NAK ومن مصدر كل رسالة.
4. سجّل `yiaddr` و`giaddr` وOptions 1, 3, 6, 51, 54 و82 إن وُجدت.
5. أخفِ MACs وhostnames وinternal addressing عند إرسال capture خارج فريق العمل.
