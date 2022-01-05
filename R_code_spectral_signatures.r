#R_code_spectral_signatures.r

#importiamo i pacchetti necessari

library(raster)
library(rgdal)
library(ggplot2)

#fare il set della working directory

setwd("C:/lab/")

#carichiamo il dataset caricando tutte le bande

defor2 <- brick("defor2.jpg") 
#abbiamo tre bande defor2.1, defor2.2, defor2.3
# a cui corrispondono NIR, red, green

#facciamo un plot dell'immagine 
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#possiamo farlo anche con HIST, creando una curva logistica con differenze di colore molto più accentuate
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#utilizziamo l'immagine per ottenere delle firme spettrali con la funzione click(cliccando sulla mappa otterremo le info sulla riflettanza)
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="magenta") #T=true - pch=tipo di punto

#result:
#cliccando sulla mappa su una zona con vegetazione otteniamo  
#     x     y   cell     defor2.1   defor2.2   defor2.3
# 1 131.5 245.5 166476      187        9        21   #notiamo che nella prima banda abbiamo un valore molto alto di riflettanza nel nir, nel socondo molto basso e nella terza medio basso
#se clicchiamo dove c'è un corso d'acqua otteniamo 
#     x     y   cell     defor2.1   defor2.2   defor2.3
# 1 191.5 177.5 215292       40       99        139   #notiamo una riflettanza molto bassa in NIR, ma molto alta in rosso e blu

#dobbiamo chiudere l'immagine per poter proseguire

#creiamo un dataframe e con ggplot2 creiamo le firme spettrali
#per creare un dataframe si fa uno storage dei dati
#si definiscono le colonne del dataset, otterremo una tabella a tre colonne
band <- c(1,2,3) #inseriamo le bande 1 2 3 
forest <- c(187, 9, 21) #le tre bande per la foresta
water <- c(40, 99, 139) #le tre bande per l' acqua

#mettiamo tutto insieme in modo da ottenere la tabella con "data.frame"

spectrals <- data.frame(band,forest,water)
spectrals #visualizzo la tabella

#possiamo ora fare il plot con ggplot2, per le firme spettrali del dataset spectrals
#x è definita da funzione aestetics, ed assegno le bande
#alle y assegno la riflettanza della foresta e la riflettanza dell' acqua
#assegnamo le geometrie nel plot con "geom_line", connette le osservazioni a seconda dei dati definiti su x

ggplot(spectrals, aes(x=band)) + 
    geom_line(aes(y = forest), color = "green")+ #notiamo un'altissima riflettanza nella banda1,una bassa nella 2 e medio bassa nella 3
    geom_line(aes(y = water), color = "blue")+ #l'acqua ha un comportamento opposto alla vegetazione; l' acqua nel NIR assorbe quasi tutto
    labs(x="band", y="reflectance") #la funzione labs assegnamo il nome ai valori x e y


    
#analisi multitemporale calcolando la variabilità degli assi
#utilizziamo defor1 e defor2

defor1 <- brick("defor1.jpg")

plotRGB(defor1, 1,2,3, stretch="Lin")

#creiamo le firme spettrali defor1

click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")

#time1
#clicchiamo sopra l'ansa del fiume e prendiamo i primi 5 valori
# x     y   cell defor1.1 defor1.2 defor1.3
#1 33.5 332.5 103564      203        5       22
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 75.5 338.5 99322      215       27       44
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 54.5 344.5 95017      177       38       43
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 70.5 373.5 74327      227       18       37
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 75.5 394.5 59338      245       42       72

#si fa la stessa cosa per la defor2
plotRGB(defor2, 1,2,3, stretch="Lin")

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")
#time2  
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 88.5 338.5 99752      190      153      144
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 106.5 346.5 94034      220      212      193
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 91.5 352.5 89717      173      144      140
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 90.5 359.5 84697      165      164      143
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 109.5 356.5 86867      211      120      129


#creiamo il dataset definiamo le colonne del dataset

band <- c(1,2,3)
time1 <- c(203, 5, 22)
time2 <- c(190, 153, 144)
spectralst <- data.frame(band,time1,time2)
spectralst

ggplot(spectralst, aes(x=band)) + 
    geom_line(aes(y = time1), color = "red")+
geom_line(aes(y = time2), color = "blue")+ 
 labs(x="band", y="reflectance")
#notiamo i pixel del time1 con altissima riflettanza in NIR e nel time2 nella banda del rosso non c' è il frte assorbimento che c'era per il time1

#aggiungiamo altri dati di pixel del primo e secondo tempo e riplottiamo

band <- c(1,2,3)
time1 <- c(203, 5, 22)
time1p2 <- c(215, 27, 44)
time2 <- c(190, 153, 144)
time2p2 <- c(220, 212, 193)

spectralst <- data.frame(band,time1,time1p2,time2,time2p2)
spectralst

ggplot(spectralst, aes(x=band)) + 
    geom_line(aes(y = time1), color = "red")+
geom_line(aes(y = time1p2), color = "red") +
geom_line(aes(y = time2), color = "blue", linetype = "dotted")+ 
geom_line(aes(y = time2p2), color = "blue", linetype = "dotted")+
 labs(x="band", y="reflectance")
#abbiamo così 2 pixel per ogni momento, che mantengono lo stesso andamento in red e blue
#se usiamo n pixel, occorre utilizzare una funzione extract che estrae i valori delle bande sui pixel randomizzati, generando il grafico.
#possiamo cambiare la dimensione della linea con l'argomento linetype

#Immagini da Earth observatory

EO <- brick("eastcoast_tmo_2022004_lrg.jpg")
plotRGB(EO, 1,2,3, stretch="hist") 
click(EO, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")
#       x      y    cell eastcoast_tmo_2022004_lrg.1 eastcoast_tmo_2022004_lrg.2 eastcoast_tmo_2022004_lrg.3
#1 1170.5 1598.5 4718881                         186                         185                         180
#2 1208.5  464.5 8250195                          79                          66                          32
#3 2433.5 1515.5 4978606                          17                          57                          67
#4 1137.5 2727.5 1203142                          91                          84                          68

band <- c(1,2,3)
punto1 <- c(186, 185, 180)
punto2 <- c(79, 66, 32)
punto3 <- c(17, 57, 67)
punto4 <- c(91, 84, 68)

spectralpunto <- data.frame(band,punto1, punto2, punto3, punto4)
spectralpunto

ggplot(spectralpunto, aes(x=band)) + 
    geom_line(aes(y = punto1), color = "blue")+
geom_line(aes(y = punto2), color = "green")+
geom_line(aes(y = punto3), color = "magenta")+
geom_line(aes(y = punto4), color = "red")+ 
 labs(x="band", y="reflectance")

#si visualizzano tre differenti comportamenti nelle zone individuate, si possono differenziare diverse classi
#ognuno ha la propria firma spettrale 


