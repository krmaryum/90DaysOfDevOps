# Creating Links to Files in the Same Directory in Markdown

In a Markdown (`.md`) file, you can create a link to another file in the
same directory using a **relative link**.

------------------------------------------------------------------------

# 1️⃣ Basic Syntax

``` markdown
[Link Text](filename.md)
```

Example:

``` markdown
[Docker Basics](docker-basics.md)
```

This will link to a file called **docker-basics.md** located in the same
folder.

------------------------------------------------------------------------

# 2️⃣ Example Directory Structure

    docs/
    │
    ├── README.md
    ├── docker-basics.md
    ├── docker-compose.md
    └── docker-networking.md

Inside `README.md`, you can write:

``` markdown
## Docker Documentation

- [Docker Basics](docker-basics.md)
- [Docker Compose Guide](docker-compose.md)
- [Docker Networking](docker-networking.md)
```

------------------------------------------------------------------------

# 3️⃣ Link to a Section in Another File

If the other file has a heading like:

``` markdown
## Docker Volumes
```

You can link to it like this:

``` markdown
[Docker Volumes](docker-volumes.md#docker-volumes)
```

Rules:

-   Heading becomes **lowercase**
-   Spaces become **-**

Example:

    ## Docker Volumes
    ↓
    #docker-volumes

------------------------------------------------------------------------

# 4️⃣ Link to a File in a Subfolder

Directory structure:

    docs/
    │
    ├── README.md
    └── guides/
        └── docker.md

Link example:

``` markdown
[Docker Guide](guides/docker.md)
```

------------------------------------------------------------------------

# 5️⃣ Link to a File in a Parent Folder

Directory structure:

    project/
    │
    ├── README.md
    └── docs/
        └── docker.md

Inside `docs/docker.md`, you can write:

``` markdown
[Back to README](../README.md)
```

Explanation:

    ..  → move one folder up

------------------------------------------------------------------------

# ✅ Most Common Case (Same Directory)

``` markdown
[Open Docker Guide](docker-guide.md)
```

This links to **docker-guide.md** located in the same folder as the
current Markdown file.
