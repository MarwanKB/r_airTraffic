# Auteur: Liticia
# Date: 2024-06-11

library(shiny)
library(shinythemes)
library(DBI)
library(RMySQL)
library(ggplot2)

# Connexion à la base de données (ajustez les paramètres selon vos besoins)
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
<<<<<<< HEAD
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
             h1("AirTraffic Insights", class = "title"),
             img(src = "https://static.vecteezy.com/system/resources/previews/000/550/634/original/airplane-flying-vector-icon.jpg", height = "300px", style = "display: block; margin-left: auto; margin-right: auto;"),
             br(),
             p("Bienvenue sur notre projet de visualisation et d'analyse prédictive du trafic. Ce projet a pour but de fournir des insights utiles à la prise de décision à partir des données historiques de trafic.", style = "text-align: center; z-index: 1; position: relative;"),
             
             
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
             
=======
             div(
               h1("Projet Trafic Aérien", style = "color: blue; text-align: center; z-index: 1; position: relative;"),
               p("Bienvenue sur notre projet de visualisation et d'analyse prédictive du trafic. Ce projet a pour but de fournir des insights utiles à la prise de décision à partir des données historiques de trafic.", style = "text-align: center; z-index: 1; position: relative;"),
               img(src = "https://th.bing.com/th/id/OIP.89XJfg4a1BIJRLWPjsWtRgHaE8?rs=1&pid=ImgDetMain", height = "300px", style = "display: block; margin-left: auto; margin-right: auto;"), 
               br(),
               div(class = "team-section", style = "display: flex;",
                   div(class = "team-member", style = "margin-right: 50px; margin-left: 250px;",
                       img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Liticia", width = "200px", height = "200px"),
                       p("Liticia", style = "margin-top: -20px; text-align: center;")
                   ),
                   div(class = "team-member", style = "margin-right: 50px;",
                       img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Marwan", width = "200px", height = "200px"),
                       p("Marwan", style = "margin-top: -20px; text-align: center;")
                   ),
                   div(class = "team-member", style = "margin-right: 50px;",
                       img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Dorcas", width = "200px", height = "200px"),
                       p("Dorcas", style = "margin-top: -20px; text-align: center;")
                   ),
                   div(class = "team-member",
                       img(src = "https://thumbs.dreamstime.com/b/muestra-masculina-de-person-symbol-profile-circle-avatar-del-vector-icono-usuario-115922591.jpg", alt = "Rabab", width = "200px", height = "200px"),
                       p("Rabab", style = "margin-top: -20px; text-align: center;")
                   )
               )
             )
>>>>>>> f756b5374e8d24cba572b969dc712cb7934cf490
           )),
  
  # Page Q/A
  tabPanel("Q/A",
           fluidPage(
             h2("Questions & Réponses", style = "color: black; text-align: center;"),
             br(),
             p("Q: Quelle est la période des données utilisées?",
               br(),
               "R: Les données couvrent la période de janvier 2020 à décembre 2023."),
             br(),
             p("Q: Quels types de données sont analysés?",
               br(),
               "R: Les données incluent le volume de trafic, les incidents signalés, et les conditions météorologiques."),
             br(),
             p("Q: Quels modèles de prédiction sont utilisés?",
               br(),
               "R: Nous utilisons des modèles de régression linéaire et des forêts aléatoires.")
           )),
  
  # Page Visualisations
  tabPanel("Visualisations",
           fluidPage(
             h2("Visualisations", style = "color: black; text-align: center;"),
             plotOutput("plot1"),
             plotOutput("plot2"),
             plotOutput("plot3"),
             plotOutput("plot4")
           )),
  
  # Page Prédictions
  tabPanel("Prédictions",
           fluidPage(
             h2("Résultats de Prédiction", style = "color: black; text-align: center;"),
             tableOutput("predictions")
           ))
)

# Serveur
server <- function(input, output, session) {
<<<<<<< HEAD
  
=======
>>>>>>> f756b5374e8d24cba572b969dc712cb7934cf490
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
  
<<<<<<< HEAD
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
  
=======
>>>>>>> f756b5374e8d24cba572b969dc712cb7934cf490
  # Graphique du nombre de destinations desservies par chaque compagnie aérienne
  output$plot1 <- renderPlot({
    ggplot(airline_destinations, aes(x = reorder(airline, -destinations_count), y = destinations_count)) +
      geom_bar(stat = "identity") +
      labs(title = "Nombre de Destinations Desservies par Chaque Compagnie Aérienne", x = "Compagnie Aérienne", y = "Nombre de Destinations") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Graphique du nombre de destinations desservies par chaque compagnie aérienne par aéroport d'origine
  output$plot2 <- renderPlot({
    ggplot(airline_destinations_by_origin, aes(x = reorder(airline, -destinations_count), y = destinations_count, fill = origin_airport)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Nombre de Destinations Desservies par Chaque Compagnie Aérienne par Aéroport d'Origine", x = "Compagnie Aérienne", y = "Nombre de Destinations") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
<<<<<<< HEAD
  })
  
  # Graphique de la relation entre la distance et le retard moyen à l'arrivée
  output$plot3 <- renderPlot({
    ggplot(delay_distance, aes(x = distance, y = mean_delay)) +
      geom_point() + 
      geom_smooth(method = "lm", se = FALSE) +
      labs(title = "Relation entre la distance et le retard moyen à l'arrivée",
           x = "Distance (miles)",
           y = "Retard moyen à l'arrivée (minutes)") +
      theme_minimal()
  })
  
  # Graphique des destinations les plus touchées par les retards
  output$plot4 <- renderPlot({
    ggplot(top_delayed_destinations, aes(x = reorder(destination, -avg_delay), y = avg_delay, fill = airline)) +
      geom_bar(stat = "identity") +
      labs(title = "Destinations les Plus Touchées par les Retards",
           x = "Destination",
           y = "Retard Moyen à l'Arrivée (minutes)",
           fill = "Compagnie Aérienne") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
=======
>>>>>>> f756b5374e8d24cba572b969dc712cb7934cf490
  })
  
  # Exemples de prédictions
  output$predictions <- renderTable({
    # Génération de données de prédiction factices pour l'exemple
    data.frame(
      Date = Sys.Date() + 0:4,
      Prediction = c(100, 150, 200, 250, 300)
    )
  })
  
  # Fermeture de la connexion à la base de données à la fin de la session
  session$onSessionEnded(function() {
    dbDisconnect(con)
    print("La base de données a été déconnectée.")
  })
}

# Exécution de l'application
shinyApp(ui = ui, server = server)