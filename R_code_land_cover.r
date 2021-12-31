#R_code_land_cover.r

#importiamo le librerie
library(raster)
library(RStoolbox)
#install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra) 

#settaggio della working directory
setwd("C:/lab/")

#carichiamo l'intero dataset con funzione brick
defor1 <- brick("defor1.jpg")
plotRGB (defor1, r=1, g=2, b=3, stretch="lin")
# partendo da tre bande dell'immagine satellitare, possiamo unirle per creare un immagine a banda singola
ggRGB(defor1, r=1, g=2, b=3, stretch="lin") 
#si carica la seconda immagine
defor2 <- brick ("defor2.jpg")
plotRGB (defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#mettere insieme le immagine con il classico plot
par(mfrow=c(1,2)) 
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe con ggplot2 e gridExtra
#grid.arrange mette insieme vari pezzi all'interno del grafico
#diamo un nome ai plot
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
#mettiamo insieme i due plot
grid.arrange(p1, p2, nrow=2)

# unsupervised classification
#viene classificato dal software
#si inseriscono il numero di classi
d1c <- unsuperClass(defor1, nClasses=2)
#visualizziamo i dati
plot(d1c$map) #si lega la mappa al modello per visualizzare le due classi 
#set.seed() permette di avere lo stesso risultato
#classe 1: foresta tropicale
#classe 2:parte agricola
#si crea la seconda mappa
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
#classe 1: parte agricola
#classe 2:foresta tropicale

#classificazione con tre classi
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map) #vengono distinte due zone nella parte agricola, probabilmente perchè vi sono zone a riflettanza nettamente differente

#si calcola la frequenza dei pixel di una certa classe (foresta, parte agricola)
#freq function calcola la frequenza
freq(d1c$map) 
#si rilevano i pixel delle classi
#     value  count
# [1,]     1 306810
# [2,]     2  34482
#si calcola la proporzione/percentuale

#si fa la somma dei due valori ottenuti
s1 <- 306810 + 34482 
#calcoliamo la proporzione
prop1 <- freq(d1c$map) / s1
#prop foresta: 0.8989663
#prop zone agricole : 0.1010337

#si fa anche per la seconda mappa assegnando il numero di pixel a "s2"
s2 <- 342726 
prop2 <- freq(d2c$map) / s2
#prop foresta: 0.5197972
#prop zona agricola : 0.4802028

#per utilizzare le percentuali si moltiplicano x100 le proporzioni

#generiamo un dataframe 
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.89, 10.10)
percent_2006 <- c(51.97, 48.02)

#generiamo il dataframe con la funzione data.frame e diamo un nome e infine lo visualizziamo
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages #visualizziamo le 3 colonne 
#generiamo un grafico con ggplot per il 1992
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
#ripetiamo l'operazione del ggplot per il 2006
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#associamo i plot generati a un nome
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#utilizziamo grid.arrange per unire i ggplot ottenuti occorre avare la library gridExtra, ottenendo così i due grafici delle due annate
grid.arrange(p1, p2, nrow=1)


