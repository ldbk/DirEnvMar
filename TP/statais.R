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
  scale_fill_distiller(palette="Spectral",trans="log10")
  
ggplot()+
  geom_raster(data=zoneAIS,aes(x=x,y=y,fill=plaisance))+
  scale_fill_distiller(palette="Spectral",trans="log10")

ggplot()+
  geom_raster(data=zoneAIS,aes(x=x,y=y,fill=dragage))+
  scale_fill_distiller(palette="Spectral",trans="log10")

#structure du jeu de données
str(zoneAIS)
#selection variables
ais<-zoneAIS[,3:7]
#calul de distance
dais<-dist((ais))
#classification
hdais<-hclust(dais,method="ward.D2")
plot(hdais)
rect.hclust(hdais,k=6)
#recup les zones homogènes
zoneAIS$zones<-cutree(hdais,6)

ggplot()+
  geom_raster(data=zoneAIS,aes(x=x,y=y,fill=zones))+
  scale_fill_distiller(palette="Spectral")

tmp<-zoneAIS%>%pivot_longer(pêche:plaisance)%>%
  mutate(zones=as.factor(zones))
ggplot()+
  geom_boxplot(data=tmp,aes(x=zones,y=value,fill=zones))+
  facet_wrap(~name,scale="free_y")

