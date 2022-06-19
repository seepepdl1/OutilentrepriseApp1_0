library(shiny)
library(bs4Dash)

# UI 

ui <- dashboardPage(header, sidebar, body)
  
# Server
server <- function(input, output) {}

# Application
shinyApp(ui, server)


# Sidebar

sidebar <- dashboardSidebar(
  sidebarMenu(
    br(),
    br(),
    menuItem("Données employeur", icon = icon("building"), startExpanded = T,
             menuSubItem2("Etablissements", tabName = "tabEtablissements"),
             menuSubItem2("Offres", tabName = "tabOffres", badgeLabel = "Bientôt", badgeColor = ""),
             menuSubItem2("DPAE", tabName = "tabDpae", badgeLabel = "Bientôt", badgeColor = "")),
    menuItem("Potentiels", icon = icon("bolt"), startExpanded = F,
             menuSubItem2("Clents Potentiels", tabName = "tabPotentielClient", badgeLabel = "Bientôt", badgeColor = ""),
             menuSubItem2("Potentiel BOE", tabName = "tabPotentielBoe")),
    menuItem("A propos", tabName = "tabaPropos", icon = icon("info-circle"))
  )
)
