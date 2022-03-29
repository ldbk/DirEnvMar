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
ggplot()+
  geom_raster(data=zoneAIS,aes(x=x,y=y,fill=pêche))+
  scale_fill_distiller(palette="Spectral",name="Densité de\n navires\n(h.km^2)",
                       trans="log10")
  

