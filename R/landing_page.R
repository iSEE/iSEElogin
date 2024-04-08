#' Landing page function
#'
#'
#' @return A `function` that defines UI elements and observers for the
#' landing page of the app.
#'
#' @author Kevin Rue-Albrecht
#'
#' @importFrom shiny column fluidRow reactiveValues
#' renderUI selectizeInput tabPanel tagList uiOutput
#' @importFrom shinydashboard box tabBox
#' @importFrom DT DTOutput
#' @importFrom shinyjs disable
#'
#' @rdname INTERNAL_landing_page
.landing_page <- function() {
    function (FUN, input, output, session) {
        # nocov start
        output$allPanels <- renderUI({
            tagList(
                fluidRow(
                    column(width = 4L),
                    column(width = 4L, uiOutput(outputId = .ui_form_overview)),
                    column(width = 4L)
                    )
                ) # tagList
        }) # renderUI

        ## Disable navbar buttons that are not linked to any observer yet
        shinyjs::disable(iSEE:::.generalOrganizePanels) # organize panels
        shinyjs::disable(iSEE:::.generalLinkGraph) # link graph
        shinyjs::disable(iSEE:::.generalExportOutput) # export content
        shinyjs::disable(iSEE:::.generalCodeTracker) # tracked code
        shinyjs::disable(iSEE:::.generalPanelSettings) # panel settings
        shinyjs::disable(iSEE:::.generalVignetteOpen) # open vignette
        shinyjs::disable(iSEE:::.generalSessionInfo) # session info
        shinyjs::disable(iSEE:::.generalCitationInfo) # citation info

        pObjects <- .create_persistent_objects()
        rObjects <- reactiveValues()

        .create_observers(input, session, pObjects, rObjects)

        .create_launch_observers(FUN, input, session, pObjects)

        .render_login_form(output, pObjects, rObjects)

        invisible(NULL)
        # nocov end
    }
}

#' Create persistent objects
#'
#' @param datasets_table A `data.frame` of metadata for all available data sets.
#' @param initial_table A `data.frame` of metadata for all available initial configuration scripts.
#'
#' @return An environment containing several global variables for use throughout the application.
#'
#' @author Kevin Rue-Albrecht
#'
#' @rdname INTERNAL_create_persistent_objects
.create_persistent_objects <- function(datasets_table, initial_table) {
    pObjects <- new.env()
    pObjects
}
