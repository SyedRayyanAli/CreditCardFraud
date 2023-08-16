Category_visual <- function() {
  ### How much average transaction is per category
  print(dataset %>%
    group_by(Category) %>%
    summarise(Average = mean(Amount)) %>%
    ggplot(aes(x=reorder(Category,-Average),y=Average)) + geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 45,vjust=1,hjust=1)) + xlab("Category") +
    ylab("Amount") + ggtitle("Average Transaction Amount per category"))
  
  
  ### Average transaction per category and whether it is Fraud or not
  print(dataset %>%
    group_by(Is_Fraud,Category) %>%
    summarise(Average = mean(Amount)) %>%
    ggplot(aes(x=reorder(Category,-Average),y=Average,fill=as.factor(Is_Fraud))) + geom_bar(stat="identity",) +
    theme(axis.text.x = element_text(angle = 45,vjust=1,hjust=1)) + xlab("Category") +
    ylab("Amount") + ggtitle("Average Transaction Amount per category") + scale_fill_discrete(name = "Fraud?" , labels = c("No","Yes")))
  
  
  ### Average transaction per gender
  print(dataset %>%
    group_by(Gender) %>%
    summarise(Average = mean(Amount)) %>%
    ggplot(aes(x=reorder(Gender,-Average),y=Average)) + geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 45,vjust=1,hjust=1)) + xlab("Gender") +
    ylab("Amount") + ggtitle("Average Transaction Amount per Gender"))
}

State_visual <- function() {
  ### Top ten states with the highest number of frauds
  dataset %>%
    group_by(State) %>%
    summarise(total = sum(Is_Fraud)) %>%
    arrange(desc(total)) %>%
    slice(1:10) %>%
    ggplot(aes(x=reorder(State,-total),y=total)) + geom_bar(stat="identity")+ xlab("State") +
    ylab("Frauds") + ggtitle("Total number of Frauds per State")

}


### Extract the hour from time object
conversion <- function(time) {
  return (hms(as.character(dataset$Time)) %>% hour(.))
}

Time_visual <- function() {
  ### Number of frauds based on hour of the day
  dataset %>%
    mutate(hour = conversion(dataset$Time)) %>%
    group_by(hour) %>%
    summarise(total = sum(Is_Fraud)) %>%
    ggplot(aes(x=hour,y=total)) + geom_bar(stat="identity") + xlab("Hour") +
    ylab("Frauds") + ggtitle("Total number of Frauds in each hour of the day")
}

