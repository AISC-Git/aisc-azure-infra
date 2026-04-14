const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("Dev environment running 🚀");
});

app.listen(process.env.PORT || 3000);