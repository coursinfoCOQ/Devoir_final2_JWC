library(openxlsx)

####### Importons les donnees : 
W<-read.xlsx('PopFemme.xlsx')
as.numeric(W$Annee)
W

####### Realisons un graphique en nuage de points :
library(ggplot2)
ggplot(data=W,aes(x=Annee,y=PopFemme))+
  geom_point()

####### Realisons un graphique en baton :

ggplot(data=W,aes(x=Annee,y=Annee))+
  geom_bar(stat="identity")

####### Realuisons un graphique en ligne :

ggplot(data=W,aes(x=Annee,y=PopFemme))+
  geom_line()

