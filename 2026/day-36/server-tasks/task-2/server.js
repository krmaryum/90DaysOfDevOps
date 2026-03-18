const express = require("express");

const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
  res.send("Task Manager API is running\n");
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
