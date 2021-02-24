suppressMessages(library(doRedis))

## Initialize the variables
workerId <- Sys.getenv("workerId")
queue <- NULL
host <- "localhost"
port <- 6379
password <- NULL
timeout <- 60

## Get the arguments from the environment variables
if (Sys.getenv("redisQueue") != "") {
  queue <- Sys.getenv("redisQueue")
} else {
  stop("The queue does not exist!")
}
if (Sys.getenv("redisServer") != "") {
  host <- Sys.getenv("redisServer")
}
if (Sys.getenv("redisPort") != "") {
  port <- as.numeric(Sys.getenv("redisPort"))
}
if (Sys.getenv("redisPassword") != "") {
  password <- Sys.getenv("redisPassword")
}
if (Sys.getenv("redisTimeout") != "") {
  timeout <- as.numeric(Sys.getenv("redisTimeout"))
} 

## Debug info
if (workerId == 0) {
  message("Queue: ", queue)
  message("Server: ", host)
  message("Port: ", port)
  message("password: ", ifelse(!is.null(password), "set", "not set"))
  message("Timeout: ", timeout)
}

## Try to connect to the redis server
time1 <- Sys.time()
success <- FALSE
error <- NULL
while (as.numeric(Sys.time() - time1, "secs") < timeout && !success) {
  tryCatch(
  {
    redisWorker(queue, host = host, port = port, password = password)
    success <<- TRUE
  },
  error = function(e) {
    error <<- e
  }
  )
}

## quit message
if (success) {
  message(paste0("Worker ", workerId, " exits successfully"))
  file.create(paste0("doneWorkers/", workerId))
} else {
  message(paste0("Worker ", workerId, " reports error:\n", error$message))
}


