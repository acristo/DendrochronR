############################################
###CONCEPTOS BASICOS DE DENDROCRONOLOGIA#####
#########################################

##  1) vincular carpeta de trabajo y cargar paquetes
## copiar ruta en el explorador de su equipo y pegar entre las comillas
## de la siguiente expresi?n:
## setwd('')
## setwd('~/Documents/Eventos/Curso_R/')
setwd("e:/Users/jose/Dropbox/taller Dendro/scan")
dir()#ver archivos en la carperta

#instalar paquetes
install.packages("measuRing")
install.packages("dplR")
install.packages("ggplot2")
install.packages("reshape2")
#cargar paquetes
packs<-c('measuRing',"dplR","reshape2","ggplot2")
sapply(packs,require,character.only=TRUE)

##2) Abrir imagen y marcar anillos
PT07_2362A<-ringDetect("PT07_2362A.tif",#nombre de archivo
                       last.yr=2014,#anio de formacion del ultimo anillo
                       segs=5,#numero de segmentos para dicvidir la imagen
                       ratio=c(10,5),#tamanio de la imagen (alto y ancho)
                       auto.det=F#sin deteccion automanica 
                       )

##Deteccion automatica de anillos
PT07_2362A<-ringDetect("PT07_2362A.tif",last.yr=2014,segs=5,marker = 5,ratio=c(10,5),
                       origin=-0.015,#sensibilidad de deteccion
                       rgb=c(0,0,1))#mejorar contraste de la imagen, con pinos funciona mejor trabajar sobre la banda azul
#excluir anillos
Rexc_2362A<-ringSelect(PT07_2362A,any.col=F)
#incluir anillos
Rinc_2362A<-ringSelect(PT07_2362A)

#actualizar serie 
PT07_2362A<-update (PT07_2362A,segs=4,exc=c(Rexc_2362A),inc=c(Rinc_2362A))

#unir las muetras del arbol
PT07_2362<-merge(PT07_2362A$'ringWidths',PT07_2362B$'ringWidths',by='year',all=T)
plot(PT07_2362$year,PT07_2362$PT07_2362A,type='l',col='blue')
lines(PT07_2362$year,PT07_2362$PT07_2362B,col='red')

#UNIR series de todos los arboles
PT07<-Reduce(function(x, y) merge(x, y, by="year",all=TRUE), 
             list(PT07_2362,PT07_2376,PT07_2408))

PT07_plot<-melt(PT07, id.vars="year", variable.name="sample", value.name="TRW")
ggplot(data=PT07_plot, aes(x=year, y=TRW, group=sample,colour=sample)) +geom_line() +
    geom_point(size=2,shape=21, fill="white")

## 3) CROSS-DATING
## 
## calcular correlacion entre series
##requiere data frame con las series en columnas y el anio como filas
rownames(PT07) <- PT07[,1]
PT07$year<-NULL
corr.rwl.seg(PT07, seg.length=10, #longitud del segmento
             bin.floor=1975)#donde empieza el analisis

#CROSS-CORRELATION entre las series y la cronologia maestra
ccf.series.rwl(rwl=PT07,series='PT07_2408A',seg.length=6, bin.floor=1985,lag.max=3)
           
#estadisticas descriptivas de las series
rwl.stats(PT07)

## 4) Guardar espacio de trabajo
save.image("e:/Users/jose/Dropbox/taller Dendro/scan/cores.RData")
#load("e:/Users/jose/Dropbox/taller Dendro/scan/cores.RData")#cargar espacio de trabajo