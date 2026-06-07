# Explanation of Environment Variables: PORT and MONGO_URI

These lines are **environment variables** usually stored in a `.env`
file. They are used to configure your application without hard-coding
values in the source code.

``` env
PORT=3000
MONGO_URI=mongodb://mongo:27017/taskdb
```

------------------------------------------------------------------------

## 1. PORT

    PORT=3000

This defines the **port number** where your Node.js server will run.

In your code you likely have something like:

``` javascript
const PORT = process.env.PORT || 3000;
```

This means:

-   If `PORT` exists in `.env` → use it
-   Otherwise → default to **3000**

When the server starts:

    Server running on port 3000

You can then access the API at:

    http://localhost:3000

------------------------------------------------------------------------

## 2. MONGO_URI

    MONGO_URI=mongodb://mongo:27017/taskdb

This is the **MongoDB connection string** used by your application to
connect to the database.

Your code likely connects like this:

``` javascript
mongoose.connect(process.env.MONGO_URI)
```

------------------------------------------------------------------------

## Breaking down the URI

    mongodb://mongo:27017/taskdb

  Part         Meaning
  ------------ -------------------------------------
  mongodb://   Protocol used to connect to MongoDB
  mongo        Hostname of the database server
  27017        Default MongoDB port
  taskdb       Database name

------------------------------------------------------------------------

## Why `mongo` instead of `localhost`

When using **Docker Compose**, containers communicate using **service
names**.

Example `docker-compose.yml`:

``` yaml
services:
  app:
    build: .
  mongo:
    image: mongo:7
```

Here:

-   the database container name is **mongo**
-   the app container connects using **mongo**

Inside Docker:

    mongodb://mongo:27017/taskdb

works, but

    mongodb://localhost:27017/taskdb

would **not work**, because `localhost` would refer to the **app
container itself**, not the database container.

------------------------------------------------------------------------

## Why environment variables are used

Using `.env` files keeps sensitive data out of your code.

Example `.env`:

``` env
PORT=3000
MONGO_URI=mongodb://mongo:27017/taskdb
JWT_SECRET=mysecret
```

Benefits:

-   easier configuration
-   different environments (dev / production)
-   better security
-   cleaner code

------------------------------------------------------------------------

## Summary

  Variable    Purpose
  ----------- ------------------------------------
  PORT        Port where the Node.js server runs
  MONGO_URI   Connection string for MongoDB
  mongo       Docker service hostname
  27017       MongoDB default port
  taskdb      Database name
