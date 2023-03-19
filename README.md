# Nginx-Load-Balancer-with-Podman
Tutorial on how to setup a simple Nginx load balancer with Podman.

Clone this repo and cd into it. Then build the demo server from the Dockerfile or simply pull this from my container repo.
```
podman pull quay.io/csjoy/goserver
```

Create a common network for all of your server container.
```
podman network create load
```

Then create multiple instances of same server using different port. These servers will be used by nginx to distribute load using the internal round robin algorithm.
```
podman run --network=load -d -p 1111:8080 goserver
podman run --network=load -d -p 2222:8080 goserver
podman run --network=load -d -p 3333:8080 goserver
podman run --network=load -d -p 4444:8080 goserver
```

Run the nginx container using the custom configuration found on the root of this repo. Modify the nginx.conf file with your local ip to work as expected.
```
podman run --network=load -d -v ./nginx.conf:/etc/nginx/nginx.conf -p 8080:8080  nginx
```

There you have it. If you visit localhost:8080, you will be served content from one of those 4 server instance we created earlier.
