# Dr. Byron González
# http://www.byrong.tk

# Comparación del número de pacientes curados
# por la administración de dos fármacos antipalúdicos
# en dos diferentes concentraciones
# Se separaron los pacientes en grupos, de acuerdo
# al agente causal determinado

# Colocar en memoria las bibliotecas a emplear

if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(tidyverse)){install.packages("tidyverse")}
if(!require(agricolae)){install.packages("agricolae")}
if(!require(performance)){install.packages("performance")}
if(!require(readxl)){install.packages("readxl")}

# Importar el archivo "antipaludicos.xlsx"
farma<-read_excel("antipaludicos.xlsx")
head(farma)

farma$pirimetamina<-as.factor(farma$pirimetamina)
farma$cloroquina<-as.factor(farma$cloroquina)
farma$parasito<-as.factor(farma$parasito)

str(farma)

# Generar el gráfico de interacciones
attach(farma)
windows(10,10) # Pendiente modificar la leyenda
interaction.plot(pirimetamina,cloroquina,pcurados, fixed=T,
                 xlab="Concentraciones de pirimetamina",
                 ylab="Número de pacientes curados",
                 col = c("red", "blue"),
                 lty=1,  
                 lwd=2,
                 legend=T, type = "b",
                 trace.label = "Conc. de cloroquina",
                 pch = c(5,7))

windows(10,10)
farma %>% 
  ggplot()+
  aes(x=pirimetamina, color=cloroquina, group=cloroquina, y=pcurados)+
  stat_summary(fun=mean, geom = "point")+
  stat_summary(fun=mean, geom = "line")+
  xlab("Concentraciones de pirimetamina")+
  ylab("Concentraciones de cloroquina")+
  labs(colour="Números de pacientes curados")

# Realizar el análisis de varianza

model<-aov(pcurados~pirimetamina+cloroquina+pirimetamina*cloroquina+parasito)
summary(model)

# Revisar los supuestos del modelo
plot(model,1)
plot(model,2)
windows(10,10)
check_model(model)
check_normality(model)
head(farma)
bartlett.test(pcurados ~ interaction(pirimetamina,cloroquina))


# Debido a que no hay diferencias significativas
# solamente se presentan las medias para cada fármaco

farma %>%
  group_by(pirimetamina) %>%
  summarise_at(vars(pcurados), list(name = mean))


farma %>%
  group_by(cloroquina) %>%
  summarise_at(vars(pcurados), list(name = mean))