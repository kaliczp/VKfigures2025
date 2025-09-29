press <- read.csv2("fig3.csv",skip=4,head=F)

library(zoo)
library(chron)

## Csapadék
press.csap <- zoo(press[1:6,10],chron(as.character(press[1:6,9]),rep("12:00:00",6),form=c("y.m.d","h:m:s")))

## Nyomás
press.zoo <- zoo(press[,-c(1:2,6:10)],chron(-14187)+press[,1]+press[,2]/6)
ttmp <- smooth.spline(index(na.omit(press.zoo[,1])),na.omit(press.zoo[,1]),spar=.35)
press.press <- zoo(ttmp$y,as.chron(ttmp$x))

## Hőmérséklet
ttmp <- smooth.spline(index(na.omit(press.zoo[,2])),na.omit(press.zoo[,2]),spar=.3)
press.max <- zoo(ttmp$y,as.chron(ttmp$x))
ttmp <- smooth.spline(index(na.omit(press.zoo[,3])),na.omit(press.zoo[,3]),spar=.3)
press.min <- zoo(ttmp$y,as.chron(ttmp$x))

## Talajvíz
gw <- read.table("gwfig2.txt")
pressgw.zoo <- zoo(gw[,3],chron(-14187)+gw[,1]+gw[,2]/6)
