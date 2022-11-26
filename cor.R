#INSTALL PACKAGES #########
if(!require('pacman')) install.packages('pacman')
pacman::p_load(corrplot,pacman, tidyverse, rio, magrittr)

#LOAD AND PREPARE THE DATASET #######
df <-import('StateData.xlsx')%>%
  as_tibble() %>%
  select(instagram:modernDance)%>%
  print()

#CORRELATION #######  
df %>% cor()

df %>%
  cor() %>%
  round(2) %>%
  print()
#CORPLOT
df %>%
  cor() %>%
  corrplot(
    diag = F,
    tl.pos = T,
    tl.col = 'black'  ,
    tl.srt =45 ,
    type = 'upper',
    order = 'original'
    )


df %$% cor.test(instagram, privacy)
