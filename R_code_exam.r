#il cambiamento della costa mediterranea della spagna

#si effettua il settaggio della working directory e richiamo i pacchetti da utilizzare 
setwd("C:/lab/esame")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

#visualizzo le due immagini 
#faccio un plot ggRGB
# b1=NIR, b2=red, b3=green
p1 <- ggRGB(riumar1984, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(riumar2021, r=1, g=2, b=3, stretch="lin")
#metto insieme le due immagini 
grid.arrange(p1, p2, nrow=1)

#1. differenza tra le due immagini
riu1984 <- raster("riumarspain_oli_1984306_lrg.jpg")
riu2021 <- raster("riumarspain_oli_2021311_lrg.jpg")
plot(riu1984)
plot(riu2021)

#plottare l' immagine con una ColorRampPalette differente
cl <- colorRampPalette(c("magenta","pink", "white","light blue","blue","green")) (100)
plot(riu1984, col=cl)
plot(riu2021, col=cl)

#faccio la differenza tra le due immagini
riu_dif <- riu1984-riu2021
plot(riu_dif, col=cl)

#plotto tutte e tre le immagini insieme con par
par(mfrow=c(1,3))
plot(riu1984, col=cl, main="foce nel 1984")
plot(riu2021, col=cl, main="foce nel 2021")
plot(riu_dif, col=cl, main="Differenza (1984-2021)")



#2. calcolo NDVI
#visualizzo i dettagli delle immagini
riumar1984
riumar2021  

#NDVI per la prima immagine
ndvi1 <- (riumar1984$riumarspain_oli_1984306_lrg.1 - riumar1984$riumarspain_oli_1984306_lrg.2) / (riumar1984$riumarspain_oli_1984306_lrg.1 + riumar1984$riumarspain_oli_1984306_lrg.2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(ndvi1, col=cl, main="NDVI 1984")
#NDVI per la seconda immagine
ndvi2 <- (riumar2021$riumarspain_oli_2021311_lrg.1 - riumar2021$riumarspain_oli_2021311_lrg.2) / (riumar2021$riumarspain_oli_2021311_lrg.1 + riumar2021$riumarspain_oli_2021311_lrg.2) 
plot(ndvi2, col=cl, main="NDVI 2021")

#si effettua la differenza per i due indici NDVI 
difndvi <- ndvi1 - ndvi2
dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld, main="Difference NDVI 1984-2021") 
#dove si hanno differenze più marcate c'e il colore rosso

#indice interessante NDWI
#spectralIndices, si richiama l'immagine e le bande attraverso il numero che corrisponde alla banda
vi1 <- spectralIndices(riumar1984, green=3, red=2, nir=1)
plot(vi, col=cl)

vi2 <- spectralIndices(riumar2021, green=3, red=2, nir=1)
plot(vi, col=cl)

#2. PCA
#richiamo l' intero pacchetto delle due immagini e le plotto insieme con lo schema RGB
riumar1984 <- brick("riumarspain_oli_1984306_lrg.jpg")
riumar2021 <- brick("riumarspain_oli_2021311_lrg.jpg")

#visualizzo i dettagli delle immagini
riumar1984
riumar2021  

#plotto le tre bande con una colorRampPalette
cl <- colorRampPalette(c("yellow","orange","magenta","purple","blue")) (100)
plot(riumar1984, col=cl)
plot(riumar2021, col=cl)

#plotto i valori della banda 1 dei pixel contro i valori della banda 2 dei pixel
plot(riumar1984$riumarspain_oli_1984306_lrg.1,riumar1984$riumarspain_oli_1984306_lrg.2, col="red", pch=19, cex=1)
plot(riumar2021$riumarspain_oli_2021311_lrg.1,riumar2021$riumarspain_oli_2021311_lrg.2, col="red", pch=19, cex=1)

#mettiamo in correlazione a due a due tutte le variabili di un certo set (le bande). correlazione tra la 1 e 2 del 98%
pairs(riumar1984)
pairs(riumar2021)

#dato che la PCA è un analisi impattante aggreghiamo il dato facendo la media per avere una risoluzione più bassa
riumar1984_res <- aggregate(riumar1984, fact=10) #si passa da un pixel di 30 metri a uno di 300 metri
riumar2021_res <- aggregate(riumar2021, fact=10)
#plotto le immagini con risoluzione minore
par(mfrow=c(2,1))
plotRGB(riumar1984_res, r=1, g=2, b=3, stretch="lin")
plotRGB(riumar2021_res, r=1, g=2, b=3, stretch="lin")
#si procede con l' analisi PCA
#rasterPCA: prende il pacchetto di dati e lo compatta in un numero minore di bande
riumar1984_res_pca <- rasterPCA(riumar1984_res)
riumar2021_res_pca <- rasterPCA(riumar2021_res)

#visualizzo la varianza delle bande fornendo un sommario del modello che si è generato con la pca
summary(riumar1984_res_pca$model)
#Importance of components:
#                           Comp.1      Comp.2      Comp.3
#Standard deviation     90.2810304 15.70709890 5.524396191
#Proportion of Variance  0.9671054  0.02927337 0.003621183
#Cumulative Proportion   0.9671054  0.99637882 1.000000000

#la PC1 spiega il 96,71% della varianza. ha tutta l' informazione
plot(riumar1984_res_pca$map) 

summary(riumar2021_res_pca$model)
#Importance of components:
#                           Comp.1     Comp.2     Comp.3
#Standard deviation     63.8952022 30.4745884 8.96954576
#Proportion of Variance  0.8018062  0.1823932 0.01580061
#Cumulative Proportion   0.8018062  0.9841994 1.00000000
#la PC1 spiega l'80 % della varianza.
plot(riumar2021_res_pca$map)

#plot RGB dell'analisi sfruttando le componenti principali
par(mfrow=c(2,1))
plotRGB(riumar1984_res_pca$map, r=1,g=2,b=3, stretch="lin")
plotRGB(riumar2021_res_pca$map, r=1,g=2,b=3, stretch="lin")
#colori legati alle tre componenti 
#R_code land cover
#R_code spectral signature
