#' Labelling
#'
#' @param x What to label
#' @export
label_capitalise <- function(x) {
  capitalise <- function(string) {
    capped <- grep("^[A-Z]", string, invert = TRUE)
    substr(string[capped], 1, 1) <- toupper(substr(string[capped], 1, 1))
    string
  }

  x %>% str_replace_all("_", " ") %>% capitalise()
}

#' @export
#' @rdname label_capitalise
label_split <- function(x) {
  x %>% str_replace_all("_", " ")
}



html_color <- function (colors){
  map_chr(colors, function(color) {
    if (substr(color, 1, 1) != "#" | nchar(color) != 9)
      return(color)
    rgba_code <- col2rgb(color, alpha = TRUE)
    rgba_code[4] <- round(rgba_code[4]/255, 2)
    paste0("rgba(", paste(rgba_code, collapse = ", "),")")
  })
}