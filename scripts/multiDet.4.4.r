####################################################################################################################################
####################################################################################################################################
##
## Script for dendrochronologic analysis with measuRing
##
## Initial version: Wilson Lara Henao
##
####################################################################################################################################
####################################################################################################################################
##
## Modifications: José Riofrío, Ana Martín Ariza, Cristóbal Ordóñez
##
####################################################################################################################################
####################################################################################################################################
####################################################################################################################################



                                        # Install libraries. In linux do as root in commandline
## chooseCRANmirror(FALSE)
## install.packages('tidyr')
## install.packages('XML')
## install.packages('dplR')
## install.packages('tiff')
## install.packages('measuRing')
## install.packages('DendroSync')
## install.packages("tidyverse")
## install.packages("signal")


###################################################################################################################################
#############################################                                                    ##################################
#############################################       initial part                                 ##################################
#############################################       common for the whole parts of this script    ##################################
#############################################                                                    ##################################
###################################################################################################################################


                                        # Load libraries
library("measuRing")
library("dplR")
library("tidyr")
## library("dplyr")
library('DendroSync')
library("tidyverse")
library("signal")


                                        # R console wide lenght
## options(width=163)
## options(width=180)
options(width=200)


                                        # sample folder
dir()
## setwd('~/github/DendrochronR')
setwd('~/Documents/dendro')
dir()
## setwd('~/github/DendrochronR/Matalindo/PurePine3')
## setwd('~/github/DendrochronR/smart-images')
## setwd('~/Documents/dendro/smart-images')
setwd('~/Documents/dendro/Matalindo/PurePine2')
dir()
dir(pattern='RData')

rm(list=ls()) # vaciamos el entorno de trabajo---- BE CAREFULL #####



                                        # load work environment data
                                        # carga del entorno de trabajo
load(file='allRings.RData')

                                        # list of samples and parameters for autodetect function
                                        # election of image file to analyze
                                        # store names of images includer in work folder in vector v.nam
(v.nam <- dir( pattern='*.tif') )


                                        # variables for multidetect function
LastYear  = 2023  # year of the last complete ring (can be a list) // año del último anillo (puede ser una lista si no varios)
Segs      = 1     # number of parts to divide the image  //  número de segmentos en los que dividimos la imagen para analizarla
Origin    = 0.01  # image sensitivity //  sensibilidad en la detección de la MG
AutoDet   = TRUE  # automatic detection of rings  // detección automática de anillos, se puede poner en una lista
Darker    = F     # true for finding negative extremes (quercus for example)
ColMarker = 'red' #
Plot      = TRUE  # show plot to mark or delete rings // mostrar gráfico para incluir o eliminar anillos
ls()



####################################################################################################################################
## these webs are a good option to investigate about crossdating with dplR package
## dplR is part of openDendro https://opendendro.org.
## New users can visit https://opendendro.github.io/dplR-workshop/ to get started.
####################################################################################################################################




####################################################################################################################################
################################################                                    ################################################
################################################   Ring counting and marking part   ################################################
################################################                                    ################################################
####################################################################################################################################

            ## Deteccion multiple # 3 escenarios posibles #
     ## utilizamos una lista aparte en la que podemos analizar 1 o mas archivos
     ## se puede utilizar para:


#############################################
## START OF LOAD PART
#############################################


     ##  A              START the analisys
## all.rings <- NULL
img  <- v.nam
## analizamos todas las muestras del directorio de golpe
(img <- v.nam[c(13)]) # elegimos algunas
AutoDet    <- F
## deteccion automatica
ToInc      <- NULL




      ##  B              ADD samples to the analisys

(n.all.ring <- names(all.rings))
## comprobamos la muestra en la que nos llegamos
v.nam # muestras en el listado

(img0 <- setdiff(v.nam, n.all.ring))
img <- img0
(img <- img0[c(1,2)])

## (img <- v.nam[c(9,10)]) # elegimos algunas

names(all.rings) # comprobamos la muestra en la que nos llegamos
## (img <- v.nam[c(14,22)]) # y elegimos las muestras
## (img <- v.nam[c(1)]) # y elegimos las muestras

j<-2
(img <- v.nam[j]) # y elegimos las muestras

AutoDet    <- F # deteccion automatica
ToInc      <- NULL




      ##   C              MODIFY samples already analyzed

##--RE-ANALISIS DE MUESTRAS PARA CROSSDATING CON multiDetect-------#
## comprobamos con crossdating que muestra esta peor y elegimos jpg
(v.nam <- dir( pattern='*.tif'))
j<-8
(img <- v.nam[j]) # y elegimos las muestras
## (id.muestra <- substr(muestra, 1, nchar(muestra)-4) )
## (img    <- muestra) # cambiar si no coincide el nombre de la muestra y de la lista de archivos
## img     <- "Oa531E.tif"
## quitar los 3 primeros caracteres 
names(all.rings) # comprobamos la muestra en la que nos llegamos
i       <-  10
## buscamos el numero de muestra en la lista principal
(muestra<- names(all.rings[i]) ) # comprobamos que es el que realmente queremos
AutoDet <- FALSE # usamos lo detectado anteriormente, no la deteccion automatica
(ToInc  <- attributes(all.rings[[i]])[["coln"]]) # Extraemos vector con anillos marcados originalmente


#############################################
## END OF LOAD PART
#############################################






#############################################
## START OF FUNCTION PART
#############################################

############# A, B AND C    FUNCTION COMMON FOR ALL 3 SCENARIOS ##################
d.ring <- NULL
Segs <- 1
X11.options(width = 148, height = 6, xpos = 0, pointsize = 10) # ajustar el tamaño de la ventana grafica
X11()
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

#############################################
## END OF FUNCTION PART
#############################################






#############################################
## START OF STORE PART
#############################################
                                        # la lista d.ring se actualiza de forma distinta segun sea para:

       ##  A AND B              START analysis // or // ADD samples
names(d.ring)
names(all.rings)
all.rings <- c(all.rings, d.ring) # se añaden las muestras que acabamos de analizar
names(all.rings)
all.rings[c("call")] <- NULL # repetir hasta que desaparezcan los "call" externos a las muestras
names(all.rings)





        ##    C             MODIFY sample
(name.last.ring <- names(all.rings[i]) )# comprobamos que la muestra que vamos a eliminar es la adecuada
all.rings[[i]] <- NULL                  # primero se elimina la muestra que queremos actualizar
names(all.rings[name.last.ring])              #
names(all.rings)              #
all.rings <- c(all.rings, d.ring) # luego se aÃ±ade la que acabamos de cambiar
names(all.rings)
all.rings[c("call")] <- NULL # repetir hasta que desaparezcan los "call" externos a las muestras
names(all.rings)

#############################################
## END OF STORE PART
#############################################




####################################################################################################################################
################################################                                    ################################################
################################################    Analysing crossdating samples   ################################################
################################################                                    ################################################
####################################################################################################################################

str(all.rings)
rings <- reduceList(all.rings,name.ls= "ringWidths",T)
head(rings,50)
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
cols <- c(1:5)

selected.rings <- all.rings[cols]

crossRings(selected.rings, smp = 1, ncol = 1:length(selected.rings), fun = "spag")


Cross_corr <- crossRings(selected.rings,fun ='corr', seg.length = 10, bin.floor = 0, lag.max = 2, make.plot = T, pcrit =0.1)
Cross_corr[["spearman.rho"]][order((Cross_corr[["spearman.rho"]][,11])),]



## comprobamos con crossdating que muestra esta peor
names(all.rings)
v.nam
## comprobamos la muestra en la que nos llegamos
i <- 10
j <- 8
## buscamos el numero de muestra en la lista principal
(muestra  <- names(all.rings[i]) )
(img <- v.nam[j])

for (i in 1:length(names(all.rings))) {
    x11()
    a <- crossRings(all.rings, i, fun ='ccf',seg.length = 10,bin.floor = 0,lag.max = 3,make.plot = T,pcrit =0.1)
}







####################################################################################################################################
################################################                                    ################################################
################################################      Save and export analysis      ################################################
################################################                                    ################################################
####################################################################################################################################



## str(Cross_prueba$spearman.rho)
dir(pattern='.RData')
dir()
ls()

                                        # save analisys in RData format
save("all.rings", ## "n.all.ring", "n.dom.ring",  "n.nodom.ring", 
     file='allRings.RData')

                                        # save analisys in csv format
rings <- reduceList(all.rings,name.ls= "ringWidths",T)
write.csv(rings,file='rings.csv')


q()
n