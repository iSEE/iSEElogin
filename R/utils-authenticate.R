.authenticate <- function(username, password) {
  authorised_file <- system.file(package = "iSEElogin", "authorized")
  authorised_info <- read.table(authorised_file, col.names = c("username", "password"))
  any(
    username == authorised_info$username &
      digest(password, "sha512") == authorised_info$password
  )
}