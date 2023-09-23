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
  ylab("Nivel de estrógeno en pg/mt")

ggplot(estrogenos, aes(x=as.factor(edad),y=e4)) +
  geom_dotplot(binaxis="y", stackdir="center",fill="#FF00FF")+
  xlab("Edad en años") +
  ylab("Nivel de estrógeno en pg/mt")

# Solicitar el análisis de la varianza
aov1<-lm(e4~edad)
names(aov1)
anova(aov1)
estrogenos$predichos<-aov1$fitted.values
estrogenos$residuos<-aov1$residuals
head(estrogenos)
tail(estrogenos)

# Revisar los supuestos del Andeva
plot(aov1,1)
plot(aov1,2)
windows(10,10)
check_model(aov1)
check_normality(aov1)

# Solicitar la prueba múltiple de medias bajo el criterio de Tukey
pr.medias<-HSD.test(aov1, "edad", console = T) ; pr.medias



