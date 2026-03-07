const express = require("express");
const app = express();

const port = process.env.PORT || 3000;

app.get("/", (req, res) => res.send("✅ AISC Dev Web App is running (Node + Azure App Service)"));
app.get("/health", (req, res) => res.json({ ok: true, env: process.env.NODE_ENV || "unknown" }));

app.listen(port, () => console.log(`Listening on ${port}`));