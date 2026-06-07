# Explanation of the Express + MongoDB Server Code

This code creates a simple Node.js API server using Express and connects
it to MongoDB using Mongoose, while loading configuration from dotenv.

------------------------------------------------------------------------

## 1. Import required libraries

``` javascript
const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();
```

### What happens here

-   **express**: A web framework used to build APIs and web servers.
-   **mongoose**: A library used to connect and interact with MongoDB.
-   **dotenv**: Loads variables from a `.env` file into `process.env`.

Example `.env` file:

``` env
PORT=3000
MONGO_URI=mongodb://localhost:27017/taskdb
```

After `dotenv.config()` runs, your app can access them like:

``` javascript
process.env.PORT
process.env.MONGO_URI
```

------------------------------------------------------------------------

## 2. Create the Express application

``` javascript
const app = express();
```

This initializes the Express server.

`app` will now handle: - routes - middleware - HTTP requests

------------------------------------------------------------------------

## 3. Set the server port

``` javascript
const PORT = process.env.PORT || 3000;
```

This means:

  Condition           Port Used
  ------------------- ------------
  `.env` has `PORT`   use that
  otherwise           use `3000`

Example:

``` env
PORT=4000
```

Then the server runs on **4000**.

------------------------------------------------------------------------

## 4. Enable JSON parsing

``` javascript
app.use(express.json());
```

This middleware allows the server to read **JSON request bodies**.

Example request:

``` json
{
  "title": "Learn Docker"
}
```

Without this line, Express cannot parse JSON from requests.

------------------------------------------------------------------------

## 5. Connect to MongoDB

``` javascript
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("Connected to MongoDB"))
  .catch((err) => console.error("MongoDB connection error:", err));
```

This connects the application to MongoDB using the connection string
from `.env`.

Example:

``` env
MONGO_URI=mongodb://localhost:27017/taskdb
```

### How it works

`mongoose.connect()` returns a **Promise**.

If connection succeeds:

``` javascript
.then(() => console.log("Connected to MongoDB"))
```

If connection fails:

``` javascript
.catch((err) => console.error("MongoDB connection error:", err))
```

------------------------------------------------------------------------

## 6. Root route

``` javascript
app.get("/", (req, res) => {
  res.send("Task Manager API is running");
});
```

This defines an API endpoint.

### Route

    GET /

### Response

    Task Manager API is running

You can test it in a browser:

    http://localhost:3000/

------------------------------------------------------------------------

## 7. Health check endpoint

``` javascript
app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok" });
});
```

This is a **health check route**.

It returns:

``` json
{
  "status": "ok"
}
```

Health endpoints are used by: - Docker - Kubernetes - load balancers -
monitoring systems

Example request:

    GET /health

Response:

``` json
{
  "status": "ok"
}
```

------------------------------------------------------------------------

## 8. Start the server

``` javascript
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

This starts the Express server.

Example output:

    Server running on port 3000

Now the API is accessible at:

    http://localhost:3000

------------------------------------------------------------------------

## Full Request Flow

1.  App starts
2.  dotenv loads environment variables
3.  Express server is created
4.  MongoDB connection is established
5.  API routes are registered
6.  Server listens for requests

------------------------------------------------------------------------

## Summary

This file does four main things:

1.  Creates an Express API server
2.  Loads environment variables from `.env`
3.  Connects to MongoDB using Mongoose
4.  Starts a server with two routes (`/` and `/health`)
