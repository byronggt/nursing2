# Dr. Byron González
# http://www.byrong.tk

# Comparación de niveles de estrogen en tres grupos de mujeres

# Colocar en memoria las bibliotecas a emplear
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(readxl)){install.packages("readxl")}

# Importar el archivo "estrogenos.xlsx"
estrogenos<-read_excel("estrogenos.xlsx")
head(estrogenos)
attach(estrogenos)

# Graficar el comportamiento de cada grupo
boxplot(e4~edad)

# Graficar el comportamiento mediante ggplot



