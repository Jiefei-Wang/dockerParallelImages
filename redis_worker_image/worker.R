library(doRedis)

queue <- NULL
host <- "localhost"
port <- 6379
password <- NULL

if(Sys.getenv("redisQueue")!=""){
  queue <- Sys.getenv("redisQueue")
}else{
  stop("The queue does not exist!")
}
if(Sys.getenv("redisServer")!=""){
  host <- Sys.getenv("redisServer")
}
if(Sys.getenv("redisPort")!=""){
  port <- as.numeric(Sys.getenv("redisPort"))
}
if(Sys.getenv("redisPassword")!=""){
  password <- Sys.getenv("redisPassword")
}

message("Queue: ", queue)
message("Server: ", host)
message("Port: ", port)
message("password: ", ifelse(!is.null(password),"set", "not set"))
redisWorker(queue, host = host, port = port, password = password)




