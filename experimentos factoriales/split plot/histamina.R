# Dr. Byron González
# http://www.byrong.tk

# Comparación de la superficie del vaso sanguíneo medular
# por la administración de histamina al timo
# en conejillos de indias machos y hembras

# Colocar en memoria las bibliotecas a emplear

if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(car)){install.packages("car")}
if(!require(tidyverse)){install.packages("tidyverse")}
if(!require(agricolae)){install.packages("agricolae")}
if(!require(performance)){install.packages("performance")}
if(!require(ggpubr)){install.packages("ggpubr")}
if(!require(readxl)){install.packages("readxl")}

# Importar el archivo "histamina.xlsx"
hm<-read_excel("histamina.xlsx")
head(hm)
tail(hm)
hm$sexo<-as.factor(hm$sexo)
hm$animal<-as.factor(hm$animal)
hm$shock<-as.factor(hm$shock)

# Graficar la interacción

ggboxplot(hm,
          x="sexo",
          y="superficie",
          color = "shock")

ggboxplot(hm,
          x="shock",
          y="superficie",
          color = "sexo")

# Realizar el análisis de varianza
attach(hm)
model<-aov(superficie~shock+Error(animal/shock)+sexo+shock:sexo)
summary(model)

# Calcular un solo residuo
model1<-aov(superficie~shock*sexo+animal/shock)
summary(model1)

# Revisión de los supuestos del modelo
plot(model1,1)
plot(model1,2)
residuos<-residuals(model1)
check_model(model1)
check_normality(model1)
bartlett.test(residuos~interaction(shock,sexo),hm)

# Prueba de medias bajo el criterio de Tukey
pr.medias<-HSD.test(superficie, shock, DFerror =9 , MSerror =1.727 ); pr.medias


