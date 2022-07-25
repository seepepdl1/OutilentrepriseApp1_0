#===================================================================================================
# DESCRIPTION   : Fonctions affichant les alertes
#
# ENVIRONNEMENT : R 4.1.3
#  
# TODO          : 
#===================================================================================================


# --------------------------------------------------------------------------------------------------
# > FONCTION POUR LE HEADER
# --------------------------------------------------------------------------------------------------

fctAlertesHeader <- function(idNotif, 
                             labelNotif, 
                             textNotif,
                             dateNotif, 
                             linkNotif) {
  bs4Dash::notificationItem(
    inputId = idNotif,
    text = HTML(glue("{labelNotif} 
                    <span class='float-right text-muted text-sm'>
                      {dateNotif}
                    </span>")),
    icon = shiny::icon('info'),
    status = 'gray-dark'
  )
}


# --------------------------------------------------------------------------------------------------
# > FONCTION POUR LE BODY
# --------------------------------------------------------------------------------------------------

fctAlertesBody <- function(idNotif, 
                           labelNotif, 
                           textNotif,
                           dateNotif, 
                           linkNotif) {
  
  HTML(glue(' <div class="timeline">
                 <!-- Timeline time label -->
                 <div class="time-label">
                   <span class="bg-green">{dateNotif}</span>
                 </div>
                 <div>
                  <!-- Before each timeline item corresponds to one icon on the left scale -->
                  <i class="fas fa-envelope bg-blue"></i>
                  <!-- Timeline item -->
                  <div class="timeline-item">
                    <!-- Header. Optional -->
                    <h3 class="timeline-header"><a href="{linkNotif}">{labelNotif}</a></h3>
                    <!-- Body -->
                    <div class="timeline-body">
                      {textNotif}  
                    </div>
                    <!-- Placement of additional controls. Optional -->
                    <div class="timeline-footer">
                      <a href="{linkNotif}" class="btn btn-primary btn-sm">Vister</a>
                    </div>
                 </div>
                </div>
                <!-- The last icon means the story is complete -->
                <div>
                  <i class="fas fa-clock bg-gray"></i>
                </div>
              </div>'
  )
  )
}


# --------------------------------------------------------------------------------------------------
# > MODAL D'AFFICHAGE
# --------------------------------------------------------------------------------------------------

# bsModal(id, title, trigger, ..., size)
