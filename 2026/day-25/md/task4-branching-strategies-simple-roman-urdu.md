# Task 4: Branching Strategies — Simple Roman Urdu

## Task Overview

Is task mein maine Git ki different branching strategies seekhin jo teams software development mein use karti hain.

---

# 1. GitFlow

## Kaise kaam karta hai

GitFlow mein multiple branches hoti hain:

- `main` → production code
- `develop` → ongoing development
- `feature` → new features
- `release` → release preparation
- `hotfix` → urgent bug fixes

## Kahan use hota hai

- Large teams
- Enterprise projects
- Scheduled releases

## Pros (Advantages)

- Organized workflow
- Production aur development separate rehte hain
- Hotfix support hota hai

## Cons (Disadvantages)

- Thora complex hai
- Zyada branches manage karni padti hain
- Merge conflicts ho sakte hain

---

# 2. GitHub Flow

## Kaise kaam karta hai

Ek `main` branch hoti hai.

Developers:
1. Branch create karte hain
2. Changes karte hain
3. Pull request banate hain
4. Review ke baad merge kar dete hain

## Kahan use hota hai

- Startups
- Web apps
- Fast deployment projects

## Pros

- Simple aur easy
- Fast workflow
- Continuous deployment ke liye acha

## Cons

- Strong testing chahiye
- Main branch stable rehni chahiye

---

# 3. Trunk-Based Development

## Kaise kaam karta hai

Sab developers ek hi main branch (`main` ya `trunk`) par kaam karte hain.

Small changes frequently merge ki jati hain.

## Kahan use hota hai

- CI/CD teams
- DevOps environments
- Fast delivery projects

## Pros

- Fast integration
- Kam merge conflicts
- CI/CD ke saath acha kaam karta hai

## Cons

- Automated testing zaroori hai
- Developers ko disciplined hona chahiye

---

# Answers

## Fast startup ke liye best strategy

**GitHub Flow**

Kyuki yeh simple aur fast hai.

---

## Large team with scheduled releases

**GitFlow**

Kyuki ismein releases aur hotfixes properly manage hoti hain.

---

## Final Observation

- GitFlow → structured releases
- GitHub Flow → fast aur simple workflow
- Trunk-Based Development → CI/CD aur frequent integration ke liye best
