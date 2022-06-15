# Nom: Coq
# Prenom: Jean Woodly
# Devoir sur le realisation des graphes

# 1)Pour cet exercice, on nous demande de faire trois graphiques :
# - Un graphique en nuage de points, un graphique en baton et un graphique en ligne

# Installer les librairies que l'on va utuliser

install.packages("tidyverse")
library(tidyr)
library(dplyr)

install.packages("janitor")
library("janitor")

install.packages("ggplot2")
library(ggplot2)

# Importer des données sur Haïti de la Banque mondiale

library(readxl)
ht_donnee <- read_excel("WB_HT_DATA.xlsx")

# Inspecter les données

head(ht_donnee)

# Nettoyer les colonnes

donnee_propre <- clean_names(ht_donnee)
View(donnee_propre)


# Nous allons realiser ce projet en essayant de visualiser
# la croissance du PIB par habitant contre celle de la population


# D'abord, selectionner les données pour la croissance du PIB par habitant 
# et celle de la population

ht_donnee_select <- donnee_propre %>%
  select(indicator_name, x2000:x2020) %>% 
  filter(indicator_name == "GDP per capita growth (annual %)" | 
           indicator_name == "Population growth (annual %)")

# Transformer les données du format large en format long

ht_PIB_habitant <- ht_donnee_select %>%
  filter(indicator_name == "GDP per capita growth (annual %)" ) %>% 
  pivot_longer(-indicator_name, names_to = "annee", values_to = "PIB_habitant") %>% 
  select(annee, PIB_habitant)

ht_population <- ht_donnee_select %>%
  filter(indicator_name == "Population growth (annual %)") %>% 
  pivot_longer(-indicator_name, names_to = "annee", values_to = "population") %>% 
  select(annee, population)

# Mettre les données dans un dataframe (utilisant les années 2000 à 2020)

df <- data.frame(annee = c(2000:2020), PIB_habitant = ht_PIB_habitant$PIB_habitant, 
                 population = ht_population$population)
head(df)


# 1.Avec un graphique en nuage de points,
# nous allons visualiser la croissance du PIB Par Habitant 
# contre celle de la population,
# en y ajoutant une ligne de tendance

ggplot(data = df, aes(x= population, y = PIB_habitant)) +
  geom_point(aes(x= population, y = PIB_habitant)) +
  geom_smooth(aes(color = "PIB Par Habitant"), se=FALSE, size=1.2)+
  ggtitle("La croissance du PIB Par Habitant contre celle de la population
") + 
  xlab("Population (%)") + ylab("PIB par habitant (%)") +
  guides(color = guide_legend(title = " "))

# B. Avec un graphique en baton,
# nous allons visualiser la croissance de la population par annee

ggplot(data = df, aes(x= annee, y = population))+
  geom_bar(stat="identity", fill = 'navy')+
  ggtitle("La croissance de la population")+
  xlab("annee") + ylab("population (%)")

# Avec un graphique en ligne,
# nous allons visualiser la croissance du PIB par habitant

ggplot(data = df, aes(x= annee, y = population))+
  geom_line(col = 'red')+
  ggtitle("La croissance du PIB par habitant")+
  xlab("annee") + ylab("PIB par habitant (%)")

