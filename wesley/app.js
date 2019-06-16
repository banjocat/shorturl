var http = require("http");
var redis = require("redis");

client = redis.createClient();

client.on('connect', function() {
    console.log('Redis client connected');
});

client.on('error', function (err) {
    console.log('Something went wrong ' + err);
});

http.createServer(function(req, res) {
  let path = req.url.slice(1); // remove leading /
  client.get(path, function(err, url) {
    if (!url) {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.write("Not Found");
        res.end();
        return
    }
    res.writeHead(301,{Location: url});
    res.end();
  });
}).listen(8002);
