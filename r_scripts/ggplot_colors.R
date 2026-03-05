# 
# March 5th 2026
# Hannah Grace McNulty


#-----------------------------------------------------
devtools::install_github("wilkelab/cowplot", force = TRUE)
install.packages("colorspace", repos = "http://R-Forge.R-project.org")
devtools::install_github("clauswilke/colorblindr", force = TRUE)



library(ggplot2)
library(cowplot)
library(colorspace)
library(colorblindr)
library(ggthemes)
library(wesanderson)
library(ggsci)

d <- mpg # random car themes dataset 

# Aesthetics
    # Colors that are attractive 
        # - large geoms (fills) - pale colors 
        # - small geoms(lines,points) - bright colors
    # Colors that highlight elements 
      # - pale, grey to de-emphasize 
      # - bright or saturated colors to emphasize
    # Colors that are visible to the color blind
    # Colors that convert well to black and white

# Information content
# Discrete scale
      # colors to group similar treatments
      # neutral colors (black,grey,white) to indicate control groups
      # Symbolic colors (heat=red, cool = blue, photosynthesis/growth=green, oligotrophic=blue, eutrophic=brown, infected=red)
      # Colors that map to chemical stains or gels, or even colors of organisms
# Continuous scale
      # monochromatic (differing shades of 1 color)
      # 2 tone chromatic scale (from color x to color y)
      # 3 tone divergent scale (from color x through color y to color z)
      # Use color information within and between graphs
      # show color names, hex in base R
      # show color schemes in colorbrewer



my_cols <- c("green", "thistle", "tomato", "cornsilk", "chocolate")

demoplot(my_cols, "map") # gives an example of a figure or map with the colorscheme you have
demoplot(my_cols, "bar")
demoplot(my_cols, "scatter")
demoplot(my_cols, "heatmap")
demoplot(my_cols, "spine")
demoplot(my_cols, "perspective")


# working with black and white color schemes

# choose grey(0 = black, 100 = white)
my_greys <- c("grey20", "grey50", "grey80")
demoplot(my_greys, "bar")

my_greys2 <- grey(seq(from = 0.1, to = 0.9, length.out = 10))
demoplot(my_greys2, "heatmap")


p1 <- ggplot(d, aes(x = as.factor(cyl), y = cty, fill = as.factor(cyl))) +
  geom_boxplot()
p1

# default colors look identical in black and white
p1_des <- colorblindr::edit_colors(p1, desaturate)
p1_des



# set transparency of images using alpha

x1 <- rnorm(n=100, mean = 0)
x2 <- rnorm(n = 100, mean = 2.7)

d_frame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control", "Treatment"), each = 100)
d_frame <- cbind(d_frame, lab)

h1 <- ggplot(d_frame) + aes(x = v1, fill = lab) 
h1 + geom_histogram(position = "identity", alpha = 0.5, color = "black")


# color customization

d <- mpg

# discrete classifications
# scale_fill_manual for boxplots or barplots
# scale_color_manual for points or lines

# default with no color
p_fil <- ggplot(d, aes(x = as.factor(cyl), y = cty)) + geom_boxplot()

# boxplot with default ggplot fill colors
p_fil <- ggplot(d, aes(x = as.factor(cyl), y = cty, fill = as.factor(cyl))) + geom_boxplot()

# custom color palette
my_cols <- c("pink", "purple", "lightblue", "yellow")
p_fil + scale_fill_manual(values = my_cols)


# scatter plot with no color
p_col <- ggplot(d, aes(x = displ, y = cty)) + geom_point(size = 3)

# with default colors - uses "col"
p_col <- ggplot(d, aes(x = displ, y = cty, col = as.factor(cyl))) + geom_point(size = 3)

# manual entry - scale_color_manual(values = my_cols)


# continous classifications (gradient)
    # as.factor means each color is discrete, we dont do it here so there is a gradient
p_grad <- ggplot(d, aes(x = displ, y = cty, col = hwy)) + geom_point(size = 3)


# custom gradient (2 colors)
p_grad + scale_color_gradient(low = "green", high = "red")

# custom divergive gradient (3 colors)
mid <- median(d$cty)
p_grad + scale_color_gradient2(midpoint = mid, low = "blue", mid = "white", high = "red")


#custom diverging gradient colors (n-colors)
p_grad + scale_color_gradientn(colors = c("blue", "green", "yellow", "purple", "orange"))




# Color Palettes
print(wes_palettes)

demoplot(wes_palettes$BottleRocket1,"pie")

demoplot(wes_palettes[[2]][1:3],"bar")


my_cols <- wes_palettes$GrandBudapest2[1:4]
p_fil + scale_fill_manual(values=my_cols)


library(RColorBrewer)
display.brewer.all()
display.brewer.all(colorblindFriendly=TRUE)

demoplot(brewer.pal(4,"Accent"),"bar")

demoplot(brewer.pal(11,"Spectral"),"heatmap")

my_cols <- c("grey75",brewer.pal(3,"Blues"))
p_fil + scale_fill_manual(values=my_cols)


# nice for seeing hex values!
library(scales)
show_col(my_cols)



#### Making a heat map
xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar,yVar=yVar)
head(myData)



zVar <- myData$xVar + myData$yVar + 2*rnorm(n=150)
myData <- cbind(myData,zVar)
head(myData)


# default gradient colors in ggplot
p4 <- ggplot(myData) +
      aes(x=xVar,y=yVar,fill=zVar) +
  geom_tile()
print(p4)


# user defined divergent palette
p4 + scale_fill_gradient2(midpoint=19,
                          low="brown",
                          mid=grey(0.8),
                          high="darkblue")


# viridis scale
p4  + scale_fill_viridis_c()


# options viridis, cividis, magma, inferno, plasma
p4 + scale_fill_viridis_c(option="inferno")


#desaturated viridis
p4 <- p4 + geom_tile() + scale_fill_viridis_c() 
p4des<-edit_colors(p4, desaturate)
plot(p4des)
