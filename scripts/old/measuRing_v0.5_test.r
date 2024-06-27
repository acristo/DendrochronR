library('measuRing')
?measuRing
?ringSelect
?multiDetect


     ## Paths to three image sections in the package:
     img <- system.file(c("P105_a.tif",
                          "P105_b.tif",
                          "P105_d.tif"),
                        package="measuRing")
     
     ## Recursive detection. Arbitrary ring borders and different years
     ## of formation of last rings in the images years are specified:
     mrings <- multiDetect(img,
                           inclu = list(c(1:40),c(1:30),c(1:41)),
                           last.yr = list(2014, 2013, 2012),
                           auto.det = c(FALSE,TRUE,FALSE),
                           plot = TRUE)
     str(mrings)
     
     ## Updating the call in mrings using new arguments: 
     mrings1 <- update(mrings,
                       exclu = list(c(1:4),c(1:4),c(1:4)),
                       last.yr = 2016)















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
