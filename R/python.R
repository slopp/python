#
#' @export
`$.py_object` <- function(x, name) {
  attr <- py_get_attr(x, name)
  if (py_is_callable(attr)) {
    function(...) {
      args <- list()
      keywords <- list()
      dots <- list(...)
      names <- names(dots)
      if (!is.null(names)) {
        for (i in 1:length(dots)) {
          name <- names[[i]]
          if (nzchar(name))
            keywords[[name]] <- dots[[i]]
          else
            args[[length(args) + 1]] <- dots[[i]]
        }
      } else {
        args <- dots
      }
      result = py_call(attr, args, keywords)
      if (is.null(result))
        invisible(result)
      else
        result
    }
  } else {
    attr
  }
}

#' @export
`[[.py_object` <- `$.py_object`

#' @export
print.py_object <- function(x, ...) {
  py_print(x)
}

#' @importFrom utils .DollarNames
#' @export
.DollarNames.py_object <- function(x, pattern = "") {

  # get the names and filter out internal attributes (_*)
  names <- py_list_attributes(x)
  names <- names[substr(names, 1, 1) != '_']

  # get the types
  attr(names, "types") <- py_get_attribute_types(x, names)

  # get the doc strings
  inspect <- py_import("inspect")
  attr(names, "docs") <- sapply(names, function(name) {
    inspect$getdoc(py_get_attr(x, name))
  })

  # return
  names
}