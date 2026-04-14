const express = require("express");
const app = express();

app.get("/", (req, res) => {
	res.send("Dev environment running v2 🚀");});

app.listen(process.env.PORT || 3000);