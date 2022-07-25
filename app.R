#===================================================================================================
# DESCRIPTION   : Application Web
#
# ENVIRONNEMENT : R 4.1.3
#  
# TODO          : 
#===================================================================================================

library(bs4Dash)
library(tidyverse)
library(shinyWidgets)
library(glue)


# --------------------------------------------------------------------------------------------------
# > CONSTANTES
# --------------------------------------------------------------------------------------------------

zones <- read_csv('zones.csv')

zoneInput <- selectizeInput(
  inputId = 'zoneInput', 
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
  condition = I("input.zoneInput.length !== 0"),
  actionButton(
    inputId = 'filtresButton',
    label = "Filtres", 
    icon = shiny::icon('sliders-h'), 
    width = NULL, 
    dashboardBadge(2, color = 'danger')
  )
)


# --------------------------------------------------------------------------------------------------
# > UI
# --------------------------------------------------------------------------------------------------

# Body
body <- bs4DashBody(
  shinyjs::useShinyjs(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$script(src = "functions.js"),
  ),
  verbatimTextOutput("affiche"),
    conditionalPanel(
    condition = I("input.zoneInput.length !== 0"),
    bs4TabItems(
      bs4TabItem(
        tabName = 'tabTdb',
        "Tableau de bord",
      ),
      bs4TabItem(
        tabName = 'tabEtablissements',
        "Etablissements"
      ),
      bs4TabItem(
        tabName = 'tabOffres',
        "Offres"
      ),
      bs4TabItem(
        tabName = 'tabDpae',
        "DPAE"
      ),
      bs4TabItem(
        tabName = 'tabBoe',
        "BOE"
      ),
      bs4TabItem(
        tabName = 'tabAPropos',
        pmap(cstAlertesListe, fctAlertesBody)
      )
    )
  ) 
)


# Header
header <- bs4DashNavbar(
  title = bs4DashBrand(
    "Outil entreprise", 
    color = NULL, 
    href = NULL, 
    image = "logo.png",
    opacity = 0.8),
  rightUi = fctBs4DropdownMenu(
    badgeStatus = 'info',
    type = 'notifications',
    icon = shiny::icon('bell'),
    headerText = "Les derniers ajouts",
    .list = pmap(cstAlertesListe, fctAlertesHeader),
    href = 'tabAPropos'
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
    tags$li(class = 'nav-item', zoneInput),
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
    condition = I("input.zoneInput.length !== 0"),
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
      ),
      bs4SidebarMenu(
        bs4SidebarMenuItem(
          text = "A propos", 
          tabName = 'tabAPropos', 
          icon = shiny::icon('info')
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


# --------------------------------------------------------------------------------------------------
# > SERVER
# --------------------------------------------------------------------------------------------------

server <- function(input, output, session) {
  
  # Update de la box zoneInput
  updateSelectizeInput(
    session = session, 
    inputId = 'zoneInput', 
    choices = zones, 
    selected = zones %>% filter(Type_zone == ""),
    server = TRUE)
  
  # Contrôle de la sidebar en fonction du choix de la box
  observeEvent(input$zoneInput, {
    if (is.null(input$zoneInput)) {
      shinyjs::addCssClass(selector = "body", class = "sidebar-collapse")
    }
    else {
      shinyjs::removeCssClass(selector = "body", class = "sidebar-collapse")
    }
  },
  ignoreInit = TRUE,
  ignoreNULL = FALSE
  )
  
  # Modal de filtre
  observeEvent(input$filtresButton, {
    showModal(
      modalDialog(
        h4("Secteur d'activité"),
        div(style = "padding: 20px 0",
            shinyWidgets::actionBttn(
              inputId = "Id110",
              label = "bordered", 
              style = "bordered",
              color = "success",
              icon = icon("sliders-h'")
            ),
            shinyWidgets::actionBttn(
              inputId = "Id110",
              label = "bordered", 
              style = "bordered",
              color = "success",
              icon = icon("sliders-h'")
            ),
            shinyWidgets::actionBttn(
              inputId = "Id110",
              label = "bordered", 
              style = "bordered",
              color = "success",
              icon = icon("sliders-h'")),
            shinyWidgets::actionBttn(
              inputId = "Id110",
              label = "bordered", 
              style = "bordered",
              color = "success",
              icon = icon("sliders-h'")),
            shinyWidgets::actionBttn(
              inputId = "Id110",
              label = "bordered", 
              style = "bordered",
              color = "success",
              icon = icon("sliders-h'")),
            shinyWidgets::actionBttn(
              inputId = "Id110",
              label = "bordered", 
              style = "bordered",
              color = "success",
              icon = icon("sliders-h'")),
            shinyWidgets::actionBttn(
              inputId = "Id110",
              label = "bordered", 
              style = "bordered",
              color = "success",
              icon = icon("sliders-h'")
            )
        ),
        shinyWidgets::checkboxGroupButtons(
          inputId = "Id057",
          label = "Choose a graph :", 
          choices = c(`<i class='fa fa-bar-chart'><p>Agriculture</p></i>` = "t1", 
                      `<i class='fa fa-line-chart'></i>` = "t2", 
                      `<i class='fa fa-pie-chart'></i>` = "t3",
                      `<i class='fa fa-bar-chart'></i>` = "t4", 
                      `<i class='fa fa-line-chart'></i>` = "t5", 
                      `<i class='fa fa-pie-chart'></i>` = "t6",
                      `<i class='fa fa-bar-chart'></i>` = "t7", 
                      `<i class='fa fa-line-chart'></i>` = "t8", 
                      `<i class='fa fa-pie-chart'></i>` = "t8",
                      `<i class='fa fa-bar-chart'></i>` = "t10", 
                      `<i class='fa fa-line-chart'></i>` = "t11", 
                      `<i class='fa fa-pie-chart'></i>` = "t12",
                      `<i class='fa fa-bar-chart'></i>` = "t13", 
                      `<i class='fa fa-line-chart'></i>` = "t14", 
                      `<i class='fa fa-pie-chart'></i>` = "t15"),
          size = 'lg',
          justified = TRUE,
          individual = TRUE
        ),
        br(),
        hr(),
        br(), br(), br(),
        title = HTML("<h5 class='modal-title' id='exampleModalLongTitle'>Filtres</h5>
                      <button type='button' class='close' data-dismiss='modal' aria-label='Close'>
                       <span aria-hidden='true'>&times;</span>
                      </button>"),
        size = 'l',
        easyClose = TRUE,
        footer = tagList(
          actionButton('appliFiltresButton', "Afficher 5 654 établissements"),
        )
      )
    )
  })
  
  # Output de test
  output$affiche <- renderPrint({
    idZone <- as.character(zones[as.integer(input$zoneInput), 1])
    typeZone <- as.character(zones[as.integer(input$zoneInput), 2])
    libelleZone <- as.character(zones[as.integer(input$zoneInput), 3])
    c(input$zoneInput, is.null(input$zoneInput), idZone, typeZone, libelleZone)
  })
  
}


# --------------------------------------------------------------------------------------------------
# > APP
# --------------------------------------------------------------------------------------------------

shinyApp(ui, server)
