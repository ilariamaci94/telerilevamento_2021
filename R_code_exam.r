#il cambiamento della costa mediterranea della spagna

#si effettua il settaggio della working directory e richiamo i pacchetti da utilizzare 
setwd("C:/lab/esame")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis)

#richiamo l' intero pacchetto delle due immagini e le plotto insieme con lo schema ggRGB
riumar1984 <- brick("riumarspain_oli_1984306_lrg.jpg")
riumar2021 <- brick("riumarspain_oli_2021311_lrg.jpg")

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
cl <- colorRampPalette(c("black", "purple", "magenta", "orange", "light yellow")) (100)
par(mfrow=c(1,2))
plot(riu1984, col=cl, main="1984")
plot(riu2021, col=cl, main="2021")

#faccio la differenza tra le due immagini
cldif <- colorRampPalette(c("blue","white","red")) (100)
riu_dif <- riu1984-riu2021
plot(riu_dif, col=cldif, main="Differenza (1984-2021)")




#2. calcolo NDVI
#visualizzo i dettagli delle immagini per prendere la banda del nir e del red
riumar1984
riumar2021  

#bande prima immagine 
nir1 <- riumar1984$riumarspain_oli_1984306_lrg.1
red1 <- riumar1984$riumarspain_oli_1984306_lrg.2

#bande seconda immagine 
nir2 <- riumar2021$riumarspain_oli_2021311_lrg.1
red2 <- riumar2021$riumarspain_oli_2021311_lrg.2

#NDVI per la prima immagine
ndvi1 <- (nir1-red1) / (nir1+red1)

#NDVI per la seconda immagine
ndvi2 <- (nir2-red2) / (nir2+red2)

#plotto le immagini insieme per i due ndvi
par(mfrow=c(1,2))
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(ndvi1, col=cl, main="NDVI 1984")
plot(ndvi2, col=cl, main="NDVI 2021")

#si effettua la differenza per i due indici NDVI 
difndvi <- ndvi1 - ndvi2
dev.off() 
plot(difndvi, col=cldif, main="Difference NDVI 1984-2021") 
#dove si hanno differenze più marcate c'e il colore rosso

#indice interessante NDWI
#spectralIndices, si richiama l'immagine e le bande attraverso il numero che corrisponde alla banda
vi1 <- spectralIndices(riumar1984, green=3, red=2, nir=1)
plot(vi1, col=cl)

vi2 <- spectralIndices(riumar2021, green=3, red=2, nir=1)
plot(vi2, col=cl)



#3. PCA

#visualizzo i dettagli delle immagini
riumar1984
riumar2021  

#plotto le tre bande con una colorRampPalette
cl <- colorRampPalette(c("blue","purple","magenta","orange","yellow")) (100)
plot(riumar1984, col=cl)
plot(riumar2021, col=cl)

#plotto i valori della banda 1 dei pixel contro i valori della banda 2 dei pixel
par(mfrow=c(2,1))
plot(nir1, red1, col="red", pch=19, cex=1)
plot(nir2, red2, col="red", pch=19, cex=1)

#mettiamo in correlazione a due a due tutte le variabili di un certo set (le bande). correlazione tra la 1 e 2 del 98%
pairs(riumar1984)
pairs(riumar2021)


#si procede con l' analisi PCA
#rasterPCA: prende il pacchetto di dati e lo compatta in un numero minore di bande
riumar1984_pca <- rasterPCA(riumar1984)
riumar2021_pca <- rasterPCA(riumar2021)

#visualizzo la varianza delle bande fornendo un sommario del modello che si è generato con la pca
summary(riumar1984_pca$model)
#Importance of components:
#                           Comp.1     Comp.2     Comp.3
#Standard deviation     98.9142738 18.8170131 7.77149819
#Proportion of Variance  0.9593591  0.0347188 0.00592206
#Cumulative Proportion   0.9593591  0.9940779 1.00000000

#la PC1 spiega il 95,93% della varianza.
plot(riumar1984_pca$map) 

#names      :       PC1,       PC2,       PC3 
#min values : -120.0320, -175.7210, -135.0795 
#max values :  297.3841,  132.9909,  116.5419 

summary(riumar2021_pca$model)
#Importance of components:
#                          Comp.1     Comp.2      Comp.3
#Standard deviation     75.587488 31.1996006 10.53050248
#Proportion of Variance  0.840491  0.1431961  0.01631291
#Cumulative Proportion   0.840491  0.9836871  1.00000000#Importance of components:

plot(riumar2021_pca$map)

#names      :       PC1,       PC2,       PC3 
#min values : -112.4919, -123.4539,  -60.0841 
#max values : 302.18501,  93.99771,  72.00665 


#plot RGB dell'analisi sfruttando le componenti principali
c1 <-ggRGB(riumar1984_pca$map, r=1,g=2,b=3, stretch="lin") 
c2 <-ggRGB(riumar2021_pca$map, r=1,g=2,b=3, stretch="lin") 
grid.arrange(c1, c2, nrow=1)
#colori legati alle tre componenti

#4.calcolo la variabilità locale all' interno di una mappa con la deviazione standard
#si lavora su una singola banda e utilizzo la PC1

#prima componente PC1 1984
pc1_1984 <- riumar1984_pca$map$PC1
pc1sd3_1984 <- focal(pc1_1984, w=matrix(1/9, nrow=3, ncol=3), fun=sd)

#prima componente PC1 2021
pc1_2021 <- riumar2021_pca$map$PC1
pc1sd3_2021 <- focal(pc1_2021, w=matrix(1/9, nrow=3, ncol=3), fun=sd)


#plotto con ggplot e i colori prestabiliti
sd1 <- ggplot() +
geom_raster(pc1sd3_1984, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "viridis")  +
ggtitle("Standard deviation of PC1_1984")

sd2 <- ggplot() +
geom_raster(pc1sd3_2021, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "viridis")  +
ggtitle("Standard deviation of PC1_2021")

grid.arrange(sd1,sd2, nrow = 1)

#R_code spectral signature
