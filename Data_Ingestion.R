download_data <- function() {
  if(!(file.exists("data"))) {
    
    kgl_auth(creds_file = 'kaggle.json')
    
    response <- kgl_datasets_download_all(owner_dataset = "kartik2112/fraud-detection")
    
    download.file(response[["url"]], "archive.zip", mode="wb")
    
    unzip_result <- unzip("archive.zip", exdir = "data/", overwrite = TRUE)
    
    unlink("archive.zip")
  }
  else{
    print("Data Already exists")
  }
}


get_data <- function() {
  return(read_csv("data/fraudTrain.csv"))

}
