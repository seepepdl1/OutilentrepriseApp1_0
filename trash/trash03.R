library(shiny)
library(shinydashboard)
library(shinyjs)

ui <- shinyUI(dashboardPage(
  dashboardHeader(),
  dashboardSidebar( tags$head(
    tags$script(
      HTML(#code for hiding sidebar tabs 
        "Shiny.addCustomMessageHandler('manipulateMenuItem1', function(message)
        {
        var aNodeList = document.getElementsByTagName('a');

        for (var i = 0; i < aNodeList.length; i++) 
        {
        if(aNodeList[i].getAttribute('data-toggle') == message.toggle && aNodeList[i].getAttribute('role') == message.role) 
        {
        if(message.action == 'hide')
        {
        aNodeList[i].setAttribute('style', 'display: none;');
        } 
        else 
        {
        aNodeList[i].setAttribute('style', 'display: block;');
        };
        };
        }
        });"
      )
    )
  )
  ),
  dashboardBody(
    useShinyjs(),
    actionButton("h1","Hide toggle"),
    actionButton("h2","Show toggle")
  )
))

server <- shinyServer(function(input, output, session) {
  observeEvent(input$h1,{
    session$sendCustomMessage(type = "manipulateMenuItem1", message = list(action = "hide",toggle = "offcanvas", role = "button"))
  })
  observeEvent(input$h2,{
    session$sendCustomMessage(type = "manipulateMenuItem1", message = list(action = "show",toggle = "offcanvas", role = "button"))
  })
})

shinyApp(ui = ui, server = server)