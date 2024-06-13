# Charger les bibliothèques nécessaires
library(DBI)
library(RMySQL)
library(dplyr)
library(caret)
library(randomForest)

# Connexion à la base de données MySQL
con <- dbConnect(RMySQL::MySQL(),
                 dbname = 'traffic-aerien_db',
                 host = 'mysql-traffic-aerien.alwaysdata.net',
                 port = 3306,
                 user = '363257_rabab',
                 password = 'root_rabab')

# Charger les tables nettoyées
airports <- dbReadTable(con, "airports")
airlines <- dbReadTable(con, "airlines")
planes <- dbReadTable(con, "planes")
weather <- dbReadTable(con, "weather")
flights <- dbReadTable(con, "flights")

# Fermer la connexion
dbDisconnect(con)

# Convertir les variables pertinentes en facteurs
flights$carrier <- as.factor(flights$carrier)
flights$origin <- as.factor(flights$origin)
flights$dest <- as.factor(flights$dest)

# Filtrer les données pour les prédictions de retards
flights_delay <- flights %>%
  filter(!is.na(arr_delay) & !is.na(dep_delay)) %>%
  select(arr_delay, dep_delay, air_time, distance, carrier, origin, dest)

# Séparer les données en ensembles d'entraînement et de test
set.seed(123)
trainIndex <- createDataPartition(flights_delay$arr_delay, p = .8, list = FALSE, times = 1)
flights_train <- flights_delay[ trainIndex,]
flights_test  <- flights_delay[-trainIndex,]

# Modélisation avec régression linéaire
model <- train(arr_delay ~ ., data = flights_train, method = "lm")

# Afficher le résumé du modèle
summary(model)

# Prédictions sur l'ensemble de test
predictions <- predict(model, newdata = flights_test)

# Évaluer le modèle
evaluation <- postResample(pred = predictions, obs = flights_test$arr_delay)
print(evaluation)

# Enregistrer le modèle
saveRDS(model, file = "linear_model_delay.rds")


#