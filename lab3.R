#install.packages("igraph")
#Use the library "igraph"
library(igraph)

#Create a bipartite network
g <- graph.empty(directed = F)
#The nodes in nodelist1, and nodelist2 are unique values.
nodelist1<- c("F1", "F2","F3","F4")
nodelist2 <- c("A1", "A2", "A3", "A4", "A5", "A6", "A7")
#The list of edges
edge.list <- c("F1", "A1", "F1", "A2", "F1", "A3", "F1", "A6", "F2", "A1", 
                   "F2", "A3", "F2", "A7", "F3", "A3", "F3", "A5", "F4", "A4", "F4","A7")
#add nodes: "TRUE" or "FALSE" in "type" indicate two modes of nodes.
g <- add.vertices(g,nv=length(nodelist1),attr=list(name=nodelist1), type=rep(FALSE,length(nodelist1)))
g <- add.vertices(g,nv=length(nodelist2),attr=list(name=nodelist2), type=rep(TRUE,length(nodelist2)))
g <- add.edges(g,edge.list)

#Print out the created ipartite network
print(g, v=TRUE)
shape <- ifelse(V(g)$type, "circle", "square") # assign shape by node type
col <- ifelse(V(g)$type, "red", "yellow") # assign color by node type
plot(g, vertex.shape = shape, layout=layout_as_bipartite, vertex.color = col)

#Compute the incidence matrix
incidence<-as_incidence_matrix(g)

#Project to one-mode
proj.g <- bipartite.projection(g)

plot(proj.g[[1]], main = "Bipartite Projection: Films")
plot(proj.g[[2]], main = "Bipartite Projection: Actors")

#Compute the matrix P
P<-t(incidence)%*%incidence

#Create a bipartite matrix using a dataframe
data_bipartite<-data.frame(Films=c("F1", "F1", "F1", "F1", "F2", "F2", "F2", "F3", "F3", "F4","F4"), 
                       Actors=c("A1", "A2", "A3", "A6", "A1", "A3", "A7", "A3", "A5", "A4", "A7"))
nodelist1<- unique(data_bipartite$Films)
nodelist2 <- unique(data_bipartite$Actors)
edges.list<-as.vector(t(as.matrix(data.frame(data_bipartite))))
g <- graph.empty(directed = F)
g <- add.vertices(g,nv=length(nodelist1),attr=list(name=nodelist1), type=rep(FALSE,length(nodelist1)))
g <- add.vertices(g,nv=length(nodelist2),attr=list(name=nodelist2), type=rep(TRUE,length(nodelist2)))
g <- add.edges(g,edges.list)

shape <- ifelse(V(g)$type, "circle", "square") # assign shape by node type
col <- ifelse(V(g)$type, "red", "yellow") # assign color by node type
plot(g, vertex.shape = shape, layout=layout_as_bipartite, vertex.color = col)


#Create a tree
#n is the total number of nodes, children is the number of children for each node
G<-make_tree(n=33, children = 2, mode =  "undirected")
plot(G)

#Check for planar
#Install RBGL 
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("RBGL")
#Use the RBGL library
library(RBGL)
G<-make_graph(c(1,2, 1,3, 1,5, 2,3, 2,4, 3,5), directed = FALSE)
G <- as_graphnel(G) # Convert igraph object to graphNEL object for planarity testing
boyerMyrvoldPlanarityTest(G)
