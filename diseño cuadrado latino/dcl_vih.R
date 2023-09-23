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
