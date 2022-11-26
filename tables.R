#INSTALL PACKAGES OR LIBRABRIES
if(!require('pacman')) install.packages('pacman')
pacman::p_load(tidyverse, rio, magrittr, pacman)

#load and prepare ddataset
df <- import("StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, region, psychRegions) %>%
  mutate(
    psychRegions = as.factor(psychRegions),
    psychRegions = fct_recode(psychRegions,
      "Friendly" = "Friendly and Conventional",
      "Relaxed" = "Relaxed and Creative",
      "Temperamental" = "Temperamental and Uninhibited"
    )
  ) %>%
  print()

#ANALYSE #########################################
#Create a contigency table

ct <- df %>%
  select(region, psychRegions) %>%
  table()%>%
  print()

#ROWS
ct %>% rowSums()

#Percentages
ct %>%
  prop.table(1) %>%
  round(2) %>%
  print()
  # `*`(100)

# COLUMN
ct %>% colSums()

#Percentage
ct %>%
  prop.table(2) %>%
  round(2) %>%
 # print()
 `*`(100)

#CHI TEST##########
chi <- ct %>%
  chisq.test() %>%
  print()

chi$statistic
chi$observed
chi$stdres
chi$expected
chi$residuals
