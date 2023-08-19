set.seed(3456)


### Splitting the data into Training and Testing
### We have to do stratified sampling to make sure that event occurs equally

TrainIndex <- createDataPartition(dataset$Is_Fraud, p = .7,
                                 list = FALSE,
                                 times = 1)

Train <- dataset[TrainIndex,]
Test <- dataset[-TrainIndex,]

### Converting response variable to categorical variable
Train$Is_Fraud <- factor(Train$Is_Fraud)


        ###  *** Logistic regression model *** ###

mylogit <- glm(Is_Fraud ~ Amount + Gender + State + Hour + Category, data = Train, family = "binomial")

### Prediction on unseen data
predictions <- predict(mylogit, newdata = Test, type = "response")

### Converting probability to discrete answer based on a threshold of 0.53
predictions = (1*(prediction > .5) + 0)


### Calculating the accuracy
mean(Test$final_pred == Test$Is_Fraud)

### Confusion Matrix
confusionMatrix(factor(Test$Is_Fraud), factor(Test$final_pred))


                 ### **** Random Forest **** ### 



### Fitting the model with hyper parameters ntree and ntry
model <- randomForest(Is_Fraud ~ Amount  + Hour + Category, ntree=100,ntry=1 ,data = Train)

### Printing the model
print(model)

### Predictions on unseen data
predictions <- predict(model, newdata = Test)

### Evaluate model accuracy
accuracy <- mean(predictions == Test$Is_Fraud)
print(paste("Accuracy:", accuracy))

### Confusion Matrix
confusionMatrix(factor(Test$Is_Fraud),factor(predictions))




                    ### ***Balanced Random Forest*** ###


### Compute weights to balance the Random Forest
w <- 1/table(Train[,"Is_Fraud"])
w <- w/sum(w)
weights <- rep(0, nrow(Train))
weights[Train$Is_Fraud == 0] <- w['0']
weights[Train$Is_Fraud == 1] <- w['1']


### Fit the model
model_BRF <- ranger(Is_Fraud~Amount+Hour+Category+State, Train, case.weights=weights)

### Prediction on unseen data
BRF_prediction <- predict(model_BRF, data = Test)

### Confusion matrix
table(Test$Is_Fraud, BRF_prediction$predictions)

### Accuracy
mean(Test$Is_Fraud == BRF_prediction$predictions)


     ### *** SMOTE Method for balanced dataset *** ###


### Oversampling the data
new_Train <- smote(Is_Fraud~., data = Train[,c("Is_Fraud","Amount","Hour")], perc.over = 50, perc.under = 1)

### Fitting the model
model <- randomForest(Is_Fraud ~ Amount  + Hour , ntree=200,ntry=2 ,data = new_Train)

### Predictions on unseen ata
predictions <- predict(model, newdata = Test)

### Model performance
accuracy <- mean(predictions == Test$Is_Fraud)
print(paste("Accuracy:", accuracy))

### Confusion Matrix
confusionMatrix(factor(Test$Is_Fraud),factor(predictions))

