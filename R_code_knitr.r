#R_code_knitr.r
#inserire all'interno di uno stesso file pdf più immagini
#creare un vero report di codice e immagini

#settaggio wd
setwd("C:/lab/")

#installo il pacchetto 
#install.packages("knitr")

#richiamo il pacchetto
library(knitr)
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
