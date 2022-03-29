library(raster)
library(tidyr)
library(dplyr)
library(ggplot2)

#read the data
load("../data/zoneAIS.rdata")
#data ?
summary(zoneAIS)
str(zoneAIS)
#a map
ggplot(zoneAIS)+
  geom_raster(aes(x=x,y=y,fill="pêche"))

