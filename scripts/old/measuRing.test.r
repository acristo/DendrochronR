library('measuRing')
?measuRing
?ringSelect
   count1 <- ringDetect(
         image = system.file("P105_a.tif", package="measuRing"),
         ppi = 10^3,
         last.yr = 2012,
         segs = 5,
         method = 'linear',
         inclu = NA,
         exclu = NA,
         tit = 'measuRing example')


     count1 <- ringDetect(
         image = system.file("P105_a.tif", package="measuRing"),
         ppi = 10^3,
         last.yr = 2012,
         segs = 2,
         method = 'linear',
         inclu = NA,
         exclu = NA,
         tit = 'measuRing example')
     output produces two figures for including or excluding ring borders.
     
     ## uncomment and run:        
      inc <- ringSelect(count1,'inc') #choose pixels on image segments to include.
      ## vector inc is used to evaluate ringDetect again:
      count2 <- ringDetect(
          image = system.file("P105_a.tif", package="measuRing"),
          ppi = 10^3,
          last.yr = 2012,
          segs = 2,
          method = 'linear',
          inclu = inc, ## Argument inclu contains now values in object inc
          exclu = NA,
          tit = 'measuRing example')
      summary(count2$pixelTypes) #included pixels were added to pixelTypes data.
      exc <- ringSelect(count2,'exc') #choose pixels on image segments to exclude.
      ## Both vectors: inc and exc are used to evaluate ringDetect again:
      count3 <- ringDetect(
          image = system.file("P105_a.tif", package="measuRing"),
          ppi = 10^3,
          last.yr = 2012,
          segs = 2,
          method = 'linear',
          inclu = inc, ## Argument inclu contains now values in object inc
          exclu = exc, ## Argument exclu contains now values in object exc
          tit = 'measuRing example')
