## Nginx File System Explanation (Roman Urdu)

### Overview

Is document mein hum samjhenge ke Nginx ka file system kaise kaam karta hai aur Ansible role ke andar kaun kaun se directories use hoti hain.

---

### Nginx ka Basic Structure

Nginx 3 main components se mil ke banta hai:

1. Main Configuration File  
2. Virtual Host Configuration  
3. Website Content (HTML files)

---

### 1. Main Configuration File

**Path:**
/etc/nginx/nginx.conf

**Explanation:**

Yeh Nginx ka main control file hota hai. Isme global settings hoti hain jaise:

- worker processes
- connections
- performance tuning

**Role Usage:**

Ansible template use karke is file ko dynamically generate kiya jata hai:

nginx.conf.j2 → /etc/nginx/nginx.conf

---

### 2. Virtual Host Configuration

**Path:**
/etc/nginx/conf.d/

**Explanation:**

Is folder ke andar har file ek website represent karti hai.

Example:
terraweek.conf

Is file mein define hota hai:

- port (listen 80)
- root directory (/var/www/app)
- routing rules

**Role Usage:**

Ansible template se create hoti hai:

/etc/nginx/conf.d/{{ app_name }}.conf

---

### 3. Website Content (Web Root)

**Path:**
/var/www/{{ app_name }}/

**Explanation:**

Yeh wo jagah hai jahan actual website files hoti hain:

- index.html
- CSS / JS files

**Role Usage:**

Ansible file aur template module se create hoti hai:

/var/www/{{ app_name }}/index.html

---

### Complete Flow (Step by Step)

1. User browser mein IP open karta hai  
2. Nginx nginx.conf read karta hai  
3. conf.d folder ki files load hoti hain  
4. Specific vhost config (terraweek.conf) select hoti hai  
5. Root directory (/var/www/app) open hoti hai  
6. index.html browser mein display hota hai  

---

### Diagram

nginx.conf  
   ↓  
conf.d/terraweek.conf  
   ↓  
/var/www/terraweek/index.html  

---

### Key Learning

- nginx.conf = global settings  
- conf.d = website configuration  
- /var/www = actual website files  

---

### Conclusion

Nginx ka structure simple hai:

Config + Website Rules + Files

Ansible role ke through hum in tino ko automate karte hain, jis se multiple servers aur applications easily manage kiye ja sakte hain.
