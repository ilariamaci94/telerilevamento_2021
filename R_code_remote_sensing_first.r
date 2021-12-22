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
cl <- colorRampPalette(c("purple","pink","yellow","blue","green")) (100)
plot(p224r63_2011, col=cl)

#Day 3
#richiamare il pacchetto e i dati della cartella che utilizziamo
library (raster)
setwd("C:/lab/")
# si associa il nome e si richima l' immagine
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#si plotta l' immagine con la scala di colori assegnata 
cl <- colorRampPalette(c("purple","pink","yellow","blue","green")) (100)
#il nome dell' immagine indica con "p224" il percorso e quindi il numero della sinusoide e con "r" i paralleli e il numero associato ad essi 
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
#si utilizza "par" per plottare le bande che vogliamo noi, è una funzione generica per fare un settaggio dei parametri di un certo grafico da creare
#si plotta il grafico con la banda del blu e quella del verde accanto si fa un multifreme (mf)->par, altrimenti sovrascriverebbe
#"par" inserisce le immagini in una sola riga e due colonne, se si vogliono due righe e una colonna si invertono i numeri in parentesi
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

#disporre le immagini in modo di distribuirle in configurazione quadrata 2x2
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

#Day 4
#Visualizing data by RGB plotting
#richiamare il pacchetto e i dati della cartella che utilizziamo
library (raster)
setwd("C:/lab/")
# si associa il nome e si richima l' immagine
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#Bande Landsat
#B1: banda del blu
#B2: banda del verde
#B3: banda del rosso
#B4: infrarosso vicino
#B5: infrarosso medio
#B6: infrarosso lontano (termico)
#B7: infrarosso medio
#RGB->colori fondamentali di visualizzazione delle immagini con stretch lineare (schema di colori per mostrare le immagini in colori naturali)- tre bande per volta!
 
#si plotta l' immagine in "RGB: Red-Green-Blue plot of a multi-layered Raster object" 
# "stretch": distensione delle bande portando con la combinazione lineare i valori di riflettanza da 0 a 1;
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
 #si utilizza l' infrarosso vicino montandolo sulla componente red dello schema RGB.la vegetazione diventa rossa.
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#mettiamo sulla banda del verde l' infrarosso
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#si mette l' infrarosso nella banda blu
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#si fa il par delle diverse immagini 2x2 con le bande assegnate in precedenza
pdf("il_mio_primoPDF_inR.pdf") #salva l' immagine in formato pdf
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #stretch histogram che tira ancora di più i colori per analizzare tutte le componenti all' interno della foresta
#par with natural colours, flase colours and false colours with hisogram stretching 
#si dispongono le immagini su tre righe e una colonna per notare le differenze tra le diverse visualizzazioni
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#Day 5
#si richiama il pacchetto raster da utilizzare
library(raster)
#settaggio working directory
setwd("C:/lab/")
#carico l'immagine utilizzata precedentemente
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#si inizia con l' analisi multitemporale caricando l'immagine relativa al 1988
#brick importa un intero set di bande
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988
#si plotta l' intera immagine che rappresenta le singole bande in vare lunghezze d'onda
plot(p224r63_1988)
#si plotta l' immagine in RGB in scala naturale 
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
#plotto l'immagine in RGB con l' infrarosso
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
#plotto la stessa immagine per il 1988 e per il 2011 insieme 
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#plotto le immagini sia con lo stretch lineare che histogram con rappresentazione quadrata
pdf("multitemp.pdf") #salvo il plot in pdf
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()
