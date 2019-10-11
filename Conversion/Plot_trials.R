
filename=file.choose()
DATA   <- read.csv(file=filename,header=FALSE)
colnames(DATA)=c("Trial","Timestamp","X","Y","side","sc","model")
filestring=as.character(basename(filename))
subname=substr(filestring, 1, nchar(filestring)-4)
sub=substr(filestring, 1, nchar(filestring)-12)
setwd(dirname(filename))


packages=c('ggplot2','pracma','stringr','eyetrackingR')

new.packages=packages[!(packages %in% installed.packages()[,"Package"])]

if (length(new.packages)){
  install.packages(new.packages)
}


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

DATA=DATA[DATA$Timestamp>1000,]

DATA$side=factor(DATA$side,levels=c(1,2),labels=c("Social Left","Social Right"))
DATA$sc=factor(DATA$sc,levels=c(1,2),labels=c("Intact","Scrambled"))
DATA$trackloss=ifelse(DATA$X=="NaN",1,2)
DATA$trackloss=factor(DATA$trackloss,levels=c(1,2),labels=c("NA","Data"))

DATAint=DATA[DATA$sc=="Intact",]

INTPLOT=ggplot(DATAint,aes(x=X*resx,y=Y*resy))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=side),alpha=.8)+
facet_wrap(~Trial,ncol=10)+xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Intact stimuli")+theme_classic()


ggsave(filename=strcat(subname,"_intact.pdf"),plot=INTPLOT,width=27,height=15,units="cm",device='pdf')

DATAsc=DATA[DATA$sc=="Scrambled",]

SCPLOT=ggplot(DATAsc,aes(x=X*resx,y=Y*resy))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=side),alpha=.8)+
  facet_wrap(~Trial,ncol=10)+xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Scrambled stimuli")+theme_classic()


ggsave(strcat(subname,'_scrambled.pdf'),plot=SCPLOT,width=27,height=15,units="cm",device='pdf')

earliest=rep(0,length(unique(DATA$Trial)))
for (i in 1:length(unique(DATA$Trial))){
  instance=DATA[DATA$Trial==i,]
  earliest[i]=min(instance[instance$X!="NaN",]$Timestamp)
}

qplot(earliest)

INTPLOTX=ggplot(DATAint,aes(x=Timestamp,y=X*resx))+geom_vline(aes(xintercept=Timestamp,colour=trackloss),alpha=.1)+geom_point(aes(colour=side),alpha=1)+geom_line(aes(colour=side))+
  facet_wrap(~Trial,ncol=5)+ggtitle("Intact stimuli")+geom_hline(yintercept=rectlxmax,alpha=.2)+geom_hline(yintercept=rectrxmin,alpha=.2)+ylim(c(300,resx-300))+theme_classic()

ggsave(strcat(subname,'_intact_X.pdf'),plot=INTPLOTX,width=27,height=15,units="cm",device='pdf')


SCPLOTX=ggplot(DATAsc,aes(x=Timestamp,y=X*resx))+geom_vline(aes(xintercept=Timestamp,colour=trackloss),alpha=.1)+geom_point(aes(colour=side),alpha=1)+geom_line(aes(colour=side))+
  facet_wrap(~Trial,ncol=5)+ggtitle("Scrambled stimuli")+geom_hline(yintercept=rectlxmax,alpha=.2)+geom_hline(yintercept=rectrxmin,alpha=.2)+ylim(c(300,resx-300))+theme_classic()

ggsave(strcat(subname,'_scrambled_X.pdf'),plot=SCPLOTX,width=27,height=15,units="cm",device='pdf')


DATA$isinL=as.logical(ifelse(DATA$X*resx<rectlxmax & DATA$X*resx>rectlxmin & DATA$Y*resy<rectlymax & DATA$Y*resy>rectlymin ,1,0))
DATA$isinR=as.logical(ifelse(DATA$X*resx<rectrxmax & DATA$X*resx>rectrxmin & DATA$Y*resy<rectrymax & DATA$Y*resy>rectrymin ,1,0))


DATA$AOI=rep(0,nrow(DATA))

for (i in 1:nrow(DATA)){
  if (DATA$X[i]=="NaN"){
    DATA$AOI[i]==""}
  else if (DATA$X[i]*resx<rectlxmax & DATA$X[i]*resx>rectlxmin & DATA$Y[i]*resy<rectlymax & DATA$Y[i]*resy>rectlymin){
    DATA$AOI[i]=1}
  else if (DATA$X[i]*resx<rectrxmax & DATA$X[i]*resx>rectrxmin & DATA$Y[i]*resy<rectrymax & DATA$Y[i]*resy>rectrymin){
    DATA$AOI[i]=2}
}



VALIDPLOT=ggplot(DATA,aes(x=X*resx,y=Y*resy))+geom_rect(xmin =rectlxmin ,xmax=rectlxmax,ymin=rectlymin,ymax=rectlymax)+geom_rect(xmin =rectrxmin ,xmax=rectrxmax,ymin=rectrymin,ymax=rectrymax)+geom_path(aes(colour=factor(AOI)),alpha=.4)+
xlim(c(200,resx-200))+ylim(c(300,resy-300))+ggtitle("Validity")+theme_classic()


ggsave(strcat(subname,'_validity.pdf'),plot=VALIDPLOT,width=27,height=15,units="cm",device='pdf')


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

response_window_agg_by_sub <- make_time_window_data(ET_DATA, aois=c("SOCIAL","NONSOCIAL"),summarize_by = "ps",predictor_columns = c("sc"))


P1=ggplot(response_window_agg_by_sub,aes(x=AOI,y=Prop))+facet_grid(.~sc)+  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar",aes(fill=AOI),size=2,alpha=.5,colour="black")+theme_bw(base_size = 11)+ylab("Gaze Proportion")+geom_point(colour="red",position = position_jitter(w=0.2),alpha=.5,size=1)+
  theme(panel.grid.minor = element_blank(),panel.grid.major = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"))+ theme(strip.background = element_rect(fill="gray90"))+scale_colour_discrete(guide=FALSE)+ theme(axis.text.x = element_text(angle = 25, hjust = 1))+ scale_fill_manual(values = c("springgreen3","steelblue2"))

ggsave(strcat(subname,'_Window.pdf'),plot=P1,width=27,height=15,units="cm",device='pdf')


response_time <- make_time_sequence_data(ET_DATA, time_bin_size = 100,aois = c("NONSOCIAL","SOCIAL"),summarize_by = "ps",predictor_columns = c("sc"))

TS_PLOT=plot(response_time,predictor_column = "sc")+geom_line(size=2)+theme_classic()


ggsave(strcat(subname,'_Growthcurve.pdf'),plot=TS_PLOT,width=27,height=15,units="cm",device='pdf')

percloss=(as.numeric(table(DATA$trackloss)[2])/nrow(DATA))*100
percNAOI=as.numeric(table(DATA$AOI)[1])/nrow(DATA)*100-percloss


sprintf(c("The percentage trackloss is %f","The percentage of non AOI looks is %f"),c(percloss,percNAOI))





