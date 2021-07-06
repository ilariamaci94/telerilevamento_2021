#il mio primo codice in R per il rilevamento!

#spiegare a R che vogliamo usare la cartella lab con funzione setwd
setwd("C:/lab/")
#abbiamo installato il pacchetto con install.packages("raster")
#per utilizzare il pacchetto utilizziamo la funzione library
library(raster)

#inseirire i dati della cartella lab all' interno di R
#brick importa l' immagine satellitare e assegnare un nome 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#vedere le caratteristiche del file
p224r63_2011
#vedere le bande con plot
plot(p224r63_2011)
