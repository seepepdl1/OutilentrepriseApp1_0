#=====================================================================================================
# DESCRIPTION   : Application Web
#
# ENVIRONNEMENT : R 4.1.3hjkhk
#  
# TODO          : 
#=====================================================================================================

library(bs4Dash)
library(tidyverse)


# ----------------------------------------------------------------------------------------------------
# > FONCTIONS
# ----------------------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------------------
# > CONSTANTES
# ----------------------------------------------------------------------------------------------------

zones <- read_csv('zones.csv')

choixZone <- selectizeInput(
  inputId = 'choixZone', 
  label = NULL, 
  choices = NULL, 
  multiple = TRUE, 
  options = list(
    placeholder = "Rechercher une zone...",
    maxItems = '1',
    optgroupField = 'Type_zone', 
    lockOptgroupOrder = TRUE,
    searchField = 'Libelle_zone',
    onDropdownOpen = I("function($dropdown) {
                          if (!this.lastQuery.length) {
                            this.close(); 
                            this.settings.openOnFocus = false;
                          }
                        }"),
    onType = I("function(str) {
                  if (str === \"\") {
                    this.close();
                  }
                }"),
    onItemAdd = I("function() {
                     this.close();
                   }")
  ),
  width = '500px'
)

filtres <-   conditionalPanel(
  condition = I("input.choixZone.length !== 0"),
  actionButton(
    inputId = 'filtres',
    label = "Filtres", 
    icon = shiny::icon('sliders-h'), 
    width = NULL, 
    dashboardBadge(2, color = 'danger')
  )
)


# ----------------------------------------------------------------------------------------------------
# > UI
# ----------------------------------------------------------------------------------------------------

# Body

body <- bs4DashBody(
  shinyjs::useShinyjs(),
  tags$head(
    tags$style(
      HTML(".navbar {
              justify-content: space-between;
            }
           .ml-auto {
             margin-left: initial!important
           }")
    )
  ),
  
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
  
  verbatimTextOutput("affiche")
  
)


# Header

header <- bs4DashNavbar(
  title = bs4DashBrand(
    "Outil entreprise", 
    color = NULL, 
    href = NULL, 
    image = "logo.png",
    opacity = 0.8),
  rightUi = bs4DropdownMenu(
    badgeStatus = 'info',
    type = 'notifications',
    icon = shiny::icon('bell'),
    headerText = "Les derniers ajouts",
    .list = list(
      notificationItem(
        inputId = 'Notif 1',
        text = HTML("Ajout des DPAE <span class='float-right text-muted text-sm'>22/11/2022</span>"),
        icon = shiny::icon('info'),
        status = 'gray-dark'
      ),
      notificationItem(
        inputId = 'Notif 2',
        text = HTML("Ajout des Offres <span class='float-right text-muted text-sm'>07/09/2022</span>"),
        icon = shiny::icon("info"),
        status = "gray-dark"
      )
    ),
    href = "http://www.google.fr"
  ),
  tags$style(
    HTML(".selectize-input {
             height: 38px;
             width: 500px;
          }
          .shiny-input-container {
            margin-bottom: -15px;
            margin-right: 15px;
          }
         /* .selectize-input.items.not-full.has-options:before {
            content: '\\e062';
            font-family: \"Glyphicons Halflings\";
            color: grey;
            line-height: 2;
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            padding: 0 4px;
            font-weight:200;
           }
          .selectize-input.items.not-full.has-options {
            padding-left: 24px;
           } 
          .selectize-input.items.not-full.has-options.has-items {
            padding-left: 0px;
           }
          .selectize-input.items.not-full.has-options .item:first-child {
            margin-left: 20px;
          } */")
  ),
  tags$ul(
    class = 'navbar-nav',
    tags$li(class = 'nav-item', choixZone),
    tags$li(class = 'nav-item', filtres)
  )
)


# Sidebar

sidebar <- bs4DashSidebar(
  id = "sidebar",
  skin = 'dark',
  collapsed = TRUE,
  minified = TRUE,
  expandOnHover = FALSE,
  conditionalPanel(
    condition = I("input.choixZone.length !== 0"),
    bs4SidebarMenu(
      bs4SidebarMenuItem(
        text = "Tableau de bord", 
        tabName = 'tabTdb', 
        icon = shiny::icon('tachometer-alt'), 
        selected = TRUE
      ),
      bs4SidebarMenuItem(
        text = "Analyse", 
        icon = shiny::icon('chart-pie'),
        bs4SidebarMenuSubItem(text = "Etablissements", tabName = 'tabEtablissements'),
        bs4SidebarMenuSubItem(text = "Offres", tabName = 'tabOffres'),
        bs4SidebarMenuSubItem(text = "DPAE", tabName = 'tabDpae')
      ),
      bs4SidebarMenuItem(
        text = "Ciblage",
        icon = shiny::icon('bullseye'),
        bs4SidebarMenuSubItem(text = "Obligation d'Emploi", tabName = 'tabBoe'
        )
      )
    )
  )
)


# Footer

footer <- bs4DashFooter("Hello")


# Ui

ui <- bs4DashPage(
  header = header, 
  sidebar = sidebar, 
  body = body, 
  footer = footer, 
  title = "Outil entreprise",
  dark = NULL,
  scrollToTop = TRUE
)


# ----------------------------------------------------------------------------------------------------
# > SERVER
# ----------------------------------------------------------------------------------------------------

server <- function(input, output, session) {
  
  updateSelectizeInput(
    session = session, 
    inputId = 'choixZone', 
    choices = zones, 
    selected = zones %>% filter(Type_zone == ""),
    server = TRUE)
  
  output$affiche <- renderPrint({
    idZone <- as.character(zones[as.integer(input$choixZone), 1])
    typeZone <- as.character(zones[as.integer(input$choixZone), 2])
    libelleZone <- as.character(zones[as.integer(input$choixZone), 3])
    c(input$choixZone, is.null(input$choixZone), idZone, typeZone, libelleZone)
  })
  
  observeEvent(
    eventExpr = input$choixZone,
    ignoreInit = TRUE,
    ignoreNULL = FALSE,
    handlerExpr = if (is.null(input$choixZone)) {
      shinyjs::addCssClass(selector = "body", class = "sidebar-collapse")
    }
    else {
      shinyjs::removeCssClass(selector = "body", class = "sidebar-collapse")
    }
  )
  
}


# ----------------------------------------------------------------------------------------------------
# > APP
# ----------------------------------------------------------------------------------------------------

shinyApp(ui, server)