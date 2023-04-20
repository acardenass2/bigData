rm(list=ls())
install.packages("haven") #stata, spss, matlab
install.packages("readxl")# base de datos excel
install.packages("labelled")
library(haven)
library(labelled) #permite trabajar con las etiquetas de bases de datos impotadas de Stata o spss
library(readxl)
bd20<-read.csv("C:/Users/HP/Documents/Big Data/Tema 3/en2020.csv", sep = "|")
getwd()
#setwd("C:/Users/HP/Documents/Big Data/Tema 3")#cambiar el directorio de trabajo
save(bd20, file="data/bd20.RData")#exportar a R
#Para cargar la base
rm(list = ls())
load("data/bd20.RData")
#censo
s1<-getwd()
setwd("C:/Users/HP/Documents/Big Data/Tema 3/census")
dir()
cs12d_8<-read_dta("DBdiscapacidad2012vf_8.dta")
cs12d_9<-read_dta("DBdiscapacidad2012vf_9.dta")
cs12m_8<-read_dta("DBmortalidad2012vf_8.dta")  
cs12m_9<-read_dta("DBmortalidad2012vf_9.dta")  
cs12p_8<-read_dta("DBpersonas2012vf_8.dta")    
cs12p_9<-read_dta("DBpersonas2012vf_9.dta")    
cs12v_8<-read_dta("DBvivienda2012vf_8.dta")     
cs12v_9<-read_dta("DBvivienda2012vf_9.dta")   
setwd(s1)
save(cs12d_8,cs12d_9,cs12m_8,cs12m_9,cs12p_8,cs12p_9,cs12v_8,cs12v_9)
"Actividad: realizar ka importacion de todas las bases de datos delas encuestas hogares y generar el Rdata correspondiente"
read_sav( )#para leer las bases de datos
setwd("C:/Users/HP/Documents/Big Data/Tema 3/eh2021")
dir()
EH2021_df<-read_sav("EH2021_Defunciones.sav")
EH2021_dc<-read_sav("EH2021_Discriminacion.sav")
EH2021_eq<-read_sav("EH2021_Equipamiento.sav")
EH2021_ga<-read_sav("EH2021_Gastos Alimentarios.sav"   )
EH2021_gn<-read_sav("EH2021_Gastos no Alimentarios.sav")
EH2021_p<-read_sav("EH2021_Persona.sav" )
EH2021_v<-read_sav("EH2021_Vivienda.sav")
setwd(s1)
save(EH2021_df,EH2021_dc,EH2021_eq,EH2021_ga,EH2021_gn,EH2021_p,EH2021_v)
