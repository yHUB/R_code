# iINSTALL PACKAGES #################
if (!require('pacman')) install.packages('pacman')
pacman::p_load(pacman, rio,tidyverse, magrittr)


# LOAD AND PREPARE DATASET ###########
# Use "StateData.xlxs" from exercise files
df <- import("StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, 
         region,
         psychRegions,
         instagram:entrepreneur) %>% 
  mutate(
    region = as.factor(region),
    psychRegions = as.factor(psychRegions)
  ) %>%
  print()

#SUMMARY ##################
#summary of the entire table
df %>% summary()

#Summary of one variable
#select returns a data frame while pull returns a vector
df %>%
  select(entrepreneur )%>%
  summary()

df %>%
  pull(entrepreneur) %>%
  summary()

#BOXPLOT STATS ######
# Boxplot of entrepreneur with ggplot2
df %>%
  select(entrepreneur) %>%
  ggplot(data = .,aes(y = entrepreneur, x =1))+
  geom_boxplot(notch = T) +
   coord_flip()

#Boxplot stats:hinges, n, CI for median ;and outliers
df %>%
  pull(entrepreneur) %>%
  boxplot.stats()

#ADDITIONAL STATS ##########
p_load(psych)

#Descriptive stats for all variable
df %>% describe()

#Descibe only entrepreneur
df %>%
   select(entrepreneur) %>%
   summary()
