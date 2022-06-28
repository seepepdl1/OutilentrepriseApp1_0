#app.r
library(bs4Dash)
library(shinyWidgets)



input <- selectInput("variable", label = NULL,
                     c("Cylinders" = "cyl",
                       "Transmission" = "am",
                       "gfd" = "fdg"), width = '500px')


filtres <- actionButton(
  inputId = 'filtres', 
  label = "Filtres", 
  icon = shiny::icon('sliders-h'), 
  width = NULL
)

shinyApp(
  ui = bs4DashPage(
    header = bs4DashNavbar(title = bs4DashBrand("Outil entreprise", color = NULL, href = NULL, image = "logo.png", opacity = 0.8),
                           leftUi = NULL,
                           rightUi = NULL,
                           skin = "light",
                           status = "white",
                           border = T,
                           compact = F,
                           sidebarIcon = NULL,
                           fixed = T,
                           input, filtres
    ),
    sidebar = bs4DashSidebar(),
    body = bs4DashBody(),
    title = "DashboardPage",
    dark = NULL
  ),
  server = function(input, output) { }
)
