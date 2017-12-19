library(igraph)
routes <- read.csv("routes.csv",header = FALSE)


routes <- routes[,c(3,5)]

gr <- graph.edgelist(as.matrix(routes), directed = TRUE) 

gr3 <- graph_from_edgelist(as.matrix(routes),directed=FALSE)


a<-leading.eigenvector.community(gr3)

length(unique(a$names))

max(a$membership)

b <- membership(a)
table(b)

plot(gr)

vcount(gr)

indegree <- degree(gr3,mode="in") 
outdegree <- degree(gr3,mode="out") 
closeness_in <- closeness(gr3, mode="in",normalized = TRUE) 
btwn <- betweenness(gr3,normalized = TRUE) 
eigen_centrality_val = eigen_centrality(gr3, directed = FALSE, scale = TRUE, weights = NULL,  options = arpack_defaults) 
centralities <- cbind(indegree,outdegree,closeness_in,btwn, eigen_centrality_val $vector) 
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness"," eigen_centrality") 
nrow(centralities)
str(centralities)

kmclust <- kmeans(centralities,25,iter.max= 20)

kmclust



