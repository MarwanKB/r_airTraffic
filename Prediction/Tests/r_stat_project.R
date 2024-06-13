# Importer les bibliothèques nécessaires
library(dplyr)
library(ggplot2)
library(caret)

# Installer et charger les bibliothèques nécessaires
if (!require(caret)) install.packages("caret", dependencies = TRUE)
if (!require(randomForest)) install.packages("randomForest", dependencies = TRUE)
if (!require(dplyr)) install.packages("dplyr", dependencies = TRUE)
if (!require(tidyverse)) install.packages("tidyverse", dependencies = TRUE)

library(caret)
library(randomForest)
library(gbm)
library(tidyverse)
library(tidyr)


# Afficher un message de confirmation pour chaque bibliothèque importée
cat("Bibliothèque dplyr importée avec succès\n")
cat("Bibliothèque ggplot2 importée avec succès\n")
cat("Bibliothèque caret importée avec succès\n")




# Charger les fichiers
flights <- read.csv('C:/Users/boyof/Downloads/cleaned_flights.csv')
weather <- read.csv('C:/Users/boyof/Downloads/cleaned_weather.csv')
airlines <- read.csv('C:/Users/boyof/Downloads/cleaned_airlines.csv')
planes <- read.csv('C:/Users/boyof/Downloads/cleaned_planes.csv')
airports <- read.csv('C:/Users/boyof/Downloads/cleaned_airports.csv')

# Afficher les premières lignes de chaque fichier
head(flights)
head(weather)
head(airlines)
head(planes)
head(airports)





# Joindre les données des vols avec les données des avions
flights_planes <- flights %>%
  left_join(planes, by = "tailnum")

# Joindre les données des vols avec les données des aéroports de départ
flights_planes_airports <- flights_planes %>%
  left_join(airports, by = c("origin" = "faa"))

# Joindre les données des vols avec les données météorologiques
# Vérifier les colonnes disponibles dans flights et weather pour ajuster la jointure
colnames(flights_planes_airports)
colnames(weather)

# Ajuster la jointure en fonction des colonnes disponibles
flights_planes_airports_weather <- flights_planes_airports %>%
  left_join(weather, by = c("year.x"="year", "month", "day", "origin" = "origin"))



# Joindre les données des vols avec les données des compagnies aériennes
flights_planes_airports_weather_airlines <- flights_planes_airports_weather %>%
  left_join(airlines, by = "carrier")

# Afficher un aperçu des données unifiées
head(flights_planes_airports_weather_airlines)






# Préparation des données pour la modélisation
model_data <- flights_planes_airports_weather_airlines %>%
  select(dep_delay, arr_delay, air_time, distance, temp, wind_speed, precip, carrier, tailnum)

# Traitement des valeurs manquantes
model_data <- model_data %>%
  drop_na()

# Encodage des variables catégorielles
model_data$carrier <- as.factor(model_data$carrier)
model_data$tailnum <- as.factor(model_data$tailnum)









# Diviser les données en ensembles d'entraînement et de test
set.seed(123)
trainIndex <- createDataPartition(model_data$dep_delay, p = .8, 
                                  list = FALSE, 
                                  times = 1)
train_data <- model_data[ trainIndex,]
test_data  <- model_data[-trainIndex,]

# Entraîner un modèle de forêt aléatoire
set.seed(123)
rf_model <- train(dep_delay ~ ., data = train_data, method = "rf", 
                  trControl = trainControl(method = "cv", number = 5),
                  tuneLength = 5)

# Évaluation du modèle de forêt aléatoire
rf_predictions <- predict(rf_model, newdata = test_data)
rf_mae <- mean(abs(rf_predictions - test_data$dep_delay))
rf_rmse <- sqrt(mean((rf_predictions - test_data$dep_delay)^2))

# Afficher les métriques de performance du modèle de forêt aléatoire
cat("Random Forest Model\n")
cat("Mean Absolute Error (MAE):", rf_mae, "\n")
cat("Root Mean Squared Error (RMSE):", rf_rmse, "\n")

# Entraîner un modèle de gradient boosting
set.seed(123)
gbm_model <- train(dep_delay ~ ., data = train_data, method = "gbm", 
                   trControl = trainControl(method = "cv", number = 5),
                   tuneLength = 5, verbose = FALSE)

# Évaluation du modèle de gradient boosting
gbm_predictions <- predict(gbm_model, newdata = test_data)
gbm_mae <- mean(abs(gbm_predictions - test_data$dep_delay))
gbm_rmse <- sqrt(mean((gbm_predictions - test_data$dep_delay)^2))

# Afficher les métriques de performance du modèle de gradient boosting
cat("\nGradient Boosting Model\n")
cat("Mean Absolute Error (MAE):", gbm_mae, "\n")
cat("Root Mean Squared Error (RMSE):", gbm_rmse, "\n")







#############################################################################



set.seed(123)
sample_index <- sample(1:nrow(model_data), size = 10000)  # Échantillonner 10 000 lignes
sampled_data <- model_data[sample_index, ]

# Diviser les données échantillonnées en ensembles d'entraînement et de test
trainIndex <- createDataPartition(sampled_data$dep_delay, p = .8, list = FALSE)
train_data <- sampled_data[trainIndex, ]
test_data  <- sampled_data[-trainIndex, ]

# Entraîner un modèle de forêt aléatoire sur les données échantillonnées
set.seed(123)
rf_model <- train(dep_delay ~ ., data = train_data, method = "rf", 
                  trControl = trainControl(method = "cv", number = 5),
                  tuneLength = 5)

