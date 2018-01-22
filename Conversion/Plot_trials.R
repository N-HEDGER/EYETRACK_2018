setwd("/Users/nickhedger/Documents/Github/EYETRACK_2018/Data")

filename=file.choose()
DATA   <- read.csv(file=filename)
colnames(DATA)=c("Trial","Timestamp","X","Y","side","sc","model")
filestring=as.character(basename(filename))
subname=substr(filestring, 1, nchar(filestring)-4)

library(ggplot2)
library(pracma)
library(stringr)


DATA$side=factor(DATA$side,levels=c(1,2),labels=c("Social Left","Social Right"))
DATA$sc=factor(DATA$sc,levels=c(1,2),labels=c("Intact","Scrambled"))


DATAint=DATA[DATA$sc=="Intact",]

INTPLOT=ggplot(DATAint,aes(x=X*1920,y=Y*1080))+geom_rect(xmin =439 ,xmax=808,ymin=404,ymax=677)+geom_rect(xmin =1113 ,xmax=1482,ymin=404,ymax=677)+geom_path(aes(colour=side))+
facet_wrap(~Trial,ncol=10)+xlim(c(200,1620))+ylim(c(200,880))+ggtitle("Scrambled stimuli")


ggsave(filename=strcat(subname,"_intact.pdf"),plot=INTPLOT,width=27,height=15,units="cm",device='pdf')

DATAint=DATA[DATA$sc=="Scrambled",]

SCPLOT=ggplot(DATAint,aes(x=X*1920,y=Y*1080))+geom_rect(xmin =439 ,xmax=808,ymin=404,ymax=677)+geom_rect(xmin =1113 ,xmax=1482,ymin=404,ymax=677)+geom_path(aes(colour=side))+
  facet_wrap(~Trial,ncol=10)+xlim(c(200,1620))+ylim(c(200,880))+ggtitle("Scrambled stimuli")


ggsave(strcat(subname,"_scrambled.pdf"),plot=SCPLOT,width=27,height=15,units="cm",device='pdf')
