#il cambiamento della costa mediterranea della spagna

#si effettua il settaggio della working directory e richiamo i pacchetti da utilizzare 
setwd("C:/lab/esame")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis)
library(rgdal)

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
#dove si hanno differenze pi?? marcate c'e il colore rosso

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

#visualizzo la varianza delle bande fornendo un sommario del modello che si ?? generato con la pca
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

# 4.calcolo la variabilit?? locale all' interno di una mappa con la deviazione standard
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

#5. spectral signature
#analisi multitemporale calcolando la variabilit?? degli assi

riumar1984 <- brick("riumarspain_oli_1984306_lrg.jpg")

plotRGB(riumar1984, 1,2,3, stretch="Lin")
#si creano le firme spettrali
click(riumar1984, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")
#       x      y    cell riumarspain_oli_1984306_lrg.1 riumarspain_oli_1984306_lrg.2      riumarspain_oli_1984306_lrg.3
#1  810.5  391.5 2757976                           197                           188                             155
#2 1495.5  980.5 1589496                           194                           183                             155
#3 1375.5 1000.5 1549676                           211                           201                             174
#4 1182.5 1213.5 1126678                           187                           179                             156
#5  966.5  471.5 2599332                           149                           163                             102
 

riumar2021 <- brick("riumarspain_oli_2021311_lrg.jpg")
plotRGB(riumar2021, r=1, g=2, b=3, stretch="Lin")
click(riumar2021, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")

#       x      y    cell riumarspain_oli_2021311_lrg.1 riumarspain_oli_2021311_lrg.2
#1  819.5  390.5 2759970                           106                           113
#2 1471.5 1010.5 1529922                            48                           120
#3 1375.5  991.5 1567541                           176                           158
#4 1165.5 1224.5 1104826                           181                           170
#5  948.5  457.5 2627104                           209                           202
#  riumarspain_oli_2021311_lrg.3
#1                            80
#2                            96
#3                           136
#4                           138
#5                           183

#creo il dataset definiamo le colonne del dataset
band <- c(1,2,3)
time1_p1<- c(197,188,155)
time1_p2<- c(194,183,155)
time1_p3<- c(211,201,174)
time1_p4<- c(187,179,156)
time1_p5<- c(149,163,102)
time2_p1 <- c(106,113,80)
time2_p2 <- c(48,120,96)
time2_p3 <- c(176,158,136)
time2_p4 <- c(181,170,138)
time2_p5 <- c(209,202,183)

spectralst <- data.frame(band,time1_p1,time1_p2,time1_p3,time1_p4,time1_p5,time2_p1,time2_p2,time2_p3,time2_p4,time2_p5)
spectralst

ggplot(spectralst, aes(x=band)) + 
    geom_line(aes(y = time1_p1), color = "red")+
geom_line(aes(y = time1_p2), color = "blue") +
geom_line(aes(y = time1_p3), color = "dark green") +
geom_line(aes(y = time1_p4), color = "magenta") +
geom_line(aes(y = time1_p5), color = "orange") +
geom_line(aes(y = time2_p1), color = "red", linetype = "dotted")+ 
geom_line(aes(y = time2_p2), color = "blue", linetype = "dotted")+
geom_line(aes(y = time2_p3), color = "dark green", linetype = "dotted")+
geom_line(aes(y = time2_p4), color = "magenta", linetype = "dotted")+
geom_line(aes(y = time2_p5), color = "orange", linetype = "dotted")+
 labs(x="band", y="reflectance")
