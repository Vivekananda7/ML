install.packages("ade4")
library(ade4)
Airlines <- read.csv("C:/Users/30938/Desktop/Batch 7/EastWestAirlinesCluster.csv", header=TRUE)
Airlines <- Airlines[,-1]
View(Airlines)
str(Airlines)

Airlines[, c(3:5)]<- sapply(Airlines[, c(3:5)], as.factor)

Airlines2 <-acm.disjonctif(Airlines[,c(3,4,5)])

View(Airlines2)

str(Airlines2)

AAirlines <- cbind(Airlines,Airlines2)

AAirlines2 <- cbind(Airlines,Airlines2)

AAirlines <- AAirlines[,-c(3,4,5)]

######## K-means clustering##########
AAirlines[,c(1:7)] <- scale(AAirlines[, c(1:7)])

View(AAirlines)

kmc <- kmeans(AAirlines,2, iter.max = 100, nstart = 21) 

kmc
clust_1 <- AAirlines2[which(kmc$cluster == 1),]
clust_2 <- AAirlines2[which(kmc$cluster == 2),]

clust_1 <-clust_1[,-c(3:5)]
clust_2 <-clust_2[,-c(3:5)]

summary(clust_1)
summary(clust_2)
