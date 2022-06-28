library(shiny)

ui <- 
  dashboardPage(
    selectizeInput(inputId = 'group', 
                   label = NULL, 
                   choices = NULL, 
                   # multiple = F, 
                   options = list(placeholder = 'Select a category...',
                                  # maxItems = 1,
                                  # optgroups = list(list(value = '1st', label = 'First Class'),
                                  #                  list(value = '2nd', label = 'Second Class'),
                                  #                  list(value = '3rd', label = 'Third Class'),
                                  #                  list(value = 'Crew', label = 'Crew')),
                                  optgroupField = 'Class' # 'Class' is a field in Titanic2 created in server.R
                                  # optgroupOrder = c('1st', '2nd', '3rd', 'Crew'),
                                  # searchField = c('Sex', 'Age', 'Survived'), # you can type and search in these fields in Titanic2
                                  # render = I("{
                                  #   option: function(item, escape) {
                                  #     return '<div>' + escape(item.Age) + ' (' +
                                  #             (item.Sex == 'Male' ? '&male;' : '&female;') + ', ' +
                                  #             (item.Survived == 'Yes' ? '&hearts;' : '&odash;') + ')' +
                                  #            '</div>';
                                  #     }
                                  #     }") 
                                  )
                  ),
    verbatimTextOutput('row')
)
  
server <- function(input, output, session) {
  Titanic2 <- as.data.frame(Titanic, stringsAsFactors = FALSE)
  Titanic2 <- cbind(Titanic2, value = seq_len(nrow(Titanic2)))
  Titanic2$label <- apply(Titanic2[, 2:4], 1, paste, collapse = ', ')
  updateSelectizeInput(session = session, 
                       inputId = 'group', 
                       choices = Titanic2, 
                       server = TRUE)
  
  output$row <- renderPrint({
                  validate(need(input$group, 'Please type and search (e.g. Female)'))
                  Titanic2[as.integer(input$group), -(6:7)]
                })
}

shinyApp(ui, server)