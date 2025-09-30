library(zoo)
fig111 <- read.csv("1fig11.csv")
fig111.z <- zoo(as.numeric(fig111[,3]),as.POSIXct(paste(as.character(fig111[,1]),as.character(fig111[,2])),tz="GMT"))

fig112 <- read.csv("2fig11.csv")
fig112.z <- zoo(fig112[,3],as.POSIXct(paste(as.character(fig112[,1]),as.character(fig112[,2])),tz="GMT"))

fig113 <- read.csv("3fig11.csv")
fig113.z <- zoo(fig113[,3],as.POSIXct(paste(as.character(fig113[,1]),as.character(fig113[,2])),tz="GMT"))

##m-be váltás
fig111.z <- fig111.z*.3048
fig112.z <- fig112.z*.3048;
fig113.z <- fig113.z*.3048

ytg <- c(0.225,.48)
ttfile=10
ttbbmeret=c(9,6)
postscript(paste("fig",ttfile,".eps",sep=""),paper="special",width=ttbbmeret[1]/2.54,height=ttbbmeret[2]/2.54,horiz=F,point=7)
par(mar=c(1.5,4,0.1,4)+.1)
## Felső
plot(fig111.z,ylim=ytg,yaxs="i",xlim=c(ISOdate(1955,8,25,0),ISOdate(1955,9,2,0)),xaxs="i",xlab="",ylab="",xaxt="n",yaxt="n",type="n")
axis(1,at=c(ISOdate(1955,8,25:31,12),ISOdate(1955,9,1,12)),lab=F,tck=1,lty=3,col="lightgray")
lines(fig111.z,lwd=2)
lines(ISOdate(1955,8,c(25,29),0),c(.465,0.437),col="grey")
text(ISOdate(1955,8,29,18),0.45,"Rain 0.8 mm",cex=.7)
csapvon <- c(.435,0.424)
lines(ISOdate(1955,8,29,c(8,8)),csapvon)
lines(ISOdate(1955,8,29,c(10,10)),csapvon)
arrows(ISOdate(1955,8,29,18),0.445,ISOdate(1955,8,29,9),.438,.02,15)
par(new=T)
## Középső
plot(fig113.z,ylim=ytg,yaxs="i",xlim=c(ISOdate(1956,7,29,0),ISOdate(1956,8,6,0)),xaxs="i",xlab="",ylab="",xaxt="n",yaxt="n",lwd=2)
lines(ISOdate(1956,7:8,c(30,5),0),c(.385,.3632),col="grey")
text(ISOdate(1956,8,5,7,45),0.368,"Rain",adj=0,cex=.7)
text(ISOdate(1956,8,5,2),0.36,"11.2 mm",adj=0,cex=.7)
lines(ISOdate(1956,8,5,c(8,8)),c(.373,.38))
arrows(ISOdate(1956,8,5,8),.373,ISOdate(1956,8,5,23),.373,.02,15)
par(new=T)
## Alsó
plot(fig112.z,ylim=ytg,yaxs="i",xlim=c(ISOdate(1955,7,25,0),ISOdate(1955,8,2,0)),xaxs="i",ylab="Gage height [m]",xlab="",xaxt="n",yaxt="n",lwd=2)
lines(ISOdate(1955,7:8,c(25,1),0),c(.291,0.2802),col="grey")
## Tengelyek
axis(2,at=c(.25,.30,.35,.40,.45))
axistime <- c(ISOdate(1955,7,25:31,0),ISOdate(1955,8,1:2,0))
axis(1,at=axistime,lab=F)
axis(1,at=axistime[-c(1,length(axistime))],lab=F,tck=1,lty=3)
par(cex=.9)
text(ISOdate(1955,7,25:31,12),.8*.3048,25:31)
text(ISOdate(1955,7,25,12),.775*.3048,1955)
text(ISOdate(1955,7,25,12),.83*.3048,"July")
text(c(ISOdate(1955,7,25:31,12),ISOdate(1955,8,1,12)),1.1*.3048,c(29:31,1:5))
text(ISOdate(1955,7,25,12),1.075*.3048,1956)
text(ISOdate(1955,7,25,12),1.13*.3048,"July")
text(ISOdate(1955,7,28,12),1.13*.3048,"August")
text(ISOdate(1955,7,25:29,12),1.36*.3048,25:29)
text(ISOdate(1955,7,25,12),1.335*.3048,1955)
text(ISOdate(1955,7,25,12),1.392*.3048,"August")
dev.off()
