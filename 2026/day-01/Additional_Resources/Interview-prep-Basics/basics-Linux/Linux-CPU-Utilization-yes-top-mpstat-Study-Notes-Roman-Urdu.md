# Linux CPU Utilization Lab: `yes`, `top`, `nproc` aur `mpstat`

## Lab ka maqsad

Is lab mein hum samjhenge ke ek single `yes > /dev/null` process `100%` CPU kyun show karta hai, jabke complete system phir bhi taqreeban `91.7%` idle hota hai.

Hum in cheezon ka farq bhi samjhenge:

- Per-process CPU utilization
- Har logical CPU ki utilization
- Complete system ki overall CPU utilization
- User CPU time (`%usr`)
- System/kernel CPU time (`%sys`)

## Test environment

System mein 12 logical CPUs available hain:

```bash
nproc
```

Output:

```text
12
```

`nproc` physical cores ki bajaye operating system ko available logical CPUs ki tadaad show karta hai.

## Controlled CPU workload generate karna

Pehli terminal window mein yeh command run karein:

```bash
yes > /dev/null
```

`yes` command lagataar `y` character generate karti hai. Redirection output ko `/dev/null` mein bhej deti hai, jahan data foran discard ho jata hai.

Data disk par save nahi hota, lekin command lagataar `write()` system calls perform karti rehti hai.

Command stop karne ke liye:

```text
Ctrl+C
```

Ya doosri terminal se tamam `yes` processes stop karein:

```bash
pkill -x yes
```

## `top` se process observe karna

Doosri terminal window mein run karein:

```bash
top
```

Example process entry:

```text
PID   USER     S   %CPU   COMMAND
2637  khalid   R   100.0  yes
```

`yes` ke samne `100%` ka matlab hai ke process ek logical CPU ki taqreeban poori capacity consume kar raha hai. Iska matlab yeh nahi ke tamam 12 logical CPUs busy hain.

Linux ke default `top` process view mein single-threaded process aam tor par ek logical CPU use karke taqreeban `100%` tak jata hai. Multithreaded process multiple CPUs use karke `200%`, `400%` ya us se bhi zyada dikha sakta hai.

## `top` ki overall CPU line samajhna

Example:

```text
%Cpu(s): 1.1 us, 7.2 sy, 0.0 ni, 91.7 id, 0.0 wa
```

`top` ki upper CPU line tamam 12 logical CPUs ka combined average show karti hai.

| Field | Matlab | Observed value |
|---|---|---:|
| `us` | User-space code ke istemal kiye gaye CPU ka waqt | `1.1%` |
| `sy` | Kernel code aur system calls ke istemal kiye gaye CPU ka waqt | `7.2%` |
| `ni` | Changed nice priority walay processes ka CPU time | `0.0%` |
| `id` | CPU ki idle capacity | `91.7%` |
| `wa` | I/O complete hone ka wait time | `0.0%` |

Total system utilization:

```text
1.1% user + 7.2% system = 8.3% busy
```

Remaining idle capacity:

```text
100% - 8.3% = 91.7% idle
```

## Ek busy CPU overall 8.33% kyun hai?

Machine mein 12 logical CPUs hain, lekin `yes` single-threaded hai aur sirf ek logical CPU use kar raha hai:

```text
1 busy logical CPU / 12 logical CPUs × 100 = 8.33%
```

Is liye dono observations sahi hain:

```text
yes process CPU utilization       ≈ ek logical CPU ka 100%
Overall system CPU utilization    ≈ 8.33%
Overall system idle capacity      ≈ 91.67%
```

## `mpstat` se har logical CPU observe karna

Run karein:

```bash
mpstat -P ALL 1
```

Command ka breakdown:

| Hissa | Matlab |
|---|---|
| `mpstat` | Processor utilization statistics report karta hai |
| `-P ALL` | Overall average ke sath har logical CPU alag show karta hai |
| `1` | Har ek second ke baad report refresh karta hai |

Example overall row:

```text
CPU   %usr   %sys   %iowait   %idle
all   1.17   7.17      0.00    91.66
```

Logical CPU 8 ki example row:

```text
CPU   %usr   %sys   %iowait   %idle
8     14.00  86.00     0.00     0.00
```

Baqi CPUs taqreeban is tarah thay:

```text
CPU   %usr   %sys   %idle
0-7   0.00   0.00   100.00
9-11  0.00   0.00   100.00
```

## `mpstat` output ki interpretation

Logical CPU 8 poori tarah utilized hai:

```text
14% user + 86% system + 0% idle = 100%
```

Baqi 11 logical CPUs zyada tar idle hain. Tamam 12 CPUs ka average utilization:

```text
1.17% user + 7.17% system = 8.34% busy
```

Yeh expected calculation ke bilkul qareeb hai:

```text
1 / 12 × 100 = 8.33%
```

Chhota sa difference normal hai kyun ke CPU statistics sampling intervals mein collect hoti hain aur doosray processes bhi kuch waqt ke liye CPU use karte hain.

## Kya yeh user issue hai ya system issue?

Workload ko **user-space process** start kar raha hai, lekin iska zyada CPU time **system CPU** ke andar record ho raha hai.

Flow:

```text
User `yes` command start karta hai
              ↓
`yes` user space mein data generate karta hai
              ↓
`yes` lagataar `write()` request karta hai
              ↓
Kernel un system calls ko handle karta hai
              ↓
CPU time zyada tar `%sys` mein record hota hai
```

Sahi conclusion:

> Ek user-space command syscall-heavy workload create kar rahi hai, jiski wajah se ek logical CPU par system/kernel CPU time high hai.

Is controlled test mein high `%sys` ka matlab yeh nahi ke Linux kernel mein koi fault hai. Kernel sirf woh kaam kar raha hai jo `yes` process us se request kar raha hai.

## `%sys`, `%usr` se zyada kyun hai?

Test command:

```bash
yes > /dev/null
```

Process do main kaam kar raha hai:

1. User space mein data generate karna.
2. Data `/dev/null` mein bhejne ke liye kernel ko bar bar `write()` call karna.

Is test mein data generate karne ke muqablay mein continuous `write()` system calls zyada CPU time consume kar rahi hain. Isi liye output is tarah nazar aa sakta hai:

```text
%usr = 14%
%sys = 86%
```

## `%iowait` zero kyun hai?

`/dev/null` data ko foran discard kar deta hai. Yeh data ko kisi physical disk par write nahi karta.

Isi liye:

```text
%iowait = 0%
```

Yeh workload CPU aur system-call intensive hai, lekin physical disk I/O ka wait nahi kar raha.

## Busy CPU ka number badal kyun sakta hai?

Sample output mein logical CPU 8 busy tha. Linux scheduler baad mein `yes` process ko kisi aur logical CPU par migrate kar sakta hai.

Is liye later report mein CPU 3 ya CPU 10 busy nazar aa sakta hai. Yeh normal behavior hai, jab tak process ko kisi specific CPU ke sath pin na kiya gaya ho.

## `top` mein individual CPUs dekhna

`top` run ho raha ho to keyboard par press karein:

```text
1
```

Yeh per-logical-CPU view ko enable ya disable karta hai. Aapko ek logical CPU taqreeban `100%` busy aur baqi CPUs mostly idle nazar aayenge.

## System calls confirm karna

Paanch seconds ke liye system-call pattern observe karein:

```bash
timeout 5 strace -c yes > /dev/null
```

Summary mein `write()` system call ka heavy use nazar aayega. Yaad rakhein ke `strace` khud monitoring overhead add karta hai, is liye uske CPU percentages ko exact benchmark na samjhein.

## Optional lab: tamam logical CPUs use karna

Har available logical CPU ke liye ek `yes` process launch karne ke liye:

```bash
for ((i=1; i<=12; i++)); do
    yes > /dev/null &
done
```

Monitor karein:

```bash
mpstat -P ALL 1
```

Overall `%idle` taqreeban `0%` ke qareeb aa sakta hai kyun ke 12 logical CPUs busy ho jayenge.

Observation ke baad test processes foran stop karein:

```bash
pkill -x yes
```

Verify karein ke koi `yes` process baqi nahi:

```bash
pgrep -a -x yes
```

Agar koi output na aaye to tamam matching processes stop ho chuki hain.

## Quick command reference

```bash
# Available logical CPUs ki tadaad dekhein
nproc

# Single-threaded CPU/system-call workload start karein
yes > /dev/null

# Processes aur overall CPU utilization observe karein
top

# Har logical CPU ko har ek second baad observe karein
mpstat -P ALL 1

# Paanch seconds ke liye system-call usage inspect karein
timeout 5 strace -c yes > /dev/null

# Tamam processes jin ka exact naam yes hai stop karein
pkill -x yes

# Confirm karein ke koi yes process baqi nahi
pgrep -a -x yes
```

## Interview-style short answer

> System mein 12 logical CPUs thay. `yes > /dev/null` single-threaded process tha, is liye us ne sirf ek logical CPU ko 100% utilize kiya. Overall system utilization taqreeban 8.33% aur idle taqreeban 91.67% raha. `%sys` zyada tha kyun ke process lagataar `write()` system calls kar raha tha. `%iowait` zero tha kyun ke `/dev/null` physical disk I/O perform nahi karta.

## Final conclusion

- `yes` single-threaded hai aur taqreeban ek logical CPU use karta hai.
- `yes` ke samne `100%` ka matlab ek logical CPU ki complete utilization hai.
- Ek busy logical CPU, 12-CPU system ki total capacity ka taqreeban `8.33%` hai.
- Baqi 11 CPUs mostly idle hone ki wajah se overall idle taqreeban `91.67%` hai.
- `%sys` high hai kyun ke `yes` lagataar `/dev/null` ko `write()` system calls karta hai.
- `%iowait` zero hai kyun ke `/dev/null` physical disk I/O perform nahi karta.
- Test user ne start kiya, lekin CPU time zyada tar system/kernel category mein record hua.
