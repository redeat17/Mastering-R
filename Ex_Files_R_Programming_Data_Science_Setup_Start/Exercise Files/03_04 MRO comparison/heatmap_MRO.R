# Copyright Mark Niemann-Ross, 2017
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Heatmap example for MRO

# data from https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236
# OriginState
# DepDelayMinutes: Difference in minutes between scheduled and actual departure time. Early departures set to 0.
# ArrDelayMinutes: Difference in minutes between scheduled and actual arrival time. Early arrivals set to 0.
# Distance between airports (miles)

bot_stats <- read.csv("../global_ontime.csv")

bot_mean <- aggregate(bot_stats,
                      by = list(bot_stats$ORIGIN_STATE_ABR),
                      FUN = mean,
                      na.rm = TRUE
                      )

row.names(bot_mean) <- levels(bot_mean$Group.1)[bot_mean$Group.1]

bot_mean_matrix <- as.matrix(bot_mean[ , c("DEP_DELAY_NEW","ARR_DELAY_NEW","DISTANCE")])

heatmap(bot_mean_matrix, 
        Rowv = NA, Colv = NA,
        revC = TRUE,
        scale = "column",
        col = colorRampPalette(c("green","red"))(10),
        margins = c(10,2),
        cexCol = 1
        )
