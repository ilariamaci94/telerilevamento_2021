#il cambiamento della costa mediterranea della spagna

#si effettua il settaggio della working directory e richiamo i pacchetti da utilizzare 
setwd("C:/lab/esame")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

#differenza tra le due immagini
riu1984 <- raster("riumarspain_oli_1984306_lrg.jpg")
riu2021 <- raster("riumarspain_oli_2021311_lrg.jpg")
plot(riu1984)
plot(riu2021)

#1. differenza tra le immagini
#plottare l' immagine con una ColorRampPalette differente
cl <- colorRampPalette(c("magenta","pink", "white","light blue","blue","green")) (100)
plot(riu1984, col=cl)
plot(riu2021, col=cl)
#faccio la differenza tra le due immagini
riu_dif <- riu2021-riu1984
plot(riu_dif, col=cl)

#PCA
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
