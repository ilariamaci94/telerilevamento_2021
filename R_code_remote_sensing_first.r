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
#cambio della scala dei colori(stabiliamo la variazione dei colori che sono numeri che rappresentano la riflettanza in una certa lunghezza d'onda)
#con la c prima della parenesi si indica un vettore, il numero 100 indica i livelli di colore
#si inserisce la freccia per dare un nome alla color scale
cl <- colorRampPalette(c("black","grey","light grey")) (100)
#si plotta l' immagine con la scala di colori che abbiamo creato
plot(p224r63_2011, col=cl)
#nuova scala di colori
cl <- colorRampPalette(c("red","orange","pink","blue","yellow")) (100)
plot(p224r63_2011, col=cl)
