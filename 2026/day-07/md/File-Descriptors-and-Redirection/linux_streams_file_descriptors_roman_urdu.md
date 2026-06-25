# Linux Streams aur File Descriptors

## Stream Kya Hota Hai?

Stream data ka flow hota hai jo Linux command aur terminal ke darmiyan chalta hai.

Linux mein 3 standard streams hoti hain:

| Number | Name | Roman Urdu Meaning |
|----------|--------|--------|
| 0 | stdin | Input lena |
| 1 | stdout | Normal output dikhana |
| 2 | stderr | Error messages dikhana |

## stdin

stdin input stream hoti hai.

Example:

```bash
cat
```

## stdout

stdout normal output stream hoti hai.

Example:

```bash
ls
```

## stderr

stderr error output stream hoti hai.

Example:

```bash
ls wrongfile
```

## File Descriptor Kya Hota Hai?

File Descriptor ek number hota hai jo Linux kisi stream ko identify karne ke liye use karta hai.

```text
0 = stdin
1 = stdout
2 = stderr
```

## Redirection Examples

stdout redirect:

```bash
ls > output.txt
```

stderr redirect:

```bash
ls wrongfile 2> error.txt
```

stdout hide:

```bash
command > /dev/null
```

stderr hide:

```bash
command 2> /dev/null
```

Dono hide:

```bash
command > /dev/null 2>&1
```

## Khulasa

- stdin = FD 0
- stdout = FD 1
- stderr = FD 2

Stream = data ka flow

File Descriptor = us stream ka number
