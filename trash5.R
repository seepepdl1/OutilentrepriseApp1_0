#app.r
library(bs4Dash)
library(shinyWidgets)

shinyApp(
  ui = bs4DashPage(
    header = bs4DashNavbar(
      tags$li(
        tags$style(type = "text/css", ".selectize-input {
                                         height: 20px;
                                         width: 500px;
                                        }
                                        label.control-label, .selectize-control.single { 
                                         display: table-cell; 
                                         text-align:left; 
                                         vertical-align: middle; 
                                        } 
                                      .form-group { 
                                       display: table-row;
                                      }"),
        div(style = "height: 50px; 
                     width: 500px;
                     margin-top: 0px;
                     margin-right: 30px;
                     margin-bottom:0px;",
            selectInput(inputId = "variable",
                        label = NULL,
                        choices = c("Cylinders" = "cyl",
                                    "Transmission" = "am",
                                    "Gears" = "gear")
            )
        )
      )
    ),
    sidebar = bs4DashSidebar(),
    body = bs4DashBody(
    ),
    title = "DashboardPage"
  ),
  server = function(input, output) { }
)