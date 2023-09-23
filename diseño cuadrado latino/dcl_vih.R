# Dr. Byron González
# http://www.byrong.tk

# Comparación de carga viral de VIH, a partir de diferentes
# dosis de selenio. Los pacientes fueron separados por
# grupos de edad y período de incubación

# Colocar en memoria las bibliotecas a emplear

if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(agricolae)){install.packages("agricolae")}
if(!require(performance)){install.packages("performance")}
if(!require(readxl)){install.packages("readxl")}

# Importar el archivo "selenio.xlsx"
vih<-read_excel("selenio.xlsx")
head(vih)
vih$incubacion<-as.factor(vih$incubacion)
vih$edad<-as.factor(vih$edad)
vih$selenio<-as.factor(vih$selenio)
attach(vih)

# Graficar el comportamiento de carga viral
boxplot(cargav~selenio)

ggplot(vih, aes(selenio,cargav))+
    geom_boxplot()+
    xlab("Dosis de selenio")+
    ylab("Carga de VIH en copia de ARN/ml")

# Realizar el análisis de varianza
model<-lm(cargav~incubacion+edad+selenio)
anova(model)

# Revisar los supuestos del Andeva
plot(model,1)
plot(model,2)
windows(10,10)
check_model(model)
check_normality(model)
model2<-aov(cargav~incubacion+edad+selenio)
summary(model2)

# Solicitar la prueba múltiple de medias bajo el criterio de Tukey
pr.medias<-HSD.test(model2, "selenio", console = T); pr.medias

# Gráfico de barras en la comparación de medias

windows(10,10)
bar.group(x=pr.medias$groups,horiz=F,col="red",
          xlab="Dosis de selenio",ylab="Carga viral de VIH",
          main="Comportamiento de medias de carga viral de acuerdo a la dosis de selenio")
