#R_code_vegetation_indices.r

#importiamo le librerie e  il set della working directory
library(raster) #require(raster)
library(RStoolbox)
setwd("C:/lab/")

#con funzione brick importiamo le immagini defor
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
#plottiamo le immagini con plotRGB e le visualizziamo insieme
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#calcoliamo un indice di vegetazione,facendo la differenza tra la riflettanza dell'infrarosso vicino "NIR"(massima riflettanza) e la riflettanza nel rosso (minimo di riflettanza)
#per ogni pixel prendiamo la banda dell' infrarosso vicino (NIR)  e del rosso (red), si prende lo stesso pixel per le diverse bande e si fa la differenza
# si ottiene una mappa formata da tanti pixel che rappresentano il difference vegetation index "DVI"
dvi1 <- defor1$defor1.1 - defor1$defor1.2 
#plottiamo l'immagine effettuando prima il dev.off() 
plot(dvi1) #visualizziamo lo stato di salute della vegetazione

#facciamo una colorRampPalette per ottenere una classificazione migliore nel nostro plot
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi1, col=cl, main="DVI at time 1")

#facciamo la stessa cosa per il calcolo del DVI2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")
#plottiamo i due dvi insieme con la funzione "par"
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#abbiamo quindi i due indici e cogliamo le forti differenze nella medesima zone in tempi diversi facendo la differenza tra i due dvi
difdvi <- dvi1 - dvi2
#visualizziamo con il plot cambiando la colorramppalette facendo prima un dev.off() 
dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld) #maggiore valore=maggiore differenza

#calcoliamo l'NDVI (DVI normalizzato) facendo una standardizzazione sulla loro somma
#con NDVI possiamo paragonare immagini che hanno risoluzione radiometrica diversa
#range di NDVI va da -1 a +1
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)
#si può utilizzare direttamente dvi1 perchè abbiamo già il calcolo della sottrazione 
#ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot(ndvi1, col=cl)

#calcolo l' NDVI della seconda immagine con successivo plottaggio
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

#RStoolbox:contiene la funzione spectralIndices che permette di controllare tutti gli indici
#spectralIndices, si richiama l'immagine e le bande attraverso il numero che corrisponde alla banda
vi <- spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi, col=cl) #calcolerà tutti gli indici spettrali mettendoli insieme, tranne quelli del blu

vi2 <- spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)

#si effettua la differenza per i due indici NDVI 
difndvi <- ndvi1 - ndvi2
dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld) 

#install.packages("rasterdiv")
library(rasterdiv) #per lavorare con NDVI 

#si plotta la copertura globale NDVI
plot(copNDVI)
#si possono cambiare i pixel dei valori che non interessano (acqua) con "cbind", trasformandoli in NA 
#viene riclassificata l'immagine
copNDVI <- reclassify (copNDVI, cbind (253:255, NA))
plot(copNDVI)
#utilizziamo levevlplot contenuto in rastervis per originare i livelli, perciò richiamiamo la libreria
library(rasterVis)
levelplot(copNDVI)
