time series analysis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

#richiamo il pacchetto raster
library(raster)
#richiamo pacchetto rasterVis
library(rasterVis)
#settaggio wd
setwd("C:/lab/greenland")
#carichiamo il primo dei file del set, sono singoli dati. Non si usa brick ma raster
#raster:carichiamo singoli dati, importiamo il primo
lst_2000 <- raster("lst_2000.tif")
#possiamo plottarlo
plot(lst_2000)
#procediamo con il file successivo
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
#anche gli ultimi due
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")
#mettiamo insieme i plot
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
#vogliamo importare i file tutti insieme invece di usare raster e importarli uno per volta, usiamo quindi lapply
#lapply: applicare la funzione raster a una lista di file (rlist), nel nostro caso i file lst
#la list.files: crea la lista che R utilizzerà per applicare la funzione lapply
list.files()
#con pattern ricerchiamo i file che ci servono in base alle caratteristiche comuni nel nome,come il fatto che tutti si chiamano lst
rlist <- list.files(pattern="lst")
rlist
#lapply: x=lista dove applicare la funzione FUN= funzione raster da applicare (il tutto si applica a tutti i file lst)
import <- lapply(rlist,raster)
import
#ora possiamo creare un unico pacchetto di file con tutti quelli importati, lo facciamo con la funzione stack
#stack function: abbiamo una lista di file raster e li mettiamo tutti insieme
TGr <- stack(import) 
#ci servirà per ottenere il plot di tutti i file insieme
plot(TGr)
#immagini sovrapposte con schema RGB
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin") #plot con valori della temperatura
#installazione pacchetto metodi di visualizzazione per dati raster
install.packages("rasterVis") 
library(rasterVis)
setwd("D:/lab/greenland")
rlist <- list.files(pattern="lst")
rlist
import <- lapply(rlist,raster)
import
TGr <- stack(import)
TGr
# levelplots R package: utilizziamo un intero blocco con una singola legenda e plottiamo tutto insieme
levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
#poi riplottare
levelplot(TGr, col.regions=cl)
#possiamo cambiare i titoli delle immagini con la funzione names.attr (per nominare i singoli attributi)
#main è l'argomento, quindi nel nostro caso il titolo dellla mappa, messo tra virgolette perchè un testo
levelplot(TGr,col.regions=cl, main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#dati melt, creiamo una lista dei file con pattern comune "melt" o "annual"
meltlist <- list.files(pattern="melt")
#importo i file
melt_import <- lapply(meltlist,raster)
#raggruppo i file importati
melt <- stack(melt_import)
melt
#posso fare un level plot solo ora con dati melt
levelplot(melt)
#valori più alti >scioglimento
#metricsalgebra applicato alle matrici per lo studio di dati temporali, facciamo la sottrazione tra primo e ultimo dato, mettiamo $ per legare uno strato all'altro
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
#creo una nuova colorramppalette
clb <- colorRampPalette(c("blue","white","red"))(100)
#sia plot che levelplot
plot(melt_amount, col=clb)
levelplot(melt_amount, col.regions=clb)
