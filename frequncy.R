# INSTALL PACKAGES###############################
if(!require('pacman')) install.packages('pacman')
pacman::p_load(rio, magritrr, tidyverse, pacman)

# IMPORT DATASSET##################
df <- import('StateData.xlsx') %>%
  as_tibble() %>%
  select(state_code, region, psychRegions)%>%
  print()

# SUMMARIZE DATASEET ###############################
#DATA SUMMARRY

df %>% summary()
df %>%select(region) %>%
  summary()

#table
df %>%
  select(region) %>%
  table()
 
#convert chr to fct
df %<>%
  mutate(
    region = as.factor(region),
    psychRegions = as.factor(psychRegions)
  )
#summary all variable
df %>%
  summary()
