# Copyright Mark Niemann-Ross, 2017
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Heatmap example for Tidyverse
# Appreciation to Martin Hadley - https://www.linkedin.com/in/martinjohnhadley/

# data from https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236
# OriginState
# DepDelayMinutes: Difference in minutes between scheduled and actual departure time. Early departures set to 0.
# ArrDelayMinutes: Difference in minutes between scheduled and actual arrival time. Early arrivals set to 0.
# Distance between airports (miles)

# demonstration of how Reproducible R Toolkit affects packages
library(checkpoint)
# checkpoint("2017-12-29")
# checkpointRemove("2017-12-29")
# checkpointArchives()

# install.packages("tidyverse")
library(tidyverse)

read_csv("../40797218_T_ONTIME.csv") %>%
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

