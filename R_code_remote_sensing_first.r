#il mio primo codice in R per il rilevamento!

#spiegare a R che vogliamo usare la cartella lab con funzione setwd
setwd("C:/lab/")
#abbiamo installato il pacchetto con install.packages("raster")
#per utilizzare il pacchetto utilizziamo la funzione library
library(raster)

#inseirire i dati della cartella lab all' interno di R
#brick importa l' immagine satellitare
#con la freccia si assegna un nome all' oggetto, il file è esterno ad R e si usano le virgolette
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#vedere le caratteristiche del file
p224r63_2011
#vedere le bande con plot
plot(p224r63_2011)

#Day 2
#cambio della scala dei colori(stabiliamo la variazione dei colori che sono numeri che rappresentano la riflettanza in una certa lunghezza d'onda)
#con la c prima della parenesi si indica un vettore, il numero 100 indica i livelli di colore
#si inserisce la freccia per dare un nome alla color scale
cl <- colorRampPalette(c("black","grey","light grey")) (100)
#si plotta l' immagine con la scala di colori che abbiamo creato
plot(p224r63_2011, col=cl)
#nuova scala di colori
cl <- colorRampPalette(c("red","orange","pink","blue","yellow")) (100)
plot(p224r63_2011, col=cl)

#Day 3
#richiamare il pacchetto e i dati della cartella che utilizziamo
library (raster)
setwd("C:/lab/")
# si associa il nome e si richima l' immagine
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#si plotta l' immagine con la scala di colori assegnata 
cl <- colorRampPalette(c("red","orange","pink","blue","yellow")) (100)
plot(p224r63_2011, col=cl)

#Bande Landsat
#B1: banda del blu
#B2: banda del verde
#B3: banda del rosso
#B4: infrarosso vicino
#B5: infrarosso medio
#B6: infrarosso lontano (termico)
#B7: infrarosso medio

#si plotta la banda del blu
#dev.off ripulisce la finestra grafica
dev.off()
#nome della banda blu è B1_sre vista dalle informazioni 
#si spiega al sistema che vogliamo solo l' immagine della banda B1_sre e che si lega con il $ all' immagine satellitare
plot(p224r63_2011$B1_sre)
#plottare la banda 1 con una diversa scala di colori
cls <- colorRampPalette(c("red","orange","pink","blue","yellow")) (100)
plot(p224r63_2011, col=cls)
# si chiude la grafica
dev.off()
#si utilizza par per inserire le bande che vogliamo noi, è una funzione generica per fare un settaggio dei parametri di un certo grafico da creare
#si plotta il grafico con la banda del blu e quella del verde accanto si fa un multifrime (mf)->par, altrimenti sovrascriverebbe
#par inserisce le immagini in una sola riga e due colonne, si si vogliono due righe e una colonna si invertono i numeri in parentesi
#1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#2 rows, 1 column
#se si vuole usare come primo numero del comando le colonne sarà => par(mfcol=c(...,...))
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plottiamo le prime 4 bande di Landsat su 4 righe e una colonna
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#disporre le immagini in modo di distribuirle in configurazione 2x2
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#bande in rappresentazione 2x2
par(mfrow=c(2,2))
# per ogni banda si da una colorRampPalette che riporta a quella banda
#si plotta la banda del blu
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)
#si plotta la banda del verde
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)
#si plotta la banda del rosso
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)
#si plotta la banda dell' infrarosso
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)
