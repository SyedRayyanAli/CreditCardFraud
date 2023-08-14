glimpse(dataset)

convert_datetime <- function() {
  ### Converting date time column to date and time
  dataset$Date <- as.Date(dataset$trans_date_trans_time)
    
  
  dataset$Time <- format(as.POSIXct(dataset$trans_date_trans_time),    # Add time column
                         format = "%H:%M:%S")
  return(dataset)
}


concat_name <- function() {
  ### Combining first name and last name columns into one Name column
  dataset$Name <- paste(dataset$first,dataset$last)
  return(dataset)
}


remove_columns <- function() {
  
  dataset <- subset(dataset,select = -c(trans_date_trans_time,cc_num,first,last,lat,long,dob,unix_time,trans_num,street,merch_lat,merch_long))
  return(dataset)
}

rename_columns <- function() {
  colnames(dataset) <- c("ID","Merchant","Category","Amount","Gender","City","State","Zip Code","City_Population","Job","Is_Fraud","Date","Time","Name")
  return(dataset)
}

