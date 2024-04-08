#' iSEElogin App
#'
#' @description
#' Generate an \pkg{iSEE} app that includes a landing page forcing users
#' to log in using any pair of authorised username and password
#' from a predefined set prepared by the app maintainer.
#' 
#' @param app.title Character string to specify the desired title to be displayed in the main window of the dashboard.
#' Defaults to `NULL`, which displays the versions of the `iSEElogin` and `iSEE` packages.
#'
#' @return An [iSEE::iSEE()] app with a custom landing page presenting users with a log in form.
#'
#' @author Kevin Rue-Albrecht
#'
#' @export
#'
#' @importFrom iSEE iSEE
#' @importFrom utils packageVersion
#'
#' @examples
#' ##
#' # iSEElogin ----
#' ##
#'
#' app <- iSEElogin()
#'
#' if (interactive()) {
#'     shiny::runApp(app, port = 1234)
#' }
iSEElogin <- function(app.title = NULL) {
  if (is.null(app.title)) {
    app.title <- sprintf("iSEElogin - v%s | powered by iSEE - v%s",
      packageVersion("iSEElogin"),
      packageVersion("iSEE"))
  }
  
  iSEE(
    landingPage=.landing_page(),
    appTitle = app.title
  )
}



#' Prepare and Launch the Main App.
#'
#' Invokes a function that replaces the landing page by the \pkg{iSEE}
#' interactive dashboard.
#'
#' @details
#' This function wraps steps that can be tracked and reported to the
#' user through a progress bar, using [shiny::withProgress()].
#'
#' @section Unit testing:
#' This function cannot be unit tested (yet), as [shiny::withProgress()]
#' requires a functional `ShinySession` object.
#'
#' This might be revisited in the future.
#'
#' @param FUN A function to initialize the \pkg{iSEE} observer
#' architecture. Refer to [iSEE::createLandingPage()] for more details.
#' @param bfc An [BiocFileCache()] object.
#' @param session The Shiny session object from the server function.
#' @param pObjects An environment containing global parameters generated in the
#' landing page.
#'
#' @return A `NULL` value is invisibly returned.
#'
#' @author Kevin Rue-Albrecht
#'
#' @importFrom utils capture.output
#' @importFrom shiny incProgress markdown modalDialog p showModal
#' showNotification withProgress
#' @importFrom shinyjs enable
#'
#' @rdname INTERNAL_launch_isee
.launch_isee <- function(FUN, session, pObjects) {
  # nocov start
  withProgress(message = sprintf("Logging in ..."),
    value = 0, max = 2, {
      incProgress(1, detail = "Verifying credentials")
      Sys.sleep(2)
      se2 <- try(iseelogin) # TODO
      if (is(se2, "try-error")) {
        showNotification("Login failed.", type="error")
      } else {
        incProgress(1, detail = "Launching iSEE app")
        FUN(SE=se2, INITIAL=initial, TOUR=tour)
        shinyjs::enable(iSEE:::.generalOrganizePanels) # organize panels
        shinyjs::enable(iSEE:::.generalLinkGraph) # link graph
        shinyjs::enable(iSEE:::.generalExportOutput) # export content
        shinyjs::enable(iSEE:::.generalCodeTracker) # tracked code
        shinyjs::enable(iSEE:::.generalPanelSettings) # panel settings
        shinyjs::enable(iSEE:::.generalVignetteOpen) # open vignette
        shinyjs::enable(iSEE:::.generalSessionInfo) # session info
        shinyjs::enable(iSEE:::.generalCitationInfo) # citation info
      }
    }, session = session)
  
  invisible(NULL)
  # nocov end
}
