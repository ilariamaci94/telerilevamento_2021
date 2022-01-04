#R_code_no2.r

#1. set the working directory EN

setwd("C:/lab/EN")

library(RStoolbox) #utilizzato per l' analisi multivariata dei raster
#2. carico il pacchetto raster per caricare la prima banda della prima immagine 
library(raster)
EN01 <- raster("EN_0001.png")
plot(EN01)

# 3. plottare l' immagine con una ColorRampPalette differente
cl <- colorRampPalette(c("orange","light blue","blue","dark blue")) (100)
plot(EN01, col=cl)

# 4. importa l' ultima immagine (la 13) e la plottiamo con la precedente ColorRampPalette
EN13 <- raster("EN_0013.png")
cl <- colorRampPalette(c("orange","light blue","blue","dark blue")) (100)
plot(EN13, col=cl)

#5. si fa la differenza tra le due immagini, si associa a un oggetto e si plotta
#differenza tra gennaio e marzo
ENdif <- EN01-EN13
plot(ENdif, col=cl)

#6. plot di tutte e tre le immagini insieme con par
par(mfrow=c(1,3))
plot(EN01, col=cl, main="NO2 in January")
plot(EN13, col=cl, main="NO2 in March")
plot(ENdif, col=cl, main="Difference (Jenuary - March)")

# 7. importo tutto il set di bande 

#creo la lista
list.files()
rlist <- list.files(pattern="EN")
rlist #visualizzo la lista
#si applica la funzione raster tramite la funzione lapply a tutta la lista che ho fatto
import <- lapply(rlist,raster)
import

#si fa uno stack di tutti i layer (si compattano) e li visualizzo con la ColorRampPalette assegnata precedentemente
EN <- stack(import) 
plot(EN, col=cl)

# 8. replicare il plot dell' immagine 1 e 13 usando lo stack 
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#9. si fa una PCA sulle 13 immagini a disposizione
#rasterPCA: prende il pacchetto di dati e lo compatta in un numero minore di bande
ENpca <- rasterPCA(EN)
#vediamo la varianza delle bande utilizzando la funzione summary, che fornisce un sommario del modello
summary(ENpca$model) #si lega la mappa al modello

#plottiamo quindi in RGB tutta l'immagine
plotRGB(ENpca$map, r=1,g=2,b=3, stretch="lin") #vediamo un'immagine che utilizza tutte e tre le componenti principali

# 10. calcolo della variabilità della prima componente della PCA
PC1sd <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cl)
