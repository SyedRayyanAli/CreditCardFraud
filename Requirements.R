installer <- function() {
  install.packages(c("devtools"))
  devtools::install_github("ldurazo/kaggler")
}

loader <- function() {
  library(readr)
  library(kaggler) 
  library(utils)  # for download.file function
  library(tidyverse)  # for working with data
}
