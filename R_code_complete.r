# R code complete - Telerilevamento Geo-Ecologico

#-----------------------------------------------

#Summary:

# 1. Remote sensing first code
# 2. R code time series
# 3. R code Copernicus data 
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover
# 10. R code variability

#-----------------------------------------------

# 1. Remote sensing first code

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
#si installa il pacchetto in R "RStoolbox"
install.packages("RStoolbox")

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
dev.off() #per chiudere le precedenti finestre grafiche


#-----------------------------------------------

# 2. R code time series

#time series analysis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

#install.packages("raster")
#richiamo il pacchetto raster
library(raster)
#settaggio wd
setwd("C:/lab/Greenland")

#importiamo i dati all'interno della cartella che rappresentano la stima della temperatura "lst" che deriva da Copernicus;
#carichiamo i dati singolarmente con la funzione "raster" 
lst_2000 <- raster("lst_2000.tif")
#plottiamo il primo dataset
plot(lst_2000)
#procediamo con il caricamento dei file successivi
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")
#si plottano i 4 dataset in una configurazione quadrata
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#per importare le immagini tutte insieme si utilizza lapply
#lapply: applico la funzione raster a una lista di file (rlist), nel nostro caso i file lst
#list.files: crea la lista di file che R utilizzerà per applicare la funzione lapply
list.files()
#con pattern ricerchiamo i file che ci servono in base alle caratteristiche comuni nel nome (in questo caso lst)
rlist <- list.files(pattern="lst")
#si visualizza in contenuto
rlist
#lapply: x=lista dove applicare la funzione FUN= funzione raster da applicare
#applichiamo il raster con lapply a tutta la lista creata ("rlist")
import <- lapply(rlist,raster)
#visualizzo le caratteristiche dei file della lista importati
import
#si crea un unico pacchetto con tutti i file raster importati utilizzando la funzione "stack"
TGr <- stack(import) 
#serve per ottenere il plot di tutti i file insieme per facilitare la visualizzazione
plot(TGr)

#immagini sovrapposte con schema RGB associando le immagini di temperatura alle bande del rosso, del verde e nel blu
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
plotRGB(TGr, 2, 3, 4, stretch="Lin") 

#installazione pacchetto rasterVis per la visualizzazione dei dati raster
install.packages("rasterVis") 
library(rasterVis)
#richiamo le funzioni precedenti
setwd("C:/lab/Greenland")
rlist <- list.files(pattern="lst") #lista file
rlist
import <- lapply(rlist,raster)
import
TGr <- stack(import)
TGr
# levelplots R package: si ha un unica legenda per tutto il blocco di immagini a disposizione con gamma di colori più compatta
levelplot(TGr)
#si cambia la colorRampPalette
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
#si riplotta con il colore cambiato
levelplot(TGr, col.regions=cl)
#si possono cambiare i titoli delle immagini con la funzione names.attr (per nominare i singoli attributi)
#main è l'argomento, quindi in questo caso il titolo della mappa, messo tra virgolette perchè è un testo
levelplot(TGr,col.regions=cl, main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#dati melt, si crea una lista dei file con pattern comune "melt" o "annual"
meltlist <- list.files(pattern="melt")
#si applica la funzione "lapply" alla lista appena creata e si applica la funzione raster
#si da un nome all' oggetto che contiene la funzione "lapply"
melt_import <- lapply(meltlist,raster)
#raggruppo i file importati con la funzione "stack"
melt <- stack(melt_import)
melt
#faccio un level plot 
levelplot(melt)
#valori più alti indicano un maggiore scioglimento
#si effettua una sottrazione tra il primo e il secondo dato associando al risultato un nome
#mettiamo $ per legare ogni raster interno al proprio file
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
#creo una nuova colorRampPalette
clb <- colorRampPalette(c("blue","white","red"))(100)
#sia plot che levelplot
plot(melt_amount, col=clb) #tutte le zone rosse sono quelle che dal 2007 al 1979 riguardano uno scioglimento più alto
#si fa un level plot
levelplot(melt_amount, col.regions=clb)

#-----------------------------------------------

# 3. R code Copernicus data 

#R_code_copernicus.r
# Visualizzazione dei dati copernicus

#installo il pacchetto "ncdf4"
install.packages("ncdf4")
library(ncdf4)

#richiamo il pacchetto raster
library(raster)

#settaggio wd
setwd("C:/lab/")
#dare un nome al dataset e associato alla funzione raster perchè carichiamo un singolo layer
soilH2Oindex <- raster("soilH2Oindex.nc") 
soilH2Oindex
#facciamo il plot utilizzando la colorRampPalette perchè è un unico layer
cl <- colorRampPalette(c('light blue','green','yellow','red'))(100)
plot(soilH2Oindex, col=cl)
#resampling=ricampionare e diminuire la dimensione dei pixel, è un ricampionamento bilineare
#estraggo da un pixel la media dei valori più grandi utilizzando la funzione fact, con una dominuzione lineare
soilH2Oindexres <- aggregate(soilH2Oindex, fact=100)
plot(soilH2Oindexres, col=cl)

#-----------------------------------------------

# 4. R code knitr

#R_code_knitr.r
#inserire all'interno di uno stesso file pdf più immagini
#creare un vero report di codice e immagini

#settaggio wd
setwd("C:/lab/")

#installo il pacchetto 
#install.packages("knitr")

#richiamo il pacchetto
library(knitr)
#con "stitch" si utilizza uno script di R generando un pdf in versione di report, si enera in maniera automatica
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#-----------------------------------------------

# 5. R code multivariate analysis

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
#richiamare le librerie e seleziono la cartella di riferimento
library(raster)
library (RStoolbox)
setwd("C:/lab/")
#carico l'immagine con brick per avere l'intero set di dati
p224r63_2011 <-brick ("p224r63_2011_masked.grd")
#aggreghiamo i pixel ad esempio con una media per ottenere una risoluzione più bassa
#aggregate:ricampionamento, aggreghiamo le celle, il fact è il fattore di ingrandimento del pixel
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #si passa da un pixel di 30 metri a uno di 300 metri
#facciamo il plot per visualizzare l'immagine con risoluzione minore e la mettiamo a confronto con quella originale
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")
#per utilizzare la funzione PCA si prendono i dati originali e si fa passare un asse lungo la variabilità maggiore e un altro asse lungo la variabilità minore
#rasterPCA: prende il pacchetto di dati e lo compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
#vediamo la varianza delle bande utilizzando la funzione summary, che fornisce un sommario del modello
summary(p224r63_2011res_pca$model) #si lega la mappa al modello
#con plot, prendo l'immagine modello la unisco alla mappa
plot(p224r63_2011res_pca$map) #la prima componente ci dà l'informazione mentre l'ultima è solo rumore
p224r63_2011res_pca
#plottiamo quindi in RGB tutta l'immagine
plotRGB(p224r63_2011res_pca$map, r=1,g=2,b=3, stretch="lin") #vediamo un'immagine che utilizza tutte e tre le componenti principali
#per ottenere informazioni più complesse del file utilizzo la funzione "str" (structure)
str(p224r63_2011res_pca)

#-----------------------------------------------

# 6. R code classification

#R code classification 
#codice per classificare immagini

#richiamo i pacchetti da utilizzare all' interno del codice
library(raster)
library(RStoolbox)
#settaggio wd
setwd("C:/lab/")

#caricare immagine solar orbiter data con funzione brick che va a prendere un immagine fuori da R prendendo l'intero pacchetto di layer mettendole insieme
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#visualizziamo i dettagli
so
#visualizziamo i livelli RGB appartenenti all'immagine caricata
#nome dell' oggetto da rappresentare, i tre livelli nelle tre componenti rosso verde e blu, e con stretch lineare
plotRGB(so, 1,2,3, stretch="lin")

#classifichiamo le immagini con la funzione all'interno pacchetto RStoolbox 
#funzione che opera la classificazione non supervisionata (unsupervised classification)= unsuperClass
#è specificata la tipologia di classe e nClasses è il numero di classi, la associamo a un oggetto soc
soc <- unsuperClass(so, nClasses=3)
#plottiamo l'immagine per vedere cosa è stato creato in uscita
#ciò che plottiamo è la mappa, una parte dell'immagine, soc si lega con $ a map
plot(soc$map)

# funzione che fa in modo di utilizzare le stesse regole nel modello= set.seed(42)
#classificazione con 20 classi
set.seed(42)
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

#nuova immagine del sole
sun <- brick("sun.png")
#classifichiamo l'immagine
sunc <- unsuperClass(sun, nClasses=20)
plot(sunc$map)

#classificazione immagini grand canyon data 

#caricare immagine RGB con i tre livelli attraverso il comando brick
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#visualizziamo l'immagine con stretch lineare
plotRGB(gc, r=1,g=2,b=3, stretch="lin")
#cambiamo il tipo di stretch in histogram che crea un effetto ancora più alto 
plotRGB(gc, r=1,g=2,b=3, stretch="hist")
#utilizziamo la classificazione del pacchetto in tre classi
gcc <- unsuperClass(gc, nClasses=3)
#fare il plot dell'immagine legando la mappa al modello
plot(gcc$map)
#facciamo la classificazione in quattro classi e successivo plot dell' immagine
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#-----------------------------------------------

# 7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#-----------------------------------------------

# 8. R code vegetation indices

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

#-----------------------------------------------

# 9. R code land cover

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

#-----------------------------------------------

# 10. R code variability

#R_code_variability.r

#richiamo i pacchetti necessari allo svolgimento dell'analisi

library(raster)
library(RStoolbox)
library(ggplot2) #per usare le funzioni di ggplot2
library(gridExtra) #per mettere insieme più plot di ggplot2
#install.packages("viridis")
library(viridis) #serve per colorare i plot di ggplot2 in automatico

#fare il set della working directory
setwd("C:/lab/")

#importiamo l'immagine con funzione brick che prende tutto il blocco del dataset e assegnamo un nome
sent <- brick("sentinel.png")

#segue un plottaggio RGB
plotRGB(sent, stretch="lin") 
# NIR 1, RED 2, GREEN 3 (la sequenza che noi vogliamo utilizzare)
#le inseriamo nello schema RGB
# r=1, g=2, b=3 #composizione di default
#plotRGB(sent, stretch="lin") #plotRGB(sent, r=1, g=2, b=3, stretch="lin")

#se cambiamo l'ordine del NIR otteniamo un'immagine con la parte vegetata verde fluo
plotRGB(sent, r=2, g=1, b=3, stretch="lin") 

#per il calcolo della dev.standard utilizziamo una sola banda, maggiore sarà la variabilità, maggiore sarà la dev.standard
#con la finestra mobile calcoliamo la dev.standard dell'area di pixel da noi selezionata, noi siamo liberi di spostarla riportando i valori sul pixel centrale
nir <- sent$sentinel.1
red <- sent$sentinel.2

#creiamo il singolo strato per il calcolo della dev.standard calcolando l'indice di vegetazione
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)
plot(ndvi,col=cl)

#calcolo della dev.standard dell'immagine: si utilizza la funzione focal che calcola la statistica che si vuole tramite la moving window
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

#cambiamo la colorRampPalette
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=clsd)
#dove il colore tende al rosso e al giallo la dev.standard è più alta, il verde e il blu indicano che è bassa

#calcoliamo la media dell'ndvi con focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvimean3, col=clsd)

#cambiamo la grandezza della moving window variando il numero di pixel da selezionare. deve essere un numero dispari
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd) #finestra 13x13 pixel
#cambio la colorRampPalette e successiva visualizzazione
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd13, col=clsd)

#cambiamo la grandezza della moving window 5x5 pixel
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
#cambio la colorRampPalette e successiva visualizzazione
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)

#PCA
#altra tecnica per compattare i dati è quella del calcolo del PCA, con rasterPCA: analisi componente principale per raster
sentpca <- rasterPCA(sent) 
plot(sentpca$map)
#nelle quattro immagini notiamo il cambiamento da un componente ad un altro, con una notevole perdita di informazioni riscontrata nell'immagine 4

#vediamo la proporzione di variabilità del modello di ogni singola componente, dove la prima contiene il 67.36804% dell'informazione originale
summary(sentpca$model)

#per l'analisi controlliamo le componenti della mappa all'interno di sent
#prima componente PC1
pc1 <- sentpca$map$PC1
#pc1 verrà sempre associato alla funzione focal, dove invece dell'NDVI si utilizza pc1
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
#cambio la colorRampPalette e visualizzo l' immagine
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)

#"surce" richiama un pezzo di codice che è stato già creato
#si salva il codice che si vuole far girare e si fa partire dentro R

#pc1 <- sentpca$map$PC1
#pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
#plot(pc1sd7)
source("source_test_lezione.r") #sarà il calcolo di una DVstandard 7x7 su R
#si può utilizzare un intero script da poter richiamare in R con funzione surce
#con mappa della DVstandard, si usa gglot per plottare e con gridArrange li uniamo tutti insieme, occorre assicurarsi di avere la libreria ggplot2 per questo ora si aggiunge, inseme a GridExtra e Viridis (per i colori in ggplot) 
source("source_ggplot.r")


# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#creare la finestra in ggplot2,con funzione ggplot, dove inseriamo dei blocchi definendo la geometria della mappa
#defianiamo i mapping e le aestetics (lo strato o layer)
#associamo ogni plot a un oggetto
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
# Il pacchetto viridis contiene otto scale di colori: "viridis", la scelta primaria, e cinque alternative con proprietà simili - "magma", "plasma", "inferno", "civids", "mako" e "razzo" - e una mappa dei colori dell'arcobaleno - "turbo".
scale_fill_viridis()  +
#aggiungiamo un titolo
ggtitle("Standard deviation of PC1 by viridis colour scale")

#ripetiamo l'azione cambiando la legenda, utilizzando la funzione option, cambiamo di conseguenza anche il titolo 
p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "turbo")  +
ggtitle("Standard deviation of PC1 by turbo colour scale")

#con la funzione grid.arrange metto insieme i tre plot con le tre legende, tutto su una sola riga
grid.arrange(p1, p2, p3, nrow = 1)


