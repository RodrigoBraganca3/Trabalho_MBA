
#### Base de dados trabalho ####

# Link base de dados: https://archive.ics.uci.edu/dataset/476/buddymove+data+set #
# User interest information extracted from user reviews published in holidayiq.com about various types of point of interests in South India #
# Colunas (7): (User.Id/Sports/Religious/Nature/Theatre/Shopping/Picnic) #

library(tidyverse)
library(factoextra)
packageVersion("factoextra")
library(cluster)
library(FactoMineR)
library(gridExtra)
library(ggplot2)
library(readr)

install.packages("ggplot2")
install.packages("tidyverse")
install.packages("summarytools")
install.packages("readr")
library(readr)
library(ggplot2)
library(tidyverse)
library(summarytools)

install.packages("dlookr")
install.packages("fitdistrplus")
library(dlookr)
library(fitdistrplus)
library(readxl)
library(knitr)

getwd()
setwd("C:/Users/rodri/OneDrive/Documentos/Programação & MBA/1. MBA Data Science/8. Matéria 8  - Análise exploratória de dados [24E1_3]")
Base_dados = read.csv("buddymove_holidayiq.csv")
View(Base_dados)
summary(Base_dados)


# Pré tratamento da base de dados - Tirando a 1º coluna "User.id" e colocando ela como rótulo de linha #
Dados_semChar = Base_dados[,-1]
row.names(Dados_semChar) = Base_dados[,1]


# função descr #
descr(Dados_semChar)

## ggplot & matriz de correlação ##
pairs(Dados_semChar)
Correlação_matriz = cor(Dados_semChar)



## Histograma - Utilizei o número de breaks recomendados pelo R studio ##
hist(Dados_semChar$Religious) ## 9 brakes ##
hist(Dados_semChar$Nature) ## 6 breaks ##
hist(Dados_semChar$Theatre) ## 9 breaks ##
hist(Dados_semChar$Shopping) ## 10 breaks ##
hist(Dados_semChar$Picnic) ## 9 breaks ##
hist(Dados_semChar$Sports) ## 12 breaks ##



## Histograma - Qty de bins com base na "regra da raiz quadrada do número de observações" ##
### Como todas as variáveis possuem a mesma quantidade de linhas, a regra abaixo serve para todas as variáveis ###
Num_obs_Reli = length(Dados_semChar$Religious)
Num_bins_reli = ceiling(sqrt(Num_obs)) ## bins = 16 ##
hist(Dados_semChar$Religious, breaks = 16)



##  "Crie um gráfico Q-Q para cada variável de sua base de dados. (use as funções presentes no pacote ggpubr;" ##
install.packages("ggpubr")
library(ggpubr)


QQ_plots_reli = lapply(Dados_semChar$Religious, ggqqplot)
print(QQ_plots_reli)

QQ_plots_nat = lapply(Dados_semChar$Nature, ggqqplot)
print(QQ_plots_nat)

QQ_plots_thea = lapply(Dados_semChar$Theatre, ggqqplot)
print(QQ_plots_thea)

QQ_plots_shop = lapply(Dados_semChar$Shopping, ggqqplot)
print(QQ_plots_shop)

QQ_plots_pic = lapply(Dados_semChar$Picnic, ggqqplot)
print(QQ_plots_pic)

QQ_plots_spo = lapply(Dados_semChar$Sports, ggqqplot)
print(QQ_plots_spo)


## Completudo das minhas variáveis ##
Completude = colMeans(!is.na(Dados_semChar)) * 100
print(Completude)



## "Realize uma operação de imputação de dados usando o pacote MICE" ##
install.packages("mice")
library(mice)

Dados_imputados = mice(Dados_semChar, m = 5, method = 'pmm', seed = 333)


## Shiny dashboard ##
install.packages("shinydashboard")
library(shiny)
library(shinydashboard)


















