# Dr. Byron González
# http://www.byrong.tk

# Comparación de días hasta la recaída
# de tres niveles de adicción
# Se formaron grupos de edad para controlar la variabilidad

# Colocar en memoria las bibliotecas a emplear
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(agricolae)){install.packages("agricolae")}
if(!require(performance)){install.packages("performance")}
if(!require(readxl)){install.packages("readxl")}

# Importar el archivo "adiccion.xlsx"
adiccion<-read_excel("adiccion.xlsx")
str(adiccion)
adiccion$nivelad<-as.factor(adiccion$nivelad)
adiccion$edad<-as.factor(adiccion$edad)
head(adiccion)
attach(adiccion)

# Graficar el comportamiento de los días hasta la recaída
# de acuerdo al nivel de adicción
boxplot(dias~nivelad)

ggplot(adiccion, aes(x=nivelad, y=dias))+
  geom_dotplot(binaxis="y", stackdir="center",fill="#0000FF")+
  xlab("Nivel de adicción")+
  ylab("Días a la recaída")+
  facet_wrap(~edad)

# Realizar el análisis de varianza
aov<-lm(dias~nivelad+edad)
adiccion$predichos<-aov$fitted.values
adiccion$residuos<-aov$residuals
head(adiccion)
anova(aov)

# Revisar los supuestos del Andeva
plot(aov,1)
plot(aov,2)
windows(10,10)
check_model(aov)
check_normality(aov)

# Obtener las medias de días a la recaída
# de acuerdo al nivel de adicción








