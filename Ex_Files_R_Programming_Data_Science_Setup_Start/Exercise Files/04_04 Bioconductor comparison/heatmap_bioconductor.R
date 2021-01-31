# Description: Heatmap example for Bioconductor

# data from https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236
# OriginState
# DepDelayMinutes: Difference in minutes between scheduled and actual departure time. Early departures set to 0.
# ArrDelayMinutes: Difference in minutes between scheduled and actual arrival time. Early arrivals set to 0.
# Distance between airports (miles)


# Install and load bioconductor -------------------------------------------

source("http://bioconductor.org/biocLite.R")

biocLite("ComplexHeatmap")

library(ComplexHeatmap)

# import and clean data ---------------------------------------------------

bot_stats <- read.csv("../global_ontime.csv")

bot_mean <- aggregate(bot_stats,
                      by = list(bot_stats$ORIGIN_STATE_ABR),
                      FUN = mean,
                      na.rm = TRUE
                      )

bot_mean$DISTANCE <- bot_mean$DISTANCE / 100

rownames(bot_mean) <- levels(bot_mean$Group.1)[bot_mean$Group.1]

# Bioconductor version of Heatmap -----------------------------------------

Heatmap(bot_mean[ , c("DEP_DELAY_NEW","ARR_DELAY_NEW","DISTANCE")],
        col = colorRampPalette(c("green","red"))(10),
        cluster_rows = FALSE,
        cluster_columns = FALSE,
        row_names_gp = gpar(fontsize = 10),
        show_heatmap_legend = FALSE
)
