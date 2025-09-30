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

### Ábra
ttfile <- 2
ttbbmeret <- c(9,7)
postscript(paste("fig",ttfile,".eps",sep=""),paper="special",width=ttbbmeret[1]/2.54,height=ttbbmeret[2]/2.54,horiz=F,point=7)
par(mar=c(2.5,3.6,.6,.5),mgp=c(2.5,0.8,0))
par(xaxs="i")#las=1,
plot(press.csap,type="h",lwd=4,xlim=chron(-14187)+c(7,25),ylim=c(0,120),yaxs="i",xaxt="n",yaxt="n",xlab="",ylab="",lend=2)
mtext("Csapadék",2,2.6,at=5)
mtext("[mm]",2,1.8,at=5)
axis(2,c(0,5,10))
par(new=T)
plot(press.press,xlim=chron(-14187)+c(7,25),ylim=c(580,765),lwd=2,xaxt="n",yaxt="n",xlab="",ylab="",lty="3111",yaxs="i")
axis(2,c(740,750,760))
mtext("Légnyomás",2,2.6,at=749)
mtext("[mm Hg]",2,1.8,at=749)
par(new=T)
plot(press.max,xlim=chron(-14187)+c(7,25),ylim=c(-55,38),xaxt="n",yaxt="n",xlab="",ylab="",type="n")
axis(2,0,tck=1,lty=3,col="gray")
lines(press.max,lwd=2,lty="21")
lines(press.min,lwd=2,lty="41")
mtext("Hőmérséklet",2,2.6,at=0)
mtext(expression(plain("[")*degree*plain("C]")),2,1.7,at=0)
axis(2,seq(-10,10,5))
text(-14179,5,"Max.",cex=.8)
text(-14179,-5,"Min.",cex=.8)
par(new=T)
plot(pressgw.zoo,xlim=chron(-14187)+c(7,25),lwd=2,xaxt="n",yaxt="n",xlab="",ylab="")
text(-14166,70,"Talajvíz")
lines(rep(-14164.9, 2),c(60,80))
lines(c(-14164.7,-14165.1),c(60,60))
lines(c(-14164.7,-14165.1),c(80,80))
text(-14164,70,"2 cm")
par(mgp=c(1.5,.2,0))
axis(1,at=-14180:-14163+.5,lab=7:24,tcl=0,cex.axis=0.8)
axis(1,at=-14180:-14162,lab=F)
mtext("1931. március",1,1.5)
dev.off()

