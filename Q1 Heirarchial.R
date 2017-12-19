
library(ade4)

Airlines <- read.csv("C:/Users/30938/Desktop/Batch 7/EastWestAirlinesCluster.csv", header=TRUE)

Airlines <-Airlines[,-1]

Airlines[, c(3:5)]<- sapply(Airlines[, c(3:5)], as.factor)

str(Airlines)

Airlines2 <-acm.disjonctif(Airlines[,c(3,4,5)])

View(Airlines2)

str(Airlines2)

AAirlines <- cbind(Airlines,Airlines2)

AAirlines2 <- cbind(Airlines,Airlines2)


AAirlines <- AAirlines[,-c(3,4,5)]


View(AAirlines2)

str(AAirlines)



######## Heirarchial clustering##########
AAirlines[,c(1:7)] <- scale(AAirlines[, c(1:7)])


View(AAirlines)

dist.AAirlines <- dist(AAirlines,method = "euclidean")

airclust <- hclust(dist.AAirlines,method='ward.D2')

plclust(airclust)

rect.hclust(airclust, k=2, border="red")
airclust

cair <- cutree(airclust,k=2)

cair

Clust_1 <- AAirlines2[which(cair == 1),]

Clust_2 <- AAirlines2[which(cair == 2),]

Clust_1 <- Clust_1[,-c(3:5)]

Clust_2 <- Clust_2[,-c(3:5)]

View(Clust_1)

View(Clust_2)

#apply(Clust_1,2,mean)
#colMeans(Clust_1)
summary(Clust_1)
summary(Clust_2)
#sapply(Clust_2,mean)

