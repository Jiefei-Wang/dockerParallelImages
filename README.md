# server image
The server image is responsible for receiving jobs from user's main R session and storing the results returned by R workers.

The server accept the following environment variable on startup

1. sshPubKey: The ssh public key
2. redisPort: The port used by the redis server to accept the incoming connection(default: 6379)
3. redisPassword: The password of the redis server

## example
Build the server image with
```
docker build -t redis_server_image redis_server_image/.
```
Run the server in the foreground with the following arguments
```
docker run -it --env redisPort=6379 --env redisPassword=123456 -p 6666:6379 redis_server_image
```

# worker image
The worker image accept the following environment variable on startup:


1. workerNum: The number of R workers in the container
2. sshPubKey: The ssh public key
3. redisQueue: the queue name used by the worker to retrive jobs from the server
4. redisServer: The IP of the redis server(default: localhost)
5. redisPort: The port used by the redis server to accept the incoming connection(default: 6379)
6. redisPassword: The password of the redis server
7. redisTimeout: The max wait time in seconds until the Redis connection fails(default: 60s)


To build
```
docker build -t redis_worker_image redis_worker_image/.
```
To run
```
docker run -it --env redisQueue=jobs --env redisPassword=123456 --env workerNum=2 redis_worker_image
```

## Note
If you want to test the server and the worker on the same machine, you have to allow the connection from the container to the host machine. For example
```
docker run -it --env redisQueue=jobs --env redisServer=localhost --env redisPort=6666 --env redisPassword=123456 --env workerNum=2 --network="host" redis_worker_image
```