library(shiny)
library(shinythemes)
library(DBI)

# Connexion à la base de données (ajustez les paramètres selon vos besoins)
#con <- dbConnect(RMySQL::MySQL(), 
#                 dbname = "traffic-aerien_projet",
#                 host = "mysql-traffic-aerien.alwaysdata.net",
#                 user = "363257_liticia",
#                 password = "root_liticia")

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
                   
                   div(class = "team-member", style = "margin-right: 50px;",  style = "margin-left: 250px;",
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
  # Exemples de visualisations
  output$plot1 <- renderPlot({
    # Génération d'un graphique factice pour l'exemple
    plot(1:10, rnorm(10), type = "b", main = "Volume de Trafic", xlab = "Temps", ylab = "Volume")
  })
  
  output$plot2 <- renderPlot({
    # Génération d'un autre graphique factice pour l'exemple
    barplot(table(mtcars$cyl), main = "Distribution des Cylindres", xlab = "Nombre de Cylindres", ylab = "Fréquence")
  })
  
  # Exemples de prédictions
  output$predictions <- renderTable({
    # Génération de données de prédiction factices pour l'exemple
    data.frame(
      Date = Sys.Date() + 0:4,
      Prediction = c(100, 150, 200, 250, 300)
    )
  })
  
  # Navigation entre les pages
  observeEvent(input$goto_qna, {
    updateTabsetPanel(session, "tabs", selected = "Q/A")
  })
  
  observeEvent(input$goto_visualization, {
    updateTabsetPanel(session, "tabs", selected = "Visualisations")
  })
  
  observeEvent(input$goto_predict, {
    updateTabsetPanel(session, "tabs", selected = "Prédictions")
  })
}

# Exécution de l'application
shinyApp(ui = ui, server = server)

#dbDisconnect(con)
#print("La base de données a été déconnectée.")

