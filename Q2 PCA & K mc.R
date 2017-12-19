str(wine)
wine[,-1] <- sapply(wine[,-1], as.numeric)
str(wine)
wine1 <- wine[,-1]
pca_wine <- prcomp(wine1, center = TRUE, scale.= TRUE)
pca_wine
summary(pca_wine)
plot(pca_wine, type = "l")
pca_wine$x



#### clustering using all variables
wine2 <- scale(wine1)
kmc1 <- kmeans(wine2,3)
kmc1
table(kmc1$cluster, wine$Type)
## clustering using 1 & 2 principal components
## PC1 and PC2 are #####pca_wine$x[,1:2]#######
wine_pc <- data.frame(pca_wine$x[,1:2])
str(wine_pc)
kmc2<- kmeans(wine_pc,3)
table(kmc2$cluster, wine$Type)
