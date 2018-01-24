setwd("/Users/nickhedger/Documents/Github/EYETRACK_2018/Data")

filename=file.choose()
DATA   <- read.csv(file=filename,header=FALSE)
colnames(DATA)=c("Trial","Timestamp","X","Y","side","sc","model")
filestring=as.character(basename(filename))
subname=substr(filestring, 1, nchar(filestring)-4)
sub=substr(filestring, 1, nchar(filestring)-12)
cd(dirname(filename))

library(ggplot2)
library(pracma)
library(stringr)


rectlxmin=303
rectlxmax=542
rectlymin=424
rectlymax=601

rectrxmin=739
rectrxmax=978
rectrymin=424
rectrymax=601

resx=1280
resy=1024


DATA$side=factor(DATA$side,levels=c(1,2),labels=c("Social Left","Social Right"))
DATA$sc=factor(DATA$sc,levels=c(1,2),labels=c("Intact","Scrambled"))
DATA$trackloss=ifelse(DATA$X=="NaN",1,2)
DATA$trackloss=factor(DATA$trackloss,levels=c(1,2),labels=c("NA","Data"))

DATAint=DATA[DATA$sc=="Intact",]

INTPLOT=ggplot(DATAint,aes(x=X*resx,y=Y*resy))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=side),alpha=.8)+
facet_wrap(~Trial,ncol=10)+xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Intact stimuli")


ggsave(filename=strcat(subname,"_intact.pdf"),plot=INTPLOT,width=27,height=15,units="cm",device='pdf')

DATAsc=DATA[DATA$sc=="Scrambled",]

SCPLOT=ggplot(DATAsc,aes(x=X*resx,y=Y*resy))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=side),alpha=.8)+
  facet_wrap(~Trial,ncol=10)+xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Intact stimuli")


ggsave(strcat(subname,'_scrambled.pdf'),plot=SCPLOT,width=27,height=15,units="cm",device='pdf')

earliest=rep(0,length(unique(DATA$Trial)))
for (i in 1:length(unique(DATA$Trial))){
  instance=DATA[DATA$Trial==i,]
  earliest[i]=min(instance[instance$X!="NaN",]$Timestamp)
}

qplot(earliest)

INTPLOTX=ggplot(DATAint,aes(x=Timestamp,y=X*resx))+geom_vline(aes(xintercept=Timestamp,colour=trackloss),alpha=.1)+geom_point(aes(colour=side),alpha=1)+geom_line(aes(colour=side))+
  facet_wrap(~Trial,ncol=5)+ggtitle("Intact stimuli")+geom_hline(yintercept=rectlxmax,alpha=.2)+geom_hline(yintercept=rectrxmin,alpha=.2)+ylim(c(300,resx-300))

ggsave(strcat(subname,'_intact_X.pdf'),plot=INTPLOTX,width=27,height=15,units="cm",device='pdf')


SCPLOTX=ggplot(DATAsc,aes(x=Timestamp,y=X*resx))+geom_vline(aes(xintercept=Timestamp,colour=trackloss),alpha=.1)+geom_point(aes(colour=side),alpha=1)+geom_line(aes(colour=side))+
  facet_wrap(~Trial,ncol=5)+ggtitle("Scrambled stimuli")+geom_hline(yintercept=rectlxmax,alpha=.2)+geom_hline(yintercept=rectrxmin,alpha=.2)+ylim(c(300,resx-300))

ggsave(strcat(subname,'_scrambled_X.pdf'),plot=SCPLOTX,width=27,height=15,units="cm",device='pdf')




