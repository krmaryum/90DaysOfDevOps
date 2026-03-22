const express = require("express");
const mongoose = require("mongoose");

const app = express();
const PORT = process.env.PORT || 3000;

// Connect to MongoDB using the connection string from environment variables
mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch(err => console.log(err));

// Defines a route for HTTP GET requests to "/"
app.get("/", (req, res) => {
  res.send("Hello from Dockerized App");
});

// Starts the server and listens on the defined port
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
