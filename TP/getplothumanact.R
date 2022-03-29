#proposition 
#package
library(sf)
library(httr)
library(tidyverse)
library(ows4R)
library(raster)
library(ggrepel)
library(rnaturalearthdata)


############################
# get data
#from
#https://inbo.github.io/tutorials/tutorials/spatial_wfs_services/

#test emodnet human act
wfs_ha<-"https://ows.emodnet-humanactivities.eu/wfs"#/wfs?SERVICE=WFS&VERSION=1.1.0&request=GetFeature&typeName=",name,"&OUTPUTFORMAT=csv&WGS84BoundingBox=",bbox)
#get capabilities to have the list of data
bwk_client <- WFSClient$new(wfs_ha,
                            serviceVersion = "1.1.0")
bwk_client
#get capabilities
bwk_client$getCapabilities()
#get features
featlist<-bwk_client$getFeatureTypes(pretty=TRUE)
#truc intéressant
#emodnet:aggregateareas

#a fct to get some data
gethumact<-function(nom="emodnet:aggregateareas",request="GetFeature"){
  url<-parse_url("https://ows.emodnet-humanactivities.eu/wfs")
  #nom="emodnet:aggregateareas"
  url$query <- list(service = "WFS",
                    version = "1.1.0",
                    request = "", 
                    typename="",
                    bbox= "49.1,-2,51.2,1.6", 
                    outputFormat = "application/json")
  url$query$typename<-nom
  url$query$request<-request
  #url$query<-list(typename =nom)
  request <- build_url(url)
  uu<-read_sf(request)
  return(uu)
}

#get the dataaaaa
#nat2000
nat2000<-gethumact("natura2000areas")
#aggregates areas
aggareas<-gethumact('aggregateareas') 
dredgespoil<-gethumact('dredgespoil') 
munpol<-gethumact('munitionspoly') 
munpt<-gethumact('munitions') 
windfarms<-gethumact('windfarmspoly') 
lighthouses<-gethumact('lighthouses') 

#a map
ggplot()+
  #geom_sf(data=nat2000,aes(fill=sitetype),alpha=.2)+
 # geom_sf(data=aggareas%>%mutate(type="agg"),aes(fill=type),alpha=.4)+
#  geom_sf(data=munpol%>%mutate(type="mun"),aes(fill=type),fill="pink")+
#  geom_sf(data=munpt,color="red")+
#  geom_sf(data=windfarms,fill="blue")+
#  geom_sf(data=dredgespoil%>%mutate(type="agg"),aes(color=type))+
  geom_sf(data=lighthouses,color="red")+
  borders("world",fill="grey") +
  coord_sf(ylim=c(49.2,51.2),xlim=c(-2,2))+
  theme_bw()

