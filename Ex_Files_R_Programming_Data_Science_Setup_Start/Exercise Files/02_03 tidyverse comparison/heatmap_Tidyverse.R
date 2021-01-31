# Description: Heatmap example for Tidyverse
# Appreciation to Martin Hadley - https://www.linkedin.com/in/martinjohnhadley/

# data from https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236
# OriginState
# DepDelayMinutes: Difference in minutes between scheduled and actual departure time. Early departures set to 0.
# ArrDelayMinutes: Difference in minutes between scheduled and actual arrival time. Early arrivals set to 0.
# Distance between airports (miles)

install.packages("tidyverse")
library(tidyverse)

read_csv("../global_ontime.csv") %>%
  mutate(DISTANCE = DISTANCE / 100) %>%
  gather(key = stat,
         value = value,
         -ORIGIN_STATE_ABR,
         na.rm = TRUE) %>%
  mutate(value = as.numeric(value)) %>%
  group_by(ORIGIN_STATE_ABR, stat) %>%
  summarise(mean_value = mean(value, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(ORIGIN_STATE_ABR = fct_rev(ORIGIN_STATE_ABR)) %>%
  ggplot(aes(x = stat, y = ORIGIN_STATE_ABR)) +
  geom_tile(aes(fill = mean_value)) +
  scale_fill_continuous(low = "green", high = "red") 

