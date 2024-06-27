################################################################
## Orginal from Wilson Lara
## Modified by José Riofrío, Ana Martín Ariza, Cristóbal Ordóñez
################################################################

                                        # Install libraries  //  Instalación de librerias
                                        # Install as root in linux
## chooseCRANmirror(FALSE)
## install.packages('tidyr')
## install.packages('XML')
## install.packages('dplR')
## install.packages('tiff')
## install.packages('measuRing')
## install.packages('DendroSync')

                                        # Attach necessary libraries // Carga de librerias necesarios
library("measuRing")
library("dplR")
library("tidyr")
library('DendroSync')

options(width=163) # tamaño de la linea de consola de R
options(width=180) # tamaño de la linea de consola de R

                                        # directorio de muestras
dir()
## setwd('~/cores/TripletMontesdeoca/02109104/dominant')
setwd('~/cores/TripletMontesdeoca/07109103/dominant')
## setwd('~/cores/TripletMontesdeoca/97209102/dominant-Fsy')
## setwd('~/cores/TripletMontesdeoca/97209102/dominant-Psy')
## setwd('~/cores/TripletMontesdeoca/02109206/dominant')
## setwd('~/cores/TripletMontesdeoca/07109205/dominant')
## setwd('~/cores/TripletMontesdeoca/97209201/dominant-Fsy')
## setwd('~/cores/TripletMontesdeoca/97209201/dominant-Psy')
dir()
## dir(pattern='RData')

####################################################################
rm(list=ls()) # vaciamos el entorno de trabajo---- BE CAREFULL #####
####################################################################

                                        # carga del entorno de trabajo
load(file='allRings.RData')
## load(file='robles.RData')
## ls()
## all.rings <- roble.d.ring.3
## (n.all.ring <- names(all.rings))
## names(all.rings[1]) <- "Oa508E.tif"
## write(n.all.ring, file='names_r.csv')
## n.all.ring2 <- read.csv(file='names2.csv', stringsAsFactors=FALSE)
## dir()
## n.dom.ring <- readLines('names_dom.csv')
## n.nodom.ring <- readLines('names_nodom.csv')
## str(n.all.ring)
## names(all.rings) <- n.all.ring2



                                        # listado de muestras y parametros de la funcion autodetect
# eleccion de ficheros a analizar
## series.name <- ''
## (v.nam <- dir()[ grep( series.name, dir( pattern='*.tif') ) ] )
(v.nam <- dir( pattern='*.tif') )
## write(v.nam, file='names_f.csv')
# variables para la función multidetect
LastYear  = 2017 # año del último anillo; se puede poner en una lista si no son el mismo para todos
Segs      = 1 # número de segmentos
Origin    = 0.01 # sensibilidad en la detección de la MG
AutoDet   = TRUE # se puede poner en una lista
Darker    = F  # true for finding negative extremes (quercus for example)
ColMarker = 'red'
Plot      = TRUE # mostrar gráfico para incluir o eliminar anillos
## first.year <- 1960
## file.name  <- paste(series.name,".csv", sep = "")
## ls()



            ## Deteccion multiple # 3 escenarios posibles #
     ## utilizamos una lista aparte en la que podemos analizar 1 o mas archivos
     ## se puede utilizar para:


     ##                INICIAR el analisis
all.rings <- NULL
img  <- v.nam
## analizamos todas las muestras del directorio de golpe
(img <- v.nam[c(5,6)]) # elegimos algunas
AutoDet    <- F
## deteccion automatica
ToInc      <- NULL





      ##                AÑADIR muestras al analisis

(n.all.ring <- names(all.rings))
## comprobamos la muestra en la que nos llegamos
v.nam # muestras en el listado
(img0 <- setdiff(v.nam, n.all.ring))
img <- img0
(img <- v.nam[c(9,10)]) # elegimos algunas
names(all.rings) # comprobamos la muestra en la que nos llegamos
## (img <- v.nam[c(14,22)]) # y elegimos las muestras
## (img <- v.nam[c(1)]) # y elegimos las muestras
j<-35
(img <- v.nam[j]) # y elegimos las muestras
AutoDet    <- F # deteccion automatica
ToInc      <- NULL






      ##                 MODIFICAR muestra previamente analizadas
##--RE-ANALISIS DE MUESTRAS PARA CROSSDATING CON multiDetect-------#
## comprobamos con crossdating que muestra esta peor y elegimos jpg
v.nam <- dir( pattern='*.tif')
v.nam
j<-17
(img <- v.nam[j]) # y elegimos las muestras
## (id.muestra <- substr(muestra, 1, nchar(muestra)-4) )
## (img    <- muestra) # cambiar si no coincide el nombre de la muestra y de la lista de archivos
## img     <- "Oa531E.tif"
## quitar los 3 primeros caracteres 
names(all.rings) # comprobamos la muestra en la que nos llegamos
i       <-  7
## buscamos el numero de muestra en la lista principal
(muestra<- names(all.rings[i]) ) # comprobamos que es el que realmente queremos
AutoDet <- FALSE # usamos lo detectado anteriormente, no la deteccion automatica
(ToInc  <- attributes(all.rings[[i]])[["coln"]]) # Extraemos vector con anillos marcados originalmente






X11.options(width = 48, height = 6, xpos = 0, pointsize = 10) # ajustar el tamaño de la ventana grafica

d.ring <- NULL
Segs <- 1
############# FUNCION COMUN PARA LOS 3 ESCENARIOS ##################
d.ring <- multiDetect(img,                   # lista de imagenes a analizar 
                      last.yr    = LastYear,  # año del último anillo;
                      ## se puede poner en una lista si no son el mismo para todos
                     segs       = Segs,      # número de segmentos
                     origin     = Origin,    # 0.01, # sensibilidad en la detección de la MG
                     auto.det   = AutoDet,   # se puede poner en una lista
                     inclu = list(c(ToInc)), # Lista de anillos seleccionados originalmente
                     darker     = Darker,    # true for finding negative extremes (quercus for example)
                     col.marker = ColMarker,
                     plot       = Plot)      # mostrar gráfico para incluir o eliminar anillos
############# FUNCION COMUN PARA LOS 3 ESCENARIOS ##################




                                        # la lista d.ring se actualiza de forma distinta segun sea para:

       #                INICIAR el analisis // o // AÑADIR muestras al analisis
names(d.ring)
names(all.rings)
all.rings <- c(all.rings, d.ring) # se añaden las muestras que acabamos de analizar
names(all.rings)
all.rings[c("call")] <- NULL # repetir hasta que desaparezcan los "call" externos a las muestras
names(all.rings)





        #                 MODIFICAR muestra previamenimg
(name.last.ring <- names(all.rings[i]) )# comprobamos que la muestra que vamos a eliminar es la adecuada
all.rings[[i]] <- NULL                  # primero se elimina la muestra que queremos actualizar
names(all.rings[name.last.ring])              #
names(all.rings)              #
all.rings <- c(all.rings, d.ring) # luego se aÃ±ade la que acabamos de cambiar
names(all.rings)
all.rings[c("call")] <- NULL # repetir hasta que desaparezcan los "call" externos a las muestras
names(all.rings)







str(all.rings)
rings <- reduceList(all.rings,name.ls= "ringWidths",T)
head(rings,15)
str(rings)

                                        #Crossdating
# spagueti plot para ver la correlación
crossRings(all.rings, smp = 1, ncol = 1:length(all.rings), fun = "spag")


Cross_corr <- crossRings(all.rings,fun ='corr',seg.length = 10,bin.floor = 0,lag.max = 2,make.plot = F,pcrit =0.1)
## help(crossRings)
## Cross_prueba[["avg.seg.rho"]]
## Cross_prueba[["overall"]][order((Cross_prueba[["overall"]][,1])),]
Cross_corr[["spearman.rho"]][order((Cross_corr[["spearman.rho"]][,11])),]
## Cross_prueba[["spearman.rho"]][muestra, ] # 
## Cross_prueba[["spearman.rho"]][img, ]


                                        #xDat dominant
## dom.rings <- all.rings[match(n.dom.ring, names(all.rings))]
## Cross_corr <- crossRings(dom.rings,fun ='corr',seg.length = 10,bin.floor = 0,lag.max = 2,make.plot = F,pcrit =0.1)
## Cross_corr[["spearman.rho"]][order((Cross_corr[["spearman.rho"]][,13])),]




                                        # xDat same dominant step by step
cols <- c(9: 10)
n.all0.ring <- all.rings[cols]
selected.rings <- all.rings[match(n.all0.ring, names(all.rings))]

crossRings(selected.rings, smp = 1, ncol = 1:length(selected.rings), fun = "spag")

Cross_corr <- crossRings(selected.rings,fun ='corr',seg.length = 6,bin.floor = 0,lag.max = 2,make.plot = T,pcrit =0.1)
Cross_corr[["spearman.rho"]][order((Cross_corr[["spearman.rho"]][,11])),]



## comprobamos con crossdating que muestra esta peor
names(all.rings)
v.nam
## comprobamos la muestra en la que nos llegamos
i <- 2
j <- 5
## buscamos el numero de muestra en la lista principal
(muestra  <- names(all.rings[i]) )
(img <- v.nam[j])

a <- crossRings(all.rings,1,fun ='ccf',seg.length = 10,bin.floor = 0,lag.max = 3,make.plot = T,pcrit =0.1)

a <- crossRings(all.rings,j,fun ='ccf',seg.length = 6,bin.floor = 0,lag.max = 3,make.plot = T,pcrit =0.1)

a <- crossRings(all.rings,j,fun ='ccf',seg.length = 6,bin.floor = 0,lag.max = 3,make.plot = T,pcrit =0.1)






## str(Cross_prueba$spearman.rho)
x11()
dir(pattern='.RData')
dir()
ls()
save("all.rings", ## "n.all.ring", "n.dom.ring",  "n.nodom.ring", 
     file='allRings.RData')
q()
n
