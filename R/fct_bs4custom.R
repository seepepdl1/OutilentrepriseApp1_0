#===================================================================================================
# DESCRIPTION   : Customisation des éléments de BS4DASH
#
# ENVIRONNEMENT : R 4.1.3
#  
# TODO          : 
#===================================================================================================


# --------------------------------------------------------------------------------------------------
# > CUSTOM DROPDOWNMENU
# --------------------------------------------------------------------------------------------------

# Validate status
fctValidateStatus <- function(status) 
{
  if (status %in% c("primary", "secondary", "info", "success", "warning", "danger")
  ) {
    return(TRUE)
  }
  stop("Invalid status: ", status, ". Valid statuses are: ", 
       paste(validStatuses, collapse = ", "), ".")
}

# bs4DropdownMenu
fctBs4DropdownMenu <- function(..., type = c("messages", "notifications", "tasks"), 
                               badgeStatus = "primary", icon = NULL, headerText = NULL, 
                               .list = NULL, href = NULL) 
{
  type <- match.arg(type)
  if (!is.null(badgeStatus)) 
    fctValidateStatus(badgeStatus)
  items <- c(list(...), .list)
  if (is.null(icon)) {
    icon <- switch(type, messages = shiny::icon("comments"), 
                   notifications = shiny::icon("bell"), tasks = shiny::icon("tasks"))
  }
  numItems <- length(items)
  if (is.null(badgeStatus)) {
    badge <- NULL
  }
  else {
    badge <- shiny::span(class = paste0("badge badge-", 
                                        badgeStatus, " navbar-badge"), numItems)
  }
  if (is.null(headerText)) {
    headerText <- paste("You have", numItems, type)
  }
  shiny::tags$li(class = "nav-item dropdown", shiny::tags$a(class = "nav-link", 
                                                            `data-toggle` = "dropdown", 
                                                            href = "#", 
                                                            `aria-expanded` = "false", 
                                                            icon, 
                                                            badge), 
                 shiny::tags$div(class = sprintf("dropdown-menu dropdown-menu-lg"), 
                                 shiny::tags$span(class = "dropdown-item dropdown-header", 
                                                  headerText), shiny::tags$div(class = "dropdown-divider"), 
                                 items, if (!is.null(href)) {
                                   shiny::tags$a("Voir le détail des ajouts",
                                                 class = "dropdown-item dropdown-footer",
                                                 onclick = glue("openTab('{href}')"), 
                                                 href = "#")
                                   
                                 }))
}

