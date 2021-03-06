var http = require("http");
var redis = require("redis");

if (process.env.SENTRY_DSN) {
    var Raven = require('raven');
    Raven.config(process.env.SENTRY_DSN).install();
}

client = redis.createClient();

client.on('connect', function() {
    console.log('Redis client connected');
});

http.createServer(function(req, res) {
  let path = req.url.slice(1); // remove leading /
  client.get(path, function(err, data) {
    if (!data) {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.write("Not Found");
        res.end();
        return
    }
    let dataJson = JSON.parse(data);
    res.writeHead(301,{Location: dataJson.url});
    res.end();
  });
}).listen(process.env.NODE_PORT || 8002);
