#install.packages("igraph and RGBL")
#Using the library "igraph"
library(igraph)
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("RBGL")
#Using the RBGL library
library(RBGL)


# cREATING A BIPARTITE NETWORK
BP <- graph.empty(directed = F)
#The nodes in ID, and PRODUCT are unique values.
ID<- c("P1", "P2","P3","P4","P5")
PRODUCT <- c("101", "102", "103", "104", "105", "106", "107")

#The edgeslist
edges.list <-c("P1","101", "P2","101", "P4","101", "P1","102", "P3","102", "P4","102", "P4","102",
               "P1","103", "P2","103","P2","104","P4","104","P3","105","P1","106","P2","106","P3","107","P5","107")
#add nodes: "TRUE" or "FALSE" in "type" indicate two modes of nodes.
BP <- add.vertices(BP,nv=length(PRODUCT),attr=list(name=PRODUCT), type=rep(FALSE,length(PRODUCT)))
BP <- add.vertices(BP,nv=length(ID),attr=list(name=ID), type=rep(TRUE,length(ID)))
BP <- add.edges(BP,edges.list)

#Print out the created Bipartite network
print(BP, v=TRUE)
# shape by node 
shape <- ifelse(V(BP)$type, "circle", "square")
# coloUr by node 
col <- ifelse(V(BP)$type, "blue", "green") 
plot(BP, vertex.shape = shape, layout=layout_as_bipartite, vertex.color = col)

#Compute the incidence matrix
in.matrix<-as_incidence_matrix(BP)

#Project to one-mode
proj.BP <- bipartite.projection(BP)

plot(proj.BP[[1]], main = "Bipartite Projection: PRODUCT")
plot(proj.BP[[2]], main = "Bipartite Projection: CUSTOMER ID")



#PART 2 Q1A

D <- make_graph( edges=c(1,4, 1,4, 1, 6, 2, 6, 2,6, 2,6, 2,5, 2,7, 2,3, 3,5, 5,6, 5,7, 4,7), directed=FALSE ) 
plot(D) 

#Count the number of nodes
gorder(D)
#Count the number of edges
gsize(D)
#Convert a graph to the adjacency matrix
as_adjacency_matrix(D)
#Degree of each node
degree(D)

#PART2 Q1B

DI <- make_graph( edges=c('A','F','A','B','A','D', 'B','E','B','C', 'C','A', 'D','B','D','E','F','B','F','C','F','E'), directed=TRUE ) 
plot(DI) 

#Count the number of nodes
gorder(DI)
#Count the number of edges
gsize(DI)
#Convert a graph to the adjacency matrix
as_adjacency_matrix(DI)
#Degree of each node
degree(DI)
