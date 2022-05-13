const express = require("express");
const app = express();

app.listen(4000, function () {
  console.log("App listening on port 4000!");
});

app.get("/", function (req, res) {
  const delay = req.query.speed === "fast" ? 50 : 200;

  console.log(`${new Date().toLocaleString()} - Response delayed by ${delay} ms`);

  setTimeout(function () {
    res.sendStatus(200);
  }, delay);
});
