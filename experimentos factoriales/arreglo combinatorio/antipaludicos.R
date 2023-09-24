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

# Importar el archivo "antipaludicos.xlsx"
