packages <- c("kaggler","devtools")

installer <- function() {
  if(identical(setdiff(packages, rownames(installed.packages())),character(0))) {
    print("Required packages are already installed")
  }
  else {
    install.packages(setdiff(packages, rownames(installed.packages()))) 
  }
}

loader <- function() {
  library(readr)
  library(kaggler) 
  library(utils)  # for download.file function
  library(tidyverse)  # for working with data
}


        