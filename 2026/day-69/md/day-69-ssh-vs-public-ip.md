# Day 69 - Public IP vs SSH Access (Laptop vs EC2)

## Overview

This document explains why SSH works for cloud servers (EC2) but not for a local machine (WSL/laptop), even though both can show a "public IP".

---

## Scenario 1: Laptop (WSL)

### Network Flow

```
Internet
   ↓
ISP (Carrier-Grade NAT)
   ↓
Router
   ↓
Windows Host
   ↓
WSL (Private IP: 172.27.x.x)
```

### Key Points

- No dedicated public IP
- Behind multiple NAT layers
- Inbound connections are blocked
- Cannot accept SSH from internet

### Result

```
ssh user@<your-public-ip>
❌ Connection fails
```

---

## Scenario 2: AWS EC2

### Network Flow

```
Internet
   ↓
AWS Public IP (3.x.x.x / 18.x.x.x)
   ↓
EC2 Instance
```

### Key Points

- Dedicated public IP
- Direct internet routing
- Controlled by security groups
- SSH works

### Result

```
ssh -i key.pem ec2-user@<public-ip>
✅ Connection successful
```

---

## Comparison Table

| Feature | Laptop (WSL) | EC2 |
|--------|-------------|-----|
| Public IP | Shared (CGNAT) | Dedicated |
| Reachable from Internet | No | Yes |
| SSH Access | No | Yes |
| Port Forwarding | Complex/Blocked | Not required |

---

## Why Laptop is Not Reachable

- ISP uses Carrier-Grade NAT (CGNAT)
- Multiple users share same external IP
- No direct mapping from public IP to your machine

---

## How to Make Local Machine Accessible (Optional)

### 1. Port Forwarding (Router)
- Requires ISP support
- Often blocked in CGNAT environments

### 2. Tunneling Tools (Recommended)
- ngrok
- Cloudflare Tunnel
- Serveo

### Example:

```
ssh -R 80:localhost:3000 serveo.net
```

---

## Key Takeaway

> Public IP does NOT always mean reachable from internet

- Laptop → Public IP exists but NOT reachable
- EC2 → Public IP exists AND reachable

---

## Summary

This concept is critical in DevOps for understanding:
- Networking
- SSH access
- Cloud infrastructure
- Security configurations
