#=====================================================================================================
# DESCRIPTION   : Application Web
#
# ENVIRONNEMENT : R 4.1.3
#  
# TODO          : 
#=====================================================================================================

library(bs4Dash)

# ----------------------------------------------------------------------------------------------------
# > FONCTIONS
# ----------------------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------------------
# > CONSTANTES
# ----------------------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------------------
# > UI
# ----------------------------------------------------------------------------------------------------

# Header

header <- bs4DashNavbar("",
                        title = bs4DashBrand("Outil entreprise", color = NULL, href = NULL, image = "logo.png", opacity = 0.8),
                        disable = F,
                        .list = NULL,
                        leftUi = NULL,
                        rightUi = NULL,
                        skin = "light",
                        status = "white",
                        border = T,
                        compact = F,
                        sidebarIcon = shiny::icon("bars"),
                        controlbarIcon = shiny::icon("th"),
                        fixed = T)


# Sidebar

sidebar <- bs4DashSidebar(
             bs4SidebarMenu(  
               bs4SidebarMenuItem("Tableau de bord", icon = icon("tachometer-alt"), tabName = "tabDashboard", selected = T),
               bs4SidebarMenuItem("Analyse", icon = icon("chart-pie"),
                 bs4SidebarMenuSubItem("Etablissements", tabName = "tabEtablissements"),
                 bs4SidebarMenuSubItem("Offres", tabName = "tabOffres"),
                 bs4SidebarMenuSubItem("DPAE", tabName = "tabDpae")),
               bs4SidebarMenuItem("Ciblage", icon = icon("bullseye"),
                 bs4SidebarMenuSubItem("Obligation d'Emploi", tabName = "tabBoe"))
             )
           )


# Body

body <- bs4DashBody(

  fluidRow(HTML("Hello <BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>"))
  
  )


# Footer

footer <- bs4DashFooter("Hello")


# Ui

ui <- bs4DashPage(header = header, 
                  sidebar = sidebar, 
                  body = body, 
                  footer = footer, 
                  title="Outil entreprise",
                  dark = NULL,
                  scrollToTop = TRUE)


# ----------------------------------------------------------------------------------------------------
# > SERVER
# ----------------------------------------------------------------------------------------------------

server <- function(input, output) {}


# ----------------------------------------------------------------------------------------------------
# > APP
# ----------------------------------------------------------------------------------------------------

shinyApp(ui, server)