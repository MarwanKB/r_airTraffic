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
  title = "Projet Trafic Aérien",
  theme = shinytheme("flatly"),
  
  # Page d'accueil
  tabPanel("Accueil",
           fluidPage(
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
           )),
  
  # Page Q/A
  tabPanel("Q/A",
           fluidPage(
             h2("Questions & Réponses", style = "color: blue; text-align: center;"),
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
             h2("Visualisations des Données", style = "color: blue; text-align: center;"),
             plotOutput("plot1"),
             plotOutput("plot2")
           )),
  
  # Page Prédictions
  tabPanel("Prédictions",
           fluidPage(
             h2("Résultats de Prédiction", style = "color: blue; text-align: center;"),
             tableOutput("predictions")
           ))
)

# Serveur
server <- function(input, output, session) {
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