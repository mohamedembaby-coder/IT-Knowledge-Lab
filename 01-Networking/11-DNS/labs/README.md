# DNS Lab Files | ملفات مختبر DNS

هذه الملفات starting points لـ BIND 9 في بيئة معزولة فقط. راجع paths, ownership, listen ACLs، والعناوين قبل الاستخدام. لا تنسخها إلى production بلا security review وchange control.

- `named.conf.local`: zone declaration لـ `corp.example` وreverse zone.
- `db.corp.example`: forward zone records.
- `db.10.10.20`: reverse zone records.
