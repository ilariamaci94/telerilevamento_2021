#R_code_multivariate_analysis.r

#richiamo i pacchetti e si fa il settaggio della wd
library(raster)
library (RStoolbox)
setwd("C:/lab/") 
#con brick carico un intero set di dati che importo dal sistema operativo 
p224r63_2011 <-brick ("p224r63_2011_masked.grd")
#visualizzo i dettagli dell'immagine
p224r63_2011
#verranno visualizzate tutte le bande da B1 a  B7
plot (p224r63_2011) 
#Facciamo il plot della B1 contro B2, cambiando colore in rosso, PCH sceglie il simbolo e cex cambia la dimensione dei punti
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#invertiamo le due bande sugli assi 
plot(p224r63_2011$B2_sre,p224r63_2011$B1_sre, col="red", pch=19, cex=2)
#con la funzione pairs possiamo plottare tutte le correlazioni possibili di una serie di variabili di un dataset a due a due
#varranno visualizzati anche gli indici di correlazione che varia tra -1 e 1 dove più le bande sono correlate(tendono a 1) più le dimensioni del carattere è maggiore
pairs(p224r63_2011)


#PCA ANALISI IMPATTANTE quindi si ricampiona il dato in modo che sia più leggero con la funzione Aggregate, cambiamo quindi la risoluzione iniziale 
#richiamare le librerie e cartelle di riferimento
library(raster)
library (RStoolbox)
setwd("D:/lab/")
p224r63_2011 <-brick ("p224r63_2011_masked.grd")
#aggregate: resampling o ricampionamento, aggreghiamo le celle, il fact è il fattore di ingrandimento del pixel, fun serve ad aggregare i valori 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
#facciamo il plot per visualizzare l'immagine e li mettiamo a confronto
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")
#la funzione per fare la PCA, dove prendiamo i dati originali e facciamo passare un asse per i dati di variabilità maggiore e uno per il minore
#rasterPCA prende il pacchetto di dati e lo compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
#vediamo la varianza utilizzando la funzione summary, che è molto generica e base,dà un sommario del nostro modello
summary(p224r63_2011res_pca$model) #così vediamo la varianza nelle varie bande
#con plot, prendo l'immagine modello la unisco alla mappa
plot(p224r63_2011res_pca$map)
p224r63_2011res_pca
#plottiamo quindi in rgb tutta l'immagine
plotRGB(p224r63_2011res_pca$map, r=1,g=2,b=3, stretch="lin") #vediamo un'immagine che utilizza tutte e tre le componenti principali
#per ottenere informazioni più complesse del file utilizzo la funzione str (structure)
str(p224r63_2011res_pca)
