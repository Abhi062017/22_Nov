#knn classification: Balance-scale dataset
getwd()
data <- read.csv('balance-scale.data', header = F, stringsAsFactors = F)
View(data)
str(data)
sum(is.na(data))
summary(data)
tail(data)
data[which(data$V1 == 'L'),] <- 1
data[which(data$V1 == 'B'),] <- 2
data[which(data$V1 == 'R'),] <- 3
data$V1 <- as.factor(data$V1)

#Randomize the dataset, to create stratified samples,
#to split them into train & test sets.
data_random <- data[order(runif(n=nrow(data))),]
tail(data_random)

#split into train and test
train <- data_random[1:500,]
test <- data_random[501:625,]
train_labels <- train[,1]
test_labels <- test[,1]

install.packages('class', dependencies = T)
library(class)
model <- knn(train = train, test = test, cl = train_labels, k = sqrt(nrow(data)))
summary(model)
table(test_labels, model) #confusion matrix of sorts
