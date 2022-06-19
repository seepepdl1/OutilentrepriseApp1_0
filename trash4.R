library(shiny)
library(dqshiny)

# create 100K random words
opts <- sapply(1:100000, function(i) paste0(sample(letters, 7), collapse=""))

ui <- fluidPage(
  fontawesome::fa_html_dependency(),
  
  tags$style("input{font-family:'Font Awesome\ 5 Free';font-weight: 900;}
  
input:placeholder-shown#auto2{
  background-image: url('https://cdn.iconscout.com/icon/free/png-256/google-1772223-1507807.png');
  text-indent: 20px;
  background-size: 16px 16px;
  background-repeat: no-repeat;
  background-position: 8px 8px;
}

input#auto2:focus{ background-image:none; text-indent: 0px;}"),
  
  fluidRow(
    column(3,
           autocomplete_input("auto1", "Unnamed:", opts, 
                              placeholder = " Search Value",
                              max_options = 1000),
           autocomplete_input("auto2", "Named:", 
                              placeholder = "Search Value",
                              max_options = 1000,
                              structure(opts, names = opts[order(opts)]))
    ), column(3,
              tags$label("Value:"), verbatimTextOutput("val1", placeholder = TRUE),
              tags$label("Value:"), verbatimTextOutput("val2", placeholder = TRUE)
    )
  )
)


server <-  function(input, output) {
  output$val1 <- renderText(as.character(input$auto1))
  output$val2 <- renderText(as.character(input$auto2))
}


shinyApp(ui, server)