library(dash)
library(dashBootstrapComponents)

app <- Dash$new(
            suppress_callback_exceptions = TRUE,
              #  external_stylesheets = list('https://codepen.io/chriddyp/pen/bWLwgP.css'))
                external_stylesheets = dbcThemes$BOOTSTRAP)

app$config$silence_routes_logging <- TRUE