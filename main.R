source("Requirements.R")
source("Data_Ingestion.R")
source("Data_Cleaning.R")
source("Data_Visual.R")

### Setting up the data ingestion 
installer()
loader()
download_data()
dataset <- get_data()

### The Data Cleaning part
dataset <- convert_datetime()
dataset <- concat_name()
dataset <- remove_columns()
dataset <- rename_columns()


### Data visualization
Category_visual()
State_visual()
Time_visual()


### Machine Learning / Predictive Modelling
