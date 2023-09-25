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
histamina<-read_excel("histamina.xlsx")

