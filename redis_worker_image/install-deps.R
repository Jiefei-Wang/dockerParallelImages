pkgs <- c("foreach", "redux", "doRedis", "remotes")
for(i in pkgs){
    if (!requireNamespace(i, quietly = TRUE)){
        BiocManager::install(i, ask = FALSE)
      }
}

if (!requireNamespace("doRedis", quietly = TRUE)){
  remotes::install_github("https://github.com/bwlewis/doRedis")
}

