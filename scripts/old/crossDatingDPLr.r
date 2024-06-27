library (dplR)
data(co021)
dat <- co021
head(dat)
str(dat)
dat.sum <- summary(dat)
mean(dat.sum$year)
mean(dat.sum$stdev)
mean(dat.sum$median)
mean(dat.sum$ar1)
mean(interseries.cor(dat)[, 1])
plot(dat, plot.type="spag")

## create a missing ring by deleting a random year of
## growth in a random series
RNGversion("2.15.0")
set.seed(4576)
i <- sample(x=nrow(dat), size=1)
j <- sample(x=ncol(dat), size=1)
tmp <- dat[, j]
tmp <- c(NA, tmp[-i])
dat[, j] <- tmp

rwl.60 <- corr.rwl.seg(dat, seg.length=60, pcrit=0.01)
rwl.00 <- corr.rwl.seg(co021, seg.length=60, pcrit=0.01)

## look at this series with a running correlation
seg.60 <- corr.series.seg(rwl=dat, series="643114",seg.length=60)

win <- 1800:1960
dat.yrs <- time(dat)
dat.trunc <- dat[dat.yrs %in% win, ]
ccf.30 <- ccf.series.rwl(rwl=dat.trunc, series="643114",seg.length=30, bin.floor=50)



win <- 1850:1900
dat.trunc <- dat[dat.yrs %in% win, ]
ccf.20 <- ccf.series.rwl(rwl=dat.trunc, series="643114", seg.length=20, bin.floor=0)

xskel.ccf.plot(rwl=dat, series="643114", win.start=1865, win.width=40)
