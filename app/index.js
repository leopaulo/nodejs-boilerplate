import express from "express";

const app = express();
const { APP_PORT } = process.env;

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(APP_PORT, () => {
  console.log(`App listening on port ${APP_PORT}`);
});
