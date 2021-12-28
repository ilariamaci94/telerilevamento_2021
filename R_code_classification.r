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
#caricare immagine RGB 
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#visualizziamo l'immagine
plotRGB(gc, r=1,g=2,b=3, stretch="lin")
#cambiamo il tipo di stretch in histogram
plotRGB(gc, r=1,g=2,b=3, stretch="hist")
#utilizziamo la classificazione del pacchetto
gcc <- unsuperClass(gc, nClasses=3)
#fare il plot dell'immagine
plot(gcc$map)
#facciamo la classificazione in 4 classi
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)
