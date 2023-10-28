# Dr. Byron González
# http://www.byrong.tk

# Comparación de niveles de estrógeno en tres grupos de mujeres

# Colocar en memoria las bibliotecas a emplear
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(agricolae)){install.packages("agricolae")}
if(!require(performance)){install.packages("performance")}
if(!require(readxl)){install.packages("readxl")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(multcompView)){install.packages("multcompView")}


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
summary(andeva)

# Revisar los supuestos del Andeva
plot(model1,1)
plot(model1,2)
windows(10,10)
check_model(model1)
check_normality(model1)

# Solicitar la prueba múltiple de medias bajo el criterio de Tukey
pr.medias<-HSD.test(andeva, "edad", console = T) ; pr.medias

# Procedimiento alternativo para Tukey
tukey<-TukeyHSD(andeva); tukey
cld<-multcompLetters4(andeva,tukey); cld

# Tabla con la media
Tk <- group_by(estrogenos, edad) %>%
  summarise(mean=mean(e4)) %>%
  arrange(desc(mean))

# Extraer las letras y agregarlas a la tabla Tk
cld <- as.data.frame.list(cld$edad)
Tk$cld <- cld$Letters

print(Tk)

# Box plot con letras (Revisar la leyenda)

ggplot(estrogenos, aes(x=as.factor(edad), y=e4)) + 
  geom_boxplot(aes(fill=as.factor(edad))) +
  labs(x="Edad", y="Nivel de estrógenos en pg/ml") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  geom_text(data = Tk, aes(as.factor(edad), y = mean, label = cld), size = 3, vjust=-1, hjust =-1)

# Guardar el box plot
ggsave("boxplot.png", width = 4, height = 3, dpi = 1000)