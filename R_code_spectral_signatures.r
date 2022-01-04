#R_code_spectral_signatures.r

#importiamo i pacchetti necessari

library(raster)
library(rgdal)
library(ggplot2)

#fare il set della working directory

setwd("C:/lab/")

#carichiamo il dataset

defor2 <- brick("defor2.jpg") 

#segue un plot e inseriamo le bande che ci interessano, NIR, red, green

#possiamo farlo anche con HIST, creando una curva logistica con differenze di colore molto più accentuate

#utilizziamo l'immagine per ottenere delle firme spettrali con la funzione click(cliccando sulla mappa otterremo le info sulla riflettanza)

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="magenta") 

#cliccando sulla mappa su una zona con vegetazione otteniamo  
#x     y   cell defor2.1 defor2.2 defor2.3
#1 131.5 245.5 166476      187        9       21  notiamo che nella prima banda abbiamo un valore molto alto di riflettanza nel nir, nel socondo molto basso e nella terza medio basso
#se clicchiamo dove c'è un corso d'acqua otteniamo 
#x     y   cell defor2.1 defor2.2 defor2.3
#1 191.5 177.5 215292       59       52       83 notiamo una riflettanza molto bassa in NIR, ma molto alta in rosso e blu

#dobbiamo chiudere l'immagine per poter proseguire

#creiamo un dataframe e con ggplot2 creiamo le firme spettrali
#definiamo le colonne del dataset, otterremo una tabella a tre colonne
band <- c(1,2,3)
forest <- c(187, 9, 19)
water <- c(59, 52, 83)

#mettiamo tutto insieme nel creare il dataframe così da ottenere la tabella

output <- data.frame(band,forest,water)
output #la visualizziamo

#possiamo ora fare il plot con ggplot2, per le firme spettrali di un dataset nel mio caso output
#x è definita da funzione aestetics, ed assegnamo il valore band, per le y le due restanti colonne
#assegnamo le geometrie nel plot, connette le osservazioni a seconda dei dati definiti su x

ggplot(output, aes(x=band)) + 
    geom_line(aes(y = forest), color = "green")+ #notiamo un'altissima riflettanza nella banda1,una bassa nella 2 e medio bassa nella 3
    geom_line(aes(y = water), color = "blue", linetype = "dotted")+ #l'acqua si comporta diversamente rispetto alla vegetazione con valori molto simili ma con una riflettanza più bassa nel rosso, anche il nir ha comunque un valore molto basso
    labs(x="band", y="reflectance") #la funzione labs assegnamo il nome ai valori x e y

    
#analisi multitemporale calcolando la variabilità degli assi
#utilizziamo defor1 e defor2

defor1 <- brick("defor1.jpg")

plotRGB(defor1, 1,2,3, stretch="Lin")

#creiamo le firme spettrali defor1

click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")

#time1
#clicchiamo sopra l'ansa del fiume e prendiamo i primi 5 valori
     #x     y   cell defor1.1 defor1.2 defor1.3
#1 77.5 321.5 111462      225       13       35
     #x     y   cell defor1.1 defor1.2 defor1.3
#1 66.5 330.5 105025      213       12       30
     #x     y   cell defor1.1 defor1.2 defor1.3
#1 79.5 335.5 101468      210       13       33
      #x     y   cell defor1.1 defor1.2 defor1.3
#1 102.5 331.5 104347      226       13       33
     #x     y  cell defor1.1 defor1.2 defor1.3
#1 82.5 351.5 90047      168       66       62
     #x     y  cell defor1.1 defor1.2 defor1.3

plotRGB(defor2, 1,2,3, stretch="Lin")

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")
#time2  
#x     y  cell defor2.1 defor2.2 defor2.3
#1 85.5 351.5 90428      181      168      162
     #x     y  cell defor2.1 defor2.2 defor2.3
#1 64.5 347.5 93275      190      181      172
     #x     y  cell defor2.1 defor2.2 defor2.3
#1 96.5 340.5 98326      204      163      159
     #x     y  cell defor2.1 defor2.2 defor2.3
#1 84.5 340.5 98314      195      166      152
     #x     y  cell defor2.1 defor2.2 defor2.3
#1 75.5 348.5 92569      125       63       52


#creiamo il dataset definiamo le colonne del dataset

band <- c(1,2,3)
time1 <- c(225, 13, 35)
time2 <- c( 181, 168, 162)
spectralst <- data.frame(band,time1,time2)
spectralst

ggplot(spectralst, aes(x=band)) + 
    geom_line(aes(y = time1), color = "red")+
geom_line(aes(y = time2), color = "blue", linetype = "dotted")+ 
 labs(x="band", y="reflectance")
#notiamo i pixel del time1 con altissima riflettanza in NIR e nel time2 nello stesso punto abbiamo un un rosso molto più alto
#aggiungiamo altri dati di pixel del primo e secondo tempo e riplottiamo

band <- c(1,2,3)
time1 <- c(225, 13, 35)
time1p2 <- c(213, 12, 30)
time2 <- c( 181, 168, 162)
time2p2 <- c(190, 181, 172)

spectralst <- data.frame(band,time1,time1p2,time2,time2p2)
spectralst

ggplot(spectralst, aes(x=band)) + 
    geom_line(aes(y = time1), color = "red")+
geom_line(aes(y = time1p2), color = "red") +
geom_line(aes(y = time2), color = "blue", linetype = "dotted")+ 
geom_line(aes(y = time2p2), color = "blue", linetype = "dotted")+
 labs(x="band", y="reflectance")
#abbiamo così 2 pixel per ogni momento, che mantengono lo stesso andamento in red e blue, se usiamo n pixel, occorre utilizzare una funzione extract che estrae i valori delle bande sui pixel randomizzati, generando il grafico.
#possiamo cambiare la dimensione della linea con l'argomento linetype

#Immagini da Earth observatory

EO <- brick("june_puzzler.jpg")
plotRGB(EO, 1,2,3, stretch="Lin") 
click(EO, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")
#x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 386.5 137.5 246627            224            222            101
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 347.5 163.5 227868             20            149             20
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 283.5 247.5 167324             26             34             11

band <- c(1,2,3)
strato1 <- c(224, 222, 101)
strato2 <- c(20,149, 20)
strato3 <- c( 26, 34,11)


spectralstrati <- data.frame(band,strato1, strato2, strato3)
spectralstrati

ggplot(spectralst, aes(x=band)) + 
    geom_line(aes(y = strato1), color = "yellow")+
geom_line(aes(y = strato2), color = "green")+
geom_line(aes(y = strato3), color = "black", linetype = "dotted")+ 
 labs(x="band", y="reflectance")

#notiamo 3 elevate differenze, nello strato1 e 2 notiamo un picco di riflettanza nella seconda banda, tutte e tre hanno bassa riflettanza nella banda 3




