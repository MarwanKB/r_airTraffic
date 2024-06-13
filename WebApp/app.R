# Auteur: Liticia
# Date: 2024-06-11

#Import library
library(shiny)
library(shinythemes)
library(DBI)
library(RMySQL)
library(ggplot2)
library(leaflet)
library(dplyr)
library(plotly)

# Connexion à la base de données 
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "traffic-aerien_db",
                 host = "mysql-traffic-aerien.alwaysdata.net",
                 user = "363257_liticia",
                 password = "root_liticia")

# Interface utilisateur
ui <- navbarPage(
  title = "Air Trafic",
  theme = shinytheme("flatly"),
  
  # Page d'accueil
  tabPanel("Accueil",
           fluidPage(
             tags$head(
               tags$style(HTML("
                 .title {
                   color: black;
                   text-align: center;
                   margin-top: 50px;
                   font-family: 'Castellar', sans-serif;
                 }
                 .description {
                   text-align: center;
                   font-size: 16px;
                   font-family: 'Arial', sans-serif;
                   margin: 20px;
                 }
                 .main-image {
                   display: block;
                   margin-left: auto;
                   margin-right: auto;
                   margin-top: 20px;
                 }
                 .team-section {
                   display: flex;
                   justify-content: center;
                   margin-top: 50px;
                 }
                 .team-member {
                   margin: 0 20px;
                   text-align: center;
                 }
                 .team-member img {
                   border-radius: 50%;
                   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                 }
                 .team-member p {
                   font-weight: bold;
                   margin-top: 10px;
                 }
                 .footer {
                   text-align: center;
                   font-size: 12px;
                   margin-top: 50px;
                   font-family: 'Arial', sans-serif;
                   color: #777;
                 }
               "))
             ),
             h1("AirTrafic Insights", class = "title"),
             img(src = "https://static.vecteezy.com/system/resources/previews/000/550/634/original/airplane-flying-vector-icon.jpg", height = "300px", style = "display: block; margin-left: auto; margin-right: auto;"),
             br(),
             p("Bienvenue sur notre application de visualisation et d'analyse prédictive du trafic aérien. Cette webApp a pour but de fournir des insights utiles à la prise de décision à partir des données de trafic.", style = "text-align: center; z-index: 1; position: relative;"),
             
             
             div(class = "team-section", style = "display: flex;",
                 
                 div(class = "team-member", style = "margin-right: 50px;",  style = "margin-left: 20px;",
                     img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Liticia", width = "200px", height = "200px"),
                     p("Marwan", style = "margin-top: -20px; text-align: center;")
                 ),
                 
                 div(class = "team-member", style = "margin-right: 50px;",
                     img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Marwan", width = "200px", height = "200px"),
                     p("Liticia", style = "margin-top: -20px; text-align: center;")
                 ),
                 
                 div(class = "team-member", style = "margin-right: 50px;",
                     img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Dorcas", width = "200px", height = "200px"),
                     p("Rabab", style = "margin-top: -20px; text-align: center;")
                 ),
                 
                 div(class = "team-member",
                     img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Rabab", width = "200px", height = "200px"),
                     p("Dorcas", style = "margin-top: -20px; text-align: center;")
                 )
                 
             )
             
           )),
  
  # Page Q/A
  tabPanel("Q/A",
           fluidPage(
             h2("Questions & Réponses", style = "color: black; text-align: center;"),
             br(),
             p("Q: Quel est le nombre total d’aéroports?",
               br(),
               "R: Le nombre total d’aéroports est de 1458."),
             br(),
             p("Q: Combien y a-t-il d’aéroports de départ?",
               br(),
               "R: Il y a 3 aéroports de départ."),
             br(),
             p("Q: Combien y a-t-il d’aéroports de destination?",
               br(),
               "R: Il y a 103 aéroports de destination."),
             br(),
             p("Q: Combien d’aéroports ne passent pas à l’heure d’été?",
               br(),
               "R: Il y a 23 aéroports qui ne passent pas à l’heure d’été."),
             br(),
             p("Q: Combien y a-t-il de fuseaux horaires différents?",
               br(),
               "R: Il y a 10 fuseaux horaires différents."),
             br(),
             p("Q: Combien y a-t-il de compagnies aériennes?",
               br(),
               "R: Il y a 16 compagnies aériennes."),
             br(),
             p("Q: Quel est le nombre total d’avions?",
               br(),
               "R: Le nombre total d’avions est de 3322."),
             br(),
             p("Q: Combien de vols ont été annulés?",
               br(),
               "R: Il y a eu 6481 vols annulés."),
             br(),
             p("Q: Combien de vols partent des aéroports de NYC vers Seattle?",
               br(),
               "R: 2736 vols partent des aéroports de NYC vers Seattle."),
             br(),
             p("Q: Combien de compagnies desservent Seattle depuis NYC?",
               br(),
               "R: 5 compagnies desservent Seattle depuis NYC."),
             br(),
             p("Q: Combien d’avions «uniques» desservent Seattle depuis NYC?",
               br(),
               "R: 857 avions «uniques» desservent Seattle depuis NYC.")
           )),
  
  
  
  # Page Visualisations
  tabPanel("Visualisations",
           fluidPage(
             h2("Visualisations", style = "color: black; text-align: center;"),
             plotlyOutput("plot1"),
             br(),
             plotlyOutput("plot2"),
             br(),
             plotlyOutput("plot3"),
             br(),
             plotlyOutput("plot4"),
             br(),
             plotlyOutput("plot5"),
             br(),
             plotlyOutput("plot6"),
             br(),
             plotlyOutput("plot7"),
             br(),
             leafletOutput("plot8")
           )),
  
  # Page Prédictions
  tabPanel("Prédictions",
           fluidPage(
             h2("Résultats de Prédiction", style = "color: black; text-align: center;"),
             numericInput("distance", "Distance (miles):", value = 100),
             numericInput("dep_delay", "Retard au Départ (minutes):", value = 10),
             numericInput("air_time", "Temps de Vol (minutes):", value = 60),
             selectInput("carrier", "Compagnie Aérienne:", choices = unique(flights$carrier)),
             selectInput("origin", "Aéroport de Départ:", choices = unique(flights$origin)),
             selectInput("dest", "Aéroport d'Arrivée:", choices = unique(flights$dest)),
             actionButton("predict_btn", "Prédire le Retard à l'Arrivée"),
             br(),
             tableOutput("predictions")
           )),
  

  # Footer
  tags$footer(
    p("© 2024 AirTrafic. Tous droits réservés.", class = "footer")
  )
  )


# Serveur
server <- function(input, output, session) {
  
  ####################Prédictions########################
  
  # Charger le modèle de régression linéaire
  linear_model_delay <- readRDS("C:/Users/litic/Downloads/linear_model_delay.rds")
  
  # Fonction de prédiction
  predict_delay <- function(distance, dep_delay, air_time, carrier, origin, dest) {
    new_data <- data.frame(distance = distance, dep_delay = dep_delay, air_time = air_time, carrier = carrier, origin = origin, dest = dest)
    prediction <- predict(linear_model_delay, newdata = new_data)
    return(prediction)
  }
  
  # Réactivité pour les prédictions
  observeEvent(input$predict_btn, {
    distance <- input$distance
    dep_delay <- input$dep_delay
    air_time <- input$air_time
    carrier <- input$carrier
    origin <- input$origin
    dest <- input$dest
    
    prediction <- predict_delay(distance, dep_delay, air_time, carrier, origin, dest)
    
    output$predictions <- renderTable({
      data.frame(
        Distance = distance,
        Retard_Départ = dep_delay,
        Temps_Vol = air_time,
        Compagnie = carrier,
        Aéroport_Départ = origin,
        Aéroport_Arrivée = dest,
        Prédiction_Retard_Arrivée = prediction
      )
    })
  })
  
  # Créer un graphique de dispersion
  output$scatterPlot <- renderPlot({
    req(input$xvar, input$yvar, input$color)
    
    query <- sprintf("SELECT %s, %s, %s FROM traffic_data", input$xvar, input$yvar, input$color)
    data <- dbGetQuery(con, query)
    
    ggplot(data, aes_string(x = input$xvar, y = input$yvar, color = input$color)) +
      geom_point() +
      labs(x = input$xvar, y = input$yvar, color = input$color) +
      theme_minimal()
  })
  
  ##########################Requêtes sql################################################
  
  # Requête pour récupérer le nombre de destinations desservies par chaque compagnie aérienne
  airline_destinations <- dbGetQuery(con, "
    SELECT a.name AS airline, COUNT(DISTINCT f.dest) AS destinations_count
    FROM flights f
    JOIN airlines a ON f.carrier = a.carrier
    GROUP BY a.name
  ")
  
  # Requête pour récupérer le nombre de destinations desservies par chaque compagnie aérienne par aéroport d'origine
  airline_destinations_by_origin <- dbGetQuery(con, "
    SELECT a.name AS airline, f.origin AS origin_airport, COUNT(DISTINCT f.dest) AS destinations_count
    FROM flights f
    JOIN airlines a ON f.carrier = a.carrier
    GROUP BY a.name, f.origin
  ")
  
  # Requête pour récupérer la relation entre la distance et le retard moyen à l'arrivée
  delay_distance <- dbGetQuery(con, "
    SELECT distance, AVG(arr_delay) AS mean_delay
    FROM flights
    WHERE arr_delay IS NOT NULL
    GROUP BY distance
  ")
  
  # Requête pour récupérer les destinations les plus touchées par les retards et les compagnies associées
  top_delayed_destinations <- dbGetQuery(con, "
    SELECT f.dest AS destination, a.name AS airline, AVG(f.arr_delay) AS avg_delay
    FROM flights f
    JOIN airlines a ON f.carrier = a.carrier
    WHERE f.arr_delay > 0
    GROUP BY f.dest, a.name
    ORDER BY avg_delay DESC
    LIMIT 10
  ")
  
  # Requête SQL pour agréger les données par mois et obtenir le nombre de vols par mois
  monthly_traffic <- dbGetQuery(con, "
  SELECT MONTH(time_hour) AS month, COUNT(*) AS num_flights
  FROM flights
  GROUP BY MONTH(time_hour)
  ")
  
  # Requête SQL pour filtrer les vols selon différentes conditions et obtenir le nombre de vols correspondant à chaque critère
  filtered_flights <- list()
  
  # Filtrer les vols pour le 1er janvier
  filtered_flights$january_1st <- dbGetQuery(con, "
  SELECT COUNT(*) AS num_flights
  FROM flights
  WHERE MONTH(time_hour) = 1 AND DAY(time_hour) = 1
")
  
  # Filtrer les vols pour novembre ou décembre
  filtered_flights$november_december <- dbGetQuery(con, "
  SELECT COUNT(*) AS num_flights
  FROM flights
  WHERE MONTH(time_hour) IN (11, 12)
")
  
  # Filtrer les vols pour les jours spéciaux (25/12, 01/01, 04/07, 29/11)
  filtered_flights$special_days <- dbGetQuery(con, "
  SELECT COUNT(*) AS num_flights
  FROM flights
  WHERE DATE(time_hour) IN ('2024-12-25', '2025-01-01', '2025-07-04', '2025-11-29')
")
  
  # Filtrer les vols pour l'été (juillet, août et septembre)
  filtered_flights$summer <- dbGetQuery(con, "
  SELECT COUNT(*) AS num_flights
  FROM flights
  WHERE MONTH(time_hour) IN (7, 8, 9)
")
  
  # Filtrer les vols pour l'heure de départ entre minuit et 6h
  filtered_flights$midnight_to_six <- dbGetQuery(con, "
  SELECT COUNT(*) AS num_flights
  FROM flights
  WHERE HOUR(sched_dep_time) BETWEEN 0 AND 6
")
  
  # Requête pour récupérer la relation entre l'heure de décollage et le retard moyen
  delay_by_hour <- dbGetQuery(con, "
    SELECT HOUR(STR_TO_DATE(DEP_TIME, '%H%M')) AS dep_hour, AVG(arr_delay) AS avg_arr_delay
    FROM flights
    GROUP BY dep_hour
  ")
  
  # Requête SQL ajustée pour compter les vols annulés par aéroport
  airports_cancelled_flights <- dbGetQuery(con, "
  SELECT a.faa, a.name, a.lat, a.lon, SUM(CASE WHEN f.arr_delay IS NULL THEN 1 ELSE 0 END) AS cancelled_count
  FROM airports a
  LEFT JOIN flights f ON a.faa = f.origin
  GROUP BY a.faa, a.name, a.lat, a.lon
")
  
  
  
  
  ###########################Graphiques#########################################

  # Graphique du nombre de destinations desservies par chaque compagnie aérienne
  output$plot1 <- renderPlotly({
    ggplot(airline_destinations, aes(x = reorder(airline, -destinations_count), y = destinations_count)) +
      geom_bar(stat = "identity") +
      labs(title = "Nombre de Destinations Desservies par Chaque Compagnie Aérienne", x = "Compagnie Aérienne", y = "Nombre de Destinations") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Graphique du nombre de destinations desservies par chaque compagnie aérienne par aéroport d'origine
  output$plot2 <- renderPlotly({
    ggplot(airline_destinations_by_origin, aes(x = reorder(airline, -destinations_count), y = destinations_count, fill = origin_airport)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Nombre de Destinations Desservies par Chaque Compagnie Aérienne par Aéroport d'Origine", x = "Compagnie Aérienne", y = "Nombre de Destinations") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Graphique de la relation entre la distance et le retard moyen à l'arrivée
  output$plot3 <- renderPlotly({
    ggplot(delay_distance, aes(x = distance, y = mean_delay)) +
      geom_point() + 
      geom_smooth(method = "lm", se = FALSE) +
      labs(title = "Relation entre la distance et le retard moyen à l'arrivée",
           x = "Distance (miles)",
           y = "Retard moyen à l'arrivée (minutes)") +
      theme_minimal()
  })
  
  # Graphique des destinations les plus touchées par les retards
  output$plot4 <- renderPlotly({
    ggplot(top_delayed_destinations, aes(x = reorder(destination, -avg_delay), y = avg_delay, fill = airline)) +
      geom_bar(stat = "identity") +
      labs(title = "Destinations les Plus Touchées par les Retards",
           x = "Destination",
           y = "Retard Moyen à l'Arrivée (minutes)",
           fill = "Compagnie Aérienne") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  
  # Graphique de l'évolution du trafic aéroportuaire par mois
  output$plot5 <- renderPlotly({
    plot_ly(monthly_traffic, x = ~month, y = ~num_flights, type = 'scatter', mode = 'lines+markers') %>%
      layout(title = "Évolution du trafic aéroportuaire par mois",
             xaxis = list(title = "Mois"),
             yaxis = list(title = "Nombre de vols"))
  })
  
  
  # Graphique des visualisations pour illustrer les résultats
  output$plot6 <- renderPlotly({
    labels <- c("1er janvier", "Novembre ou Décembre", "Jours spéciaux", "Été", "Départ entre minuit et 6h")
    values <- c(filtered_flights$january_1st$num_flights, filtered_flights$november_december$num_flights,
                filtered_flights$special_days$num_flights, filtered_flights$summer$num_flights,
                filtered_flights$midnight_to_six$num_flights)
    
    plot_ly(labels = labels, values = values, type = 'pie') %>%
      layout(title = "Nombre de vols selon différentes conditions")
  })
  
  
  # Graphique 7: Relation entre l'heure de décollage et le retard moyen
  output$plot7 <- renderPlotly({
    plot7 <- ggplot(delay_by_hour, aes(x = dep_hour, y = avg_arr_delay)) +
      geom_line() +
      geom_point() +
      labs(x = "Heure de décollage", y = "Retard moyen à l'arrivée (minutes)", title = "Relation entre l'heure de décollage et le retard moyen") +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  # Graphique 8: Carte des aéroports avec les vols annulés
  output$plot8 <- renderLeaflet({
    leaflet(data = airports_cancelled_flights) %>%
      addTiles() %>%
      addCircleMarkers(~lon, ~lat,
                       label = ~paste0(name, ": ", cancelled_count, " vols annulés"),
                       color = ~ifelse(cancelled_count > 100, "red", "blue"),
                       radius = ~sqrt(cancelled_count) * 5) %>%
      addControl(
        html = "<h4>Carte des aéroports avec les vols annulés</h4>",  # HTML pour le titre
        position = "topright"  # Position du titre sur la carte (en haut à droite)
      )
  })
  
  
  
  ########################################################################
  

  
  # Fermeture de la connexion à la base de données à la fin de la session
  session$onSessionEnded(function() {
    dbDisconnect(con)
    print("La base de données a été déconnectée.")
  })
}

# Exécution de l'application
shinyApp(ui = ui, server = server)