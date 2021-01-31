# Description: Demonstration of cluster package

myDataFrame <- read.csv("../global_ontime.csv")


# clean and sample the data -----------------------------------------------

mydfnostate <- myDataFrame[ , -c(1,5)]
mydfnostatenona <- mydfnostate[ complete.cases(mydfnostate), ]

set.seed(42)
mydfindex <- sample(1:nrow(mydfnostatenona), 5000)
mydfsampled <- mydfnostatenona[mydfindex, ]


# Base R kmeans and plot ------------------------------------------------------------

mykmeansObject <- kmeans(mydfsampled, centers = 3)

# Base R plot
plot(mydfsampled, col = mykmeansObject$cluster)


# adding the cluster package ----------------------------------------------

install.packages("cluster")
library(cluster)

# cluster package includes...
# hierarchical methods: 
#    agnes: AGglomerative NESting
#    diana: DIvisive ANAlysis
#    mona: MONothetic Analysis Clustering of Binary Variables
# Partitioning methods: 
#    pam: Partitioning Around Medoids
#    clara: Clustering Large Applications
#    fanny: Fuzzy Analysis Clustering

# plotting the data set from above
clusplot(mydfsampled, mykmeansObject$cluster) # using cluster package

# simple demo of clara
myClaraObject <- clara(mydfsampled, k=3)
plot(myClaraObject)



