setwd("/Users/nickhedger/Documents/Github/EYETRACK_2018/Data")

filename=file.choose()
DATA1   <- read.csv(file=filename,header=FALSE)

filename2=file.choose()
DATASMOOTH   <- read.csv(file=filename2,header=FALSE)



colnames(DATA1)=c("Trial","Timestamp","X","Y","side","sc","model")

DATA1$XSMOOTH=DATASMOOTH$V3
DATA1$YSMOOTH=DATASMOOTH$V4
DATA1$interp=DATASMOOTH$V7

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

DATA1=DATA1[DATA1$Timestamp>1000,]

DATA1$side=factor(DATA1$side,levels=c(1,2),labels=c("Social Left","Social Right"))
DATA1$sc=factor(DATA1$sc,levels=c(1,2),labels=c("Intact","Scrambled"))
DATA1$trackloss=ifelse(DATA1$X=="NaN",1,2)
DATA1$trackloss=factor(DATA1$trackloss,levels=c(1,2),labels=c("NA","Data"))

DATAint=DATA1[DATA1$sc=="Intact",]

INTPLOT1=ggplot(DATAint,aes(x=XSMOOTH,y=YSMOOTH))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=side),alpha=.8)+
  facet_wrap(~Trial,ncol=10)+xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Intact stimuli")

INTPLOT2=ggplot(DATAint,aes(x=X*resx,y=Y*resy))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=side),alpha=.8)+
  facet_wrap(~Trial,ncol=10)+xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Intact stimuli")


multiplot(INTPLOT1,INTPLOT2,cols=2)




INTPLOTX1=ggplot(DATAint,aes(x=Timestamp,y=XSMOOTH))+geom_point(aes(colour=factor(interp)),alpha=1)+
  facet_wrap(~Trial,ncol=5)+ggtitle("Intact stimuli")+geom_hline(yintercept=rectlxmax,alpha=.2)+geom_hline(yintercept=rectrxmin,alpha=.2)+ylim(c(300,resx-300))

INTPLOTX2=ggplot(DATAint,aes(x=Timestamp,y=X*resx))+geom_vline(aes(xintercept=Timestamp,colour=trackloss),alpha=.1)+geom_point(aes(colour=side),alpha=1)+geom_line(aes(colour=side))+
  facet_wrap(~Trial,ncol=5)+ggtitle("Intact stimuli")+geom_hline(yintercept=rectlxmax,alpha=.2)+geom_hline(yintercept=rectrxmin,alpha=.2)+ylim(c(300,resx-300))


multiplot(INTPLOTX1,INTPLOTX2,cols=2)


ggsave(strcat(subname,'_intact_X.pdf'),plot=INTPLOTX,width=27,height=15,units="cm",device='pdf')


SCPLOTX=ggplot(DATAsc,aes(x=Timestamp,y=X*resx))+geom_vline(aes(xintercept=Timestamp,colour=trackloss),alpha=.1)+geom_point(aes(colour=side),alpha=1)+geom_line(aes(colour=side))+
  facet_wrap(~Trial,ncol=5)+ggtitle("Scrambled stimuli")+geom_hline(yintercept=rectlxmax,alpha=.2)+geom_hline(yintercept=rectrxmin,alpha=.2)+ylim(c(300,resx-300))

ggsave(strcat(subname,'_scrambled_X.pdf'),plot=SCPLOTX,width=27,height=15,units="cm",device='pdf')




DATA$isinL=as.logical(ifelse(DATA$X*resx<rectlxmax & DATA$X*resx>rectlxmin & DATA$Y*resy<rectlymax & DATA$Y*resy>rectlymin ,1,0))
DATA$isinR=as.logical(ifelse(DATA$X*resx<rectrxmax & DATA$X*resx>rectrxmin & DATA$Y*resy<rectrymax & DATA$Y*resy>rectrymin ,1,0))



DATA$AOI=rep(0,nrow(DATA))

for (i in 1:nrow(DATA)){
  if (DATA$X[i]=="NaN"){
    DATA$AOI[i]==""}
  else if (DATA$X[i]*resx<rectlxmax & DATA$X[i]*resx>rectlxmin & DATA$Y[i]*resy<rectlymax & DATA$Y[i]*resy>rectlymin){
    DATA$AOI[i]=1}
  else if (DATA$Y[i]*resx<rectrxmax & DATA$X[i]*resx>rectrxmin & DATA$Y[i]*resy<rectrymax & DATA$Y[i]*resy>rectrymin){
    DATA$AOI[i]=2}
}



VALIDPLOT=ggplot(DATA,aes(x=X*resx,y=Y*resy))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=factor(AOI)),alpha=.8)+
  facet_wrap(~Trial,ncol=10)+xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Intact stimuli")


DATA$SOCIAL=as.logical(ifelse(as.numeric(DATA$side)==DATA$AOI,1,0))
DATA$NONSOCIAL=as.logical(ifelse(as.numeric(DATA$side)!=DATA$AOI & DATA$AOI!=0 ,1,0))

DATA$trackloss=as.logical(ifelse(DATA$X=="NaN",1,0))


DATA$ps=rep(1,nrow(DATA))


library(eyetrackingR)


ET_DATA <- make_eyetrackingr_data(DATA, 
                                  participant_column = "ps",
                                  trial_column = "Trial",
                                  time_column = "Timestamp",
                                  aoi_columns = c('isinL','isinR',"SOCIAL","NONSOCIAL"),
                                  treat_non_aoi_looks_as_missing = TRUE,trackloss_column="trackloss"
)




response_time <- make_time_sequence_data(ET_DATA, time_bin_size = 100,aois = c("NONSOCIAL","SOCIAL"),summarize_by = "ps",predictor_columns = c("sc"))

TS_PLOT=plot(response_time,predictor_column = "sc")+geom_line(size=2)


ggsave(strcat(subname,'_Growthcurve.pdf'),plot=TS_PLOT,width=27,height=15,units="cm",device='pdf')

percloss=(as.numeric(table(DATA$trackloss)[2])/nrow(DATA))*100
percNAOI=as.numeric(table(DATA$AOI)[1])/nrow(DATA)*100-percloss


sprintf(c("The percentage trackloss is %f","The percentage of non AOI looks is %f"),c(percloss,percNAOI))





