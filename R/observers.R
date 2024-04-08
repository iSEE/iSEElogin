#' Observers for iSEElogin
#' 
#' @description 
#' 
#' `.create_observers()` initialises observers for the \pkg{iSEElogin} landing page.
#' 
#' `.create_launch_observers()` initialises observers for launching the \pkg{iSEE} main app.
#'
#' @param input The Shiny input object from the server function.
#' @param session The Shiny session object from the server function.
#' @param pObjects An environment containing global parameters generated in the landing page.
#' @param rObjects A reactive list of values generated in the landing page.
#' 
#' @return 
#' Those functions create observers in the server function in which they are called.
#' In all cases, a \code{NULL} value is invisibly returned.
#' 
#' @author Kevin Rue-Albrecht
#'
#' @importFrom shiny isolate textInput
#'
#' @rdname INTERNAL_create_observers
.create_observers <- function(input, session, pObjects, rObjects) {

    invisible(NULL)
}

#' @param FUN A function to initialize the \pkg{iSEE} observer
#' architecture. Refer to [iSEE::createLandingPage()] for more details.
#'
#' @importFrom shiny observeEvent
#'
#' @rdname INTERNAL_create_observers
.create_launch_observers <- function(FUN, input, session, pObjects) {

    # nocov start
    observeEvent(input[[.ui_login_submit]], {
        .launch_isee(FUN, session, pObjects)
    }, ignoreNULL=TRUE, ignoreInit=TRUE)
    # nocov end

    invisible(NULL)
}
