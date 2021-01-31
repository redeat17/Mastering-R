# Description: Demonstration of rgl package

# tasks
# https://cran.r-project.org/web/views/

# documentation at 
# https://cran.r-project.org/
#... https://cran.r-project.org/web/packages/index.html
#... https://cran.r-project.org/web/packages/available_packages_by_date.html
#... https://cran.r-project.org/web/packages/rgl/index.html
#... canonical https://cran.r-project.org/package=rgl
#... https://cran.r-project.org/web/packages/rgl/rgl.pdf

install.packages("rgl")
library(rgl)

example("plot3d")
vignette("plot3d") # oops!

mydf <- read.csv("../global_ontime.csv")

xyzToPlot <- data.frame(mydf$DISTANCE, mydf$DEP_DELAY_NEW, mydf$ARR_DELAY_NEW)

# simple 3d plot
plot3d(xyzToPlot, 
       col = c("red", "green", "blue"))
arrow3d(p0 = c(xyzToPlot[760, ]),
        p1 = c(xyzToPlot[1000, ]))
bg3d(texture = system.file("textures/sunsleep.png", package = "rgl"), col = "white")
grid3d(c("x", "y+", "z"))


# animation
open3d()
plot3d(xyzToPlot, col = rainbow(1000))
M <- par3d("userMatrix")
if (!rgl.useNULL())
  play3d( par3dinterp(time = (0:2)*0.75, 
                      userMatrix = list(M,
                                        rotate3d(M, pi/2, 1, 0, 0),
                                        rotate3d(M, pi/2, 0, 1, 0) ) ),
          duration = 10 )
