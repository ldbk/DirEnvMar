## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----lib----------------------------------------------------------------------
library(ncdf4) #si cela ne fonctionne pas me l'indiquer
library(raster)
library(rasterVis)
library(mapdata)
library(maps)


## ----readdata1,eval=F---------------------------------------------------------
## chl<-stack("./data/chl.nc")


## ----readdata2,eval=T---------------------------------------------------------
chl<-stack("./data/chl")


## ----zoneetude, include=T,echo=T,eval=T,fig.height=3--------------------------
#un plot vide
plot(1,xlim=c(-1.5,0.8),ylim=c(49.2,49.7),type="n",xlab="Longitude",ylab="Latitude",asp=1)
#le trait de côte
map("worldHires",xlim=c(-1.5,0.8),ylim=c(49.2,49.7),col="light grey",fill=T,add=T)


## ----xplo,eval=T--------------------------------------------------------------
dim(chl)
names(chl)
str(chl)
#les cartes de chlorophylles
plot(chl)
#plus joli
levelplot(chl)
#encore plus joli
levelplot(chl,margin=F,zscale=T,contour=T,par.settings= viridisTheme,main="Chl 2010-2019")

#pour extraire une partie de l'image
zone<-extent(-0.5,0,49.4,49.8)
chlpetit<-crop(chl,zone)
plot(chlpetit)

#serie temporelle
chlts<-cellStats(chl,stat="mean",na.rm=T)
#vecteur temporel
temps<-strptime(gsub("X","",names(chlts)),"%Y.%m.%d")
plot(temps,chlts,type="l")

#calcul de la moyenne et affichage
meanchl<-mean(chl,na.rm=TRUE)
plot(meanchl)
title("Chl moy 2010-2019")
#pour ajouter le trait de côte
map("worldHires",xlim=c(-1.5,0.8),ylim=c(49.2,49.7),col="light grey",fill=T,add=T)

#le quantile à 90% des cartes
p90glob<-quantile(chl,0.9)
temps<-strptime(gsub("X","",rownames(p90glob)),"%Y.%m.%d")
plot(temps,p90glob,type="l")

#un fonction pour calculer le p90 sur une serie
p90<-function(a,na.rm=T){
  p90tmp<-quantile(a,probs=.9,na.rm=T)
  return(p90tmp)
}
#calcul du P90 par pixel
chlp90<-stackApply(chl,rep(1,nlayers(chl)),p90)

plot(chlp90)


