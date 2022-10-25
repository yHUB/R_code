# R_code
library("tidyverse")

transport_data <- read_csv("data/transport_data.csv")

transport_data

by_receive_city <- transport_data %>%
  group_by(receiver.country, receiver.city) %>%
  select(date, number.of.items)

by_receive_city %>%
  summarise(observations = n())%>%
  print(n=Inf)

by_receive_city %>%
  mutate(percent.of.items = 100 * {number.of.items / sum(number.of.items)})

by_receive_city %>%
  filter(cumany(number.of.items > 453)) %>%
  ungroup()

transport_data %>%
  group_by(receiver.country, receiver.city) %>%
  mutate(received.obsservation = n()) %>%
  group_by(sender.country,sender.city) %>%
  mutate(sent.observation = n())%>%
  select(received.obsservation, sent.observation)%>%
  unique() %>%
  select(received.obsservation)%>%
  .[[1]]
