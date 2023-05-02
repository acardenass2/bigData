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
save(cs12d_8,cs12d_9,cs12m_8,cs12m_9,cs12p_8,cs12p_9,cs12v_8,cs12v_9, file = "data/cs12.RData")
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
save(EH2021_df,EH2021_dc,EH2021_eq,EH2021_ga,EH2021_gn,EH2021_p,EH2021_v,file = "data/eh21.RData")

####
rm(list = ls())
load("data/bd20.RData")
table(bd20$Nombre.PAIS)
load("data/cs12.RData")
#Tarea
load("data/eh21.RData")


#Diccionario de las variables
names(bd20)
#key electoral mesa:
length(unique(bd20$Codigo.MESA))
length(unique(bd20$Codigo.RECINTO))
length(unique(bd20$Nombre.RECINTO))
length(unique(bd20$Codigo.MESA))  

#key censo es la variable llave
length(unique(cs12v_8$llave))
length(unique(cs12p_8$llave))
names(cs12p_8)
names(cs12v_8)
#key para EH
length(unique(bd20$Codigo.MESA))

str(bd20$VALIDOS)
class(bd20$VALIDOS)
class(bd20$Codigo.DEPARTAMENTO)
class(bd20$Nombre.DEPARTAMENTO)
#STATA SPSS
str(cs12p_9)
str(cs12p_9$p23)
aux<- attributes(cs12p_9)
aux$names
library(labelled)
var_label(cs12p_9) #etiqueta de la variable (descripcion)
val_labels(cs12p_9$p23) #son las etiquetas de variables codificadas
bd_aux<-to_factor(cs12p_8)
#Armar una base de datos que contenga el diccionario de las bases de datos del censo

#CONDICIONES
# Operadores Logicos
# Igualdad ==
# Distinto !=
# ó logico |
# y logico &
# Negacion "!"
# Desigualdad "<,>, >=,<="
# (Which) Multiples condiciones sin usar el ó(|) el comando "%in%

# !(3==3) a veces es util usarlo
library(dplyr)


rm(list=ls())
load("data/bd20.RData")
names(bd20)<-tolower(names(bd20))
names(bd20)
table(bd20$nombre.departamento)
table(bd20$codigo.departamento)

#Bases de datos de las mesas por departamento
aux<- unique(bd20$nombre.departamento)
aux
bd_d<- list()
r<- 1

for(i in aux){
  bd_d[[r]]<- bd20 %>% filter(nombre.departamento==i)
  r<-r+1
}

# -Bases de datos de los departamentos distintos al eje central
aux[c(2,3,7)]
bd20 %>% filter(!(nombre.departamento %in% aux[c(2,3,7)])) %>%
  group_by(nombre.departamento) %>% count()
bd1<-bd20 %>% filter(!(nombre.departamento %in% aux[c(2,3,7)])) 

# - BD del municipio del Alto
bd_ea<-bd20 %>%  filter(nombre.municipio=="EL ALTO")
bd_ea1<-bd20 %>%  filter(codigo.municipio=="20105")
#Otra forma
aux1<-sort(unique(bd20$nombre.municipio))
aux1
bd_ea2<- bd20 %>%  filter(nombre.municipio==aux1[95])


# BD del municipio donde el mas obtenga en termninos relativos la mayor votacion
bdmun<-bd20 %>% group_by(codigo.municipio,nombre.municipio) %>% summarise_at(vars(adn:validos),sum)
bdmun

bdmun$mas.ipsp/bdmun$validos #proporcion de apoyo al mas
maxmas<- max(bdmun$mas.ipsp/bdmun$validos)
pmas<- bdmun$mas.ipsp/bdmun$validos==maxmas #posicion
bdmun$codigo.municipio[pmas]
bdmun$nombre.municipio[pmas]
bd20 %>% filter(codigo.municipio=="31304")


# BD del municipio donde CC obtenga en termninos relativos la mayor votacion
maxcc<-max(bdmun$cc/bdmun$validos)
pcc<-(bdmun$cc/bdmun$validos)==maxcc
bdmun$codigo.municipio[pcc]
bdmun$nombre.municipio[pcc]
bd20 %>% filter(codigo.municipio=="50101")


# BD del municipio donde Creemos obtenga en termninos relativos la mayor votacion
maxcre<-max(bdmun$creemos/bdmun$validos)
pcre<- bdmun$creemos/bdmun$validos==maxcre
bdmun$codigo.municipio[pcre]
bdmun$nombre.municipio[pcre]
bd20 %>% filter(codigo.municipio=="70601")



# BD del municipio con mayor similitud a los resultados nacionales (en terminos relativos)
#BENI
bd_bn<-bd20 %>% filter(nombre.departamento=="BENI")
bd_bn


#Seleccion de Variables. Simplemente se refiere a la seleccion de variables
#este proceso se recomienda realizarlo antes del modelo, ya que libera espacio en la memoria
# y optimiza los tiempos de procesamiento nos permite enfocarnos en las variables de interes
# En la libreria dplyr el comando es select.
bd20 %>% select(codigo.mesa, validos)
bd20 %>% select(-codigo.pais, -codigo.departamento)
bd20 %>% select_at(vars(adn:validos))
bd20 %>% select(starts_with(("nombre"))) %>%  names()
bd20 %>% select(!starts_with(("codigo"))) %>%  names()
bd20 %>% select(contains(("s1"))) %>%  names()


#Otro comando mas EXTRA
#Para ordenar la base de datos se utiliza el comando arrange

bdmun %>%  head()
bdmun %>%  arrange(nombre.municipio) %>% head()
bdmun %>%  arrange(desc(nombre.municipio)) %>% head() #forma descendente
bdmun %>%  arrange(cc,mas.ipsp) %>% select(cc,mas.ipsp) %>% head()

                   