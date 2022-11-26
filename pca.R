# INSTGALL PACKAGES#####

if(!require('pacman')) install.packages('pacman')
pacman::p_load(GPArotation, magrittr, rio, psych,tidyverse)

#LOAD AND PREPARE DATA#####
#Import ddataset
df <- import('b5.csv')

#columns  names
df %>% colnames()


#PRINCIPAL COMPONENT ANALYSIS #####


# Three method in R
?prcomp
?princomp
?principal

pc <-df %>%
  prcomp(
  center =T,
  scale = T
)

#Get summary
summary(pc)

#plot
screeplot(pc)


#VERY SIMPLE STRUCTURE ########

df %>%
  select(1:50) %>%
  vss(n = 10)

#Or use nfacti to do the sammw; vss
df %>%
  select(1:50)%>%
  nfactors(n =50)

#Calculate and plot the factor
df %>%
  select(1:50) %>%
  fa(
    nfactors = 5,
    rotate = 'oblimin'
  )%T>%
  fa.diagram() %>%
  print()

#Hierarchical clusteering of items with iclust() #####
df %>%
  select(1:50) %>%
  iclust()

#PRINCIPAL COMPONENT ANALYSIS WITH SET NUMBER OF Factor#####

#PCA WITHNO ROTATION
df %>%
  principal(k
            = 5)
#with roation
df %>%
  principal(k = 5, 
           rotation = 'oblimin')%>%
  plot()

df %>%
  principal(nfactors = 5, 
            rotate= 'oblimin')%>%
  plot()
