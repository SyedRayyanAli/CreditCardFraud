source("Requirements.R")
source("Data_Ingestion.R")
source("Data_Cleaning.R")
source("Data_Visual.R")
source("Data_Prediction.R")

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
General_Visual()
Category_visual()
State_visual()
Time_visual()


### Machine Learning / Predictive Modelling
SplitSets <- TrainTestSplit()
Train <- SplitSets[[1]]
Test <- SplitSets[[2]]
Logistic_Model()
RandomForest_Model()
BalancedRF_Model()
SMOTE_model()
