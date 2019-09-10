shorturl
=========
https://shortcurl.com is a url shortner built with

* django 
* nodejs
* redis
* postgres

walter
=======
walter is the django api. It also has 2 management commands

`create_listener`
    to be run on the edge that listens to postgres listen events to update the local redis

`full_short_sync`
    does a full sync of redis based on the database

wesley
=======
wesley is the redirector in nodejs. It reads from redis.


