# Dr. Byron González
# http://www.byrong.tk

# Comparación de niveles de estrógeno en tres grupos de mujeres

# Colocar en memoria las bibliotecas a emplear
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(agricolae)){install.packages("agricolae")}
if(!require(performance)){install.packages("performance")}
if(!require(readxl)){install.packages("readxl")}

# Importar el archivo "estrogenos.xlsx"
estrogenos<-read_excel("estrogenos.xlsx")
head(estrogenos)
attach(estrogenos)
edad<-as.factor(edad)

# Graficar el comportamiento de cada grupo
boxplot(e4~edad)

# Graficar el comportamiento mediante ggplot
ggplot(estrogenos, aes(x=as.factor(edad),y=e4)) +
  geom_boxplot() +
  theme_minimal() +
  xlab("Edad en años") +
  ylab("Nivel de estrógeno en pg/ml")

ggplot(estrogenos, aes(x=as.factor(edad),y=e4)) +
  geom_dotplot(binaxis="y", stackdir="center",fill="#FF00FF")+
  xlab("Edad en años") +
  ylab("Nivel de estrógeno en pg/ml")

# Solicitar el análisis de la varianza
model1<-lm(e4~edad)
names(model1)
anova(model1)
estrogenos$predichos<-model1$fitted.values
estrogenos$residuos<-model1$residuals
head(estrogenos)
tail(estrogenos)
andeva<-aov(e4~edad)


# Revisar los supuestos del Andeva
plot(model1,1)
plot(model1,2)
windows(10,10)
check_model(model1)
check_normality(model1)

# Solicitar la prueba múltiple de medias bajo el criterio de Tukey
pr.medias<-HSD.test(andeva, "edad", console = T) ; pr.medias
