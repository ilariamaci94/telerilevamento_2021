#R_code_copernicus.r
# Visualizzazione dei dati copernicus

#installo il pacchetto "ncdf4"
install.packages("ncdf4")
library(ncdf4)

#richiamo il pacchetto raster
library(raster)

#settaggio wd
setwd("C:/lab/")
#dare un nome al dataset e associato alla funzione raster perchè carichiamo un singolo layer
soilH2Oindex <- raster("soilH2Oindex.nc") 
soilH2Oindex
#facciamo il plot utilizzando la colorRampPalette perchè è un unico layer
cl <- colorRampPalette(c('light blue','green','yellow','red'))(100)
plot(soilH2Oindex, col=cl)
#resampling=ricampionare e diminuire la dimensione dei pixel, è un ricampionamento bilineare
#estraggo da un pixel la media dei valori più grandi utilizzando la funzione fact, con una dominuzione lineare
soilH2Oindexres <- aggregate(soilH2Oindex, fact=100)
plot(soilH2Oindexres, col=cl)
