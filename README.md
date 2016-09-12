Pollster
===
*A web-based clicker system*

This was small month-long personal project that I developed during the summer of 2011 in order to get more aquanted and create something with web sockets.

I have since then made some bug fixes small improvments. As an excersize in familarizing myself with docker, I also made sure that it can be packaged into a docker container.

A live and free to use version is hosted at <a href="http://pollster.it">http://pollster.it</a>.

Installation
---
###Local
Requires ruby 1.9.3

```bash
> git clone https://github.com/petermcevoy/pollster.git
> cd pollster
> bundle install
...
./script/start.sh
````
This script starts a faye service (by default listening to port 9292 for socket connections) and then a Webrick server.

With the default configuration the app can then be accessed via `localhost:3000`.

###Docker
####Dockerhub
There is a prebuilt container that can quickly get you up an running.

It is probably a good idea to first make a data volume container to allow caching of gems and, for now, a temporary place for data. This prevents us from having to redownload gems and rebuilding the database if we create a new container instance.
```bash
docker create -v /box -v /app/db/sqlite --name box busybox /bin/true
````

Next, simply download and run the built container. The port for faye needs to be mapped directly, i.e. 9292 -> 9292. HTTP traffic (container port 3000) can be mapped as you wish. Environment varaibles are used to control certain behaviour. Make sure to change the variables in the example file `production.env` to fit your needs.

```bash
docker run --volumes-from box -p9292:9292 -p3000:80 --env-file production.env macint/pollster
````

The app should then be accessible at localhost:80.

####Local Docker
Use docker-compose to build the containers locally.

```bash
> git clone https://github.com/petermcevoy/pollster.git
> cd pollster
> docker-compose build
```

Then run
```bash
> docker-compose up
```

This compiles assets and then runs the server. By default this also loads environment variables from `production.env`. Make sure to change the variables to fit your needs.