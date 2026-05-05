# URI vs URL vs URN

## Overview

This document explains the difference between URI, URL, and URN — fundamental concepts in networking and web technologies.

---

## URI (Uniform Resource Identifier)

A URI is a general identifier used to identify a resource.

- It can identify a resource by **location**, **name**, or both.
- It is the **parent concept** that includes both URL and URN.

### Examples

```
https://example.com/index.html
urn:isbn:0451450523
```

---

## URL (Uniform Resource Locator)

A URL is a type of URI that provides the **location of a resource** and the **method to access it**.

### Structure

```
protocol://hostname/path
```

### Examples

```
https://google.com
http://18.223.1.123
ftp://files.server.com/file.txt
```

### Characteristics

- Includes protocol (http, https, ftp)
- Specifies where the resource is located
- Used in web browsers and APIs

---

## URN (Uniform Resource Name)

A URN is a type of URI that identifies a resource by **name only**, not by location.

### Examples

```
urn:isbn:0451450523
urn:uuid:123e4567-e89b-12d3-a456-426614174000
```

### Characteristics

- Does not provide location
- Used for unique identification
- Location-independent

---

## Key Differences

| Feature | URI | URL | URN |
|--------|-----|-----|-----|
| Purpose | Identify resource | Locate resource | Name resource |
| Includes protocol | Not required | Required | Not required |
| Location info | Optional | Yes | No |
| Example | urn:isbn:12345 | https://example.com | urn:uuid:123 |

---

## Relationship

```
URI
├── URL (location-based)
└── URN (name-based)
```

---

## Real Example

```
curl http://18.223.1.123
```

- This is a **URL** because it includes protocol and location
- It is also a **URI**
- It is NOT a URN

---

## Summary

- URI is the general concept
- URL provides location and access method
- URN provides only a name

---

## Conclusion

Understanding URI, URL, and URN is essential for networking, web development, and DevOps practices.
