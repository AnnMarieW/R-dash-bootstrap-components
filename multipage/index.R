#
# library(dash)
# library(dashHtmlComponents)
# library(dashCoreComponents)
#
# app$layout(htmlDiv(list(
#     dccLocation(id='url', refresh=FALSE),
#     htmlDiv(id='page-content')
#     )
#    )
# )
#
# app$callback(output=list(id='page-content', property='children'),
#              params=list(
#           input(id='url', property='pathname')),
#           function(pathname)
#           {
#               if (pathname == '/apps/app1')
#                   return(app1_layout)
#               else if (pathname == '/apps/app2')
#                   return(app2_layout)
#               else
#                   return(app1_layout)
#           }
# )
#
# app$run_server(debug=TRUE)



library(dash)
library(dashBootstrapComponents)
library(dashHtmlComponents)
library(dashCoreComponents)

#
# app <- Dash$new(
#             suppress_callback_exceptions = TRUE,
#               #  external_stylesheets = list('https://codepen.io/chriddyp/pen/bWLwgP.css'))
#                 external_stylesheets = dbcThemes$BOOTSTRAP)
source("multipage/app.R")
source("multipage/apps/alert.R")
source("multipage/apps/badge.R")



# the style arguments for the sidebar. We use position:fixed and a fixed width
sidebar_style <- list(
    position = "fixed",
    top =  0,
    left = 0,
    bottom = 0,
    width = "16rem",
    padding = "2rem 1rem",
    backgroundColor = "#f8f9fa"
)

# the styles for the main content position it to the right of the sidebar and
# add some padding.
content_style <- list(
    marginLeft = "18rem",
    marginRight = "2rem",
    padding = "2rem 1rem"
)

sidebar <- htmlDiv(
    list(
        htmlH2("Components", className = "display-4"),
        htmlHr(),
        dbcNav(
            list(
                dbcNavLink("Home", href = "/", active = "exact"),
                dbcNavLink("Alert", href = "/alert", active = "exact"),
                dbcNavLink("Badge", href = "/badge", active = "exact")
            ),
            vertical = TRUE,
            pills = TRUE,
        )
    ),
    style = sidebar_style,
)

content <- htmlDiv(id = "page-content", style = content_style)

app$layout(
  htmlDiv(
    list(dccLocation(id = "url"), sidebar, content)
  )
)


app$callback(
  output("page-content", "children"),
  list(input("url", "pathname")),
  function(pathname) {
    if (pathname == "/") {
        return(badge_layout)
    } else if (pathname == "/alert") {
        return(alert_layout)
    } else if (pathname == "/badge") {
        return(badge_layout)
    } else {
      # If the user tries to reach a different page, return a 404 message
      return(dbcJumbotron(
        list(
            htmlH1("404: Not found", className = "text-danger"),
            htmlHr(),
            htmlP(sprintf(
              "The pathname \"%s\" was not recognized...", pathname))
        )
      ))
    }
  }
)

app$run_server(suppress_callback_exceptions = TRUE)

