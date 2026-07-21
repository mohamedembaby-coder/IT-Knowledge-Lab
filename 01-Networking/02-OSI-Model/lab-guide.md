# Subnetting Practice Labs
# تمارين عملية على Subnetting

---

# 🇪🇬 الشرح بالعربي

بعد فهم طريقة **Magic Number**، أصبح بإمكاننا حل أي سؤال Subnetting بخطوات ثابتة.

في هذا الفصل سنحل مجموعة من التمارين، بدايةً من المستوى الأساسي وحتى مستوى امتحان CCNA.

في كل تمرين سنحدد:

- Network Address
- Broadcast Address
- First Host
- Last Host
- Number of Usable Hosts

---

## 🇺🇸 English Explanation

The best way to master subnetting is through practice.

Each lab in this section follows the same structured approach:

- Determine the subnet mask
- Calculate the magic number
- Identify the subnet
- Find the network address
- Find the broadcast address
- Determine the first and last usable hosts

---

# Lab 1

## Question

```
IP Address

192.168.1.70/26
```

---

## Step 1

Subnet Mask

```
255.255.255.192
```

---

## Step 2

Magic Number

```
256-192

=

64
```

---

## Step 3

Available Networks

```
0

64

128

192
```

---

## Step 4

The IP is:

```
70
```

70 يقع بين:

```
64

↓

127
```

إذن الشبكة هي:

```
192.168.1.64
```

---

## Step 5

Broadcast

```
Next Network

128

↓

127
```

Broadcast

```
192.168.1.127
```

---

## Step 6

First Host

```
192.168.1.65
```

Last Host

```
192.168.1.126
```

---

## Final Answer

| Item | Value |
|------|-------|
| Network | 192.168.1.64 |
| Broadcast | 192.168.1.127 |
| First Host | 192.168.1.65 |
| Last Host | 192.168.1.126 |
| Hosts | 62 |

---

# Lab 2

## Question

```
10.10.5.180/27
```

---

Mask

```
255.255.255.224
```

Magic Number

```
32
```

Networks

```
0

32

64

96

128

160

192
```

180 يقع بين:

```
160

↓

191
```

---

Network

```
10.10.5.160
```

Broadcast

```
10.10.5.191
```

First Host

```
10.10.5.161
```

Last Host

```
10.10.5.190
```

Hosts

```
30
```

---

# Lab 3

## Question

```
172.16.8.250/28
```

Mask

```
255.255.255.240
```

Magic Number

```
16
```

Networks

```
0

16

32

48

64

80

96

112

128

144

160

176

192

208

224

240
```

250 يقع بين:

```
240

↓

255
```

---

Network

```
172.16.8.240
```

Broadcast

```
172.16.8.255
```

First Host

```
172.16.8.241
```

Last Host

```
172.16.8.254
```

Hosts

```
14
```

---

# Lab 4

## Question

```
192.168.20.9/29
```

Mask

```
255.255.255.248
```

Magic Number

```
8
```

Networks

```
0

8

16

24

32
...
```

9 يقع بين:

```
8

↓

15
```

---

Network

```
192.168.20.8
```

Broadcast

```
192.168.20.15
```

First Host

```
192.168.20.9
```

Last Host

```
192.168.20.14
```

Hosts

```
6
```

---

# Lab 5

## Question

```
192.168.100.5/30
```

Mask

```
255.255.255.252
```

Magic Number

```
4
```

Networks

```
0

4

8

12

16
```

5 يقع بين:

```
4

↓

7
```

---

Network

```
192.168.100.4
```

Broadcast

```
192.168.100.7
```

First Host

```
192.168.100.5
```

Last Host

```
192.168.100.6
```

Hosts

```
2
```

---

# Summary Table

| IP Address | Prefix | Network | Broadcast | First Host | Last Host | Hosts |
|------------|--------|----------|------------|------------|-----------|------:|
| 192.168.1.70 | /26 | 192.168.1.64 | 192.168.1.127 | .65 | .126 | 62 |
| 10.10.5.180 | /27 | 10.10.5.160 | 10.10.5.191 | .161 | .190 | 30 |
| 172.16.8.250 | /28 | 172.16.8.240 | 172.16.8.255 | .241 | .254 | 14 |
| 192.168.20.9 | /29 | 192.168.20.8 | 192.168.20.15 | .9 | .14 | 6 |
| 192.168.100.5 | /30 | 192.168.100.4 | 192.168.100.7 | .5 | .6 | 2 |

---

# Enterprise Example

في شركة يوجد رابط Point-to-Point بين راوترين.

يمكن استخدام:

```
10.0.0.0/30
```

وينتج عنه:

```
Network

10.0.0.0
```

```
Router A

10.0.0.1
```

```
Router B

10.0.0.2
```

```
Broadcast

10.0.0.3
```

وهذا يوفر عنوانين فقط، وهو مناسب جدًا لوصلات الراوترات.

> **ملاحظة:** في بعض البيئات الحديثة يمكن استخدام `/31` لوصلات Point-to-Point وفقًا للمعايير الداعمة، مما يلغي الحاجة إلى عنوان Broadcast في هذا السيناريو.

---

# CCNA Tips

احفظ هذه القيم لأنها تتكرر كثيرًا:

| Prefix | Hosts |
|---------|------:|
| /24 | 254 |
| /25 | 126 |
| /26 | 62 |
| /27 | 30 |
| /28 | 14 |
| /29 | 6 |
| /30 | 2 |

---

# Common Mistakes

### ❌ اختيار أقرب شبكة بدلًا من الشبكة التي يقع داخل نطاقها عنوان الـ IP.

✔️ الصحيح:

حدد أولًا قيم الشبكات باستخدام **Magic Number**، ثم اختر النطاق الذي يحتوي على عنوان الـ IP.

---

### ❌ الخلط بين Last Host وBroadcast.

✔️ الصحيح:

- **Last Host = Broadcast − 1**
- **Broadcast = Next Network − 1**

---

# Interview Questions

### Q1: Why is /30 commonly used for router-to-router links?

**Answer:**

Because it provides exactly two usable host addresses, which is sufficient for a point-to-point connection.

---

### Q2: How do you find the broadcast address?

**Answer:**

Find the next subnet and subtract one from its network address.

---

### Q3: What is the first usable address?

**Answer:**

The network address plus one.

---

### Q4: What is the last usable address?

**Answer:**

The broadcast address minus one.

---

### Q5: What is the fastest subnetting technique for CCNA exams?

**Answer:**

The Magic Number Method.