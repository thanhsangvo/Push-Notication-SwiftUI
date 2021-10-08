const express = require("express")
const Pusher = require("../lib/pusher")

// provide auth details via the PUSHER_URL environment variable
// const pusher = new Pusher({ url: process.env["PUSHER_URL"] })

const pusher = new Pusher({
  appId: "1279186",
  key: "da51b798dc018b2b45f9",
  secret: "c58f9f38754c3cba04eb",
  cluster: "ap1",
  useTLS: true
});

pusher.trigger("my-channel", "my-event", {
  message: "hello world"
});

const app = express()
app.use(function (req, res, next) {
  req.rawBody = ""
  req.setEncoding("utf8")

  req.on("data", function (chunk) {
    req.rawBody += chunk
  })

  req.on("end", function () {
    next()
  })
})

app.post("/webhook", function (req, res) {
  const webhook = pusher.webhook(req)
  console.log("data:", webhook.getData())
  console.log("events:", webhook.getEvents())
  console.log("time:", webhook.getTime())
  console.log("valid:", webhook.isValid())
  res.send("OK")
})

app.listen(3000)
