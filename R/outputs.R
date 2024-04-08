#' Render Login Form
#'
#' @param output The Shiny output object from the server function.
#' @param pObjects An environment containing global parameters generated in the landing page.
#' @param rObjects A reactive list of values generated in the landing page.
#'
#' @return Adds a rendered login form to `output`.
#' A \code{NULL} value is invisibly returned.
#' 
#' @author Kevin Rue-Albrecht
#' 
#' @importFrom shiny textInput
#'
#' @rdname INTERNAL_render_login_form
.render_login_form <- function(output, pObjects, rObjects) {
  # nocov start
  output[[.ui_form_overview]] <- renderUI({
    tagList(
      textInput(inputId = .ui_login_username, label = "Username", value = "testuser", placeholder = "Required"),
      textInput(inputId = .ui_login_password, label = "Password", value = "abcd1234", placeholder = "Required"),
      actionButton(inputId = .ui_login_submit, label = "Submit")
    )
  })
  # nocov end
  
  invisible(NULL)
}
