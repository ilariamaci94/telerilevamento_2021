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
