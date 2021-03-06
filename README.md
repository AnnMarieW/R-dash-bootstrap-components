  
  This repo is for the development of R examples to add to the [dash-bootstrap-components documentation.](https://dash-bootstrap-components.opensource.faculty.ai/docs/components/alert/)
  

the [/docs/components](https://github.com/AnnMarieW/R-dash-bootstrap-components/tree/master/docs/components)
directory has a folder for each component in the dash-bootstrap-components documentation.  These folders will
contain a separate file for each code snippet that will show in a tabbed container in the docs.  
These snippets are not complete apps.  

The  [/examples/components](https://github.com/AnnMarieW/R-dash-bootstrap-components/tree/master/examples/components) directory has complete working apps that can be run to show all the 
the examples for each component in the dbc documentation.   For example, you can see all the 
`alert` examples by running  `/examples/components/alert_app.R`

![image](https://user-images.githubusercontent.com/72614349/118715385-69284d80-b7d8-11eb-892c-ca9c6f623332.png)


```R

library(dash)
library(dashBootstrapComponents)
library(dashHtmlComponents)
library(dashCoreComponents)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)


alerts_simple <- htmlDiv(
  list(
    dbcAlert("This is a primary alert", color = "primary"),
    dbcAlert("This is a secondary alert", color = "secondary"),
    dbcAlert("This is a success alert! Well done!", color = "success"),
    dbcAlert("This is a warning alert... be careful...", color = "warning"),
    dbcAlert("This is a danger alert. Scary!", color = "danger"),
    dbcAlert("This is an info alert. Good to know!", color = "info"),
    dbcAlert("This is a light alert", color = "light"),
    dbcAlert("This is a dark alert", color = "dark")
  )
)

alerts_link <- htmlDiv(
  list(
    dbcAlert(
      list(
        "This is a primary alert with an ",
        htmlA("example link", href = "#", className = "alert-link")
      ),
      color = "primary"
    ),
    dbcAlert(
      list(
        "This is a danger alert with an ",
        htmlA("example link", href = "#", className = "alert-link")
      ),
      color = "danger"
    )
  )
)

alerts_content <- dbcAlert(
  list(
    htmlH4("Well done!", className = "alert-heading"),
    htmlP(
      "This is a success alert with loads of extra text in it. So much
      that you can see how spacing within an alert works with this
      kind of content."
    ),
    htmlHr(),
    htmlP(
      "Let's put some more text down here, but remove the bottom margin",
      className = "mb-0",
    )
  )
)

alerts_dismiss <- htmlDiv(
  list(
    dbcButton(
      "Toggle alert with fade", id = "alert-toggle-fade", n_clicks = 0,
      className = "mr-1"
    ),
    dbcButton("Toggle alert without fade", id = "alert-toggle-no-fade",
              n_clicks = 0),
    htmlHr(),
    dbcAlert(
      "Hello! I am an alert",
      id = "alert-fade",
      dismissable = TRUE,
      is_open = TRUE,
    ),
    dbcAlert(
      "Hello! I am an alert that doesn't fade in or out",
      id = "alert-no-fade",
      dismissable = TRUE,
      fade = FALSE,
      is_open = TRUE,
    )
  )
)

alerts_auto_dismiss <- htmlDiv(
  list(
    dbcButton("Toggle", id = "alert-toggle-auto", className = "mr-1",
              n_clicks = 0),
    htmlHr(),
    dbcAlert(
      "Hello! I am an auto-dismissing alert!",
      id = "alert-auto",
      is_open = TRUE,
      duration = 4000
    )
  )
)



app$layout(
  dbcContainer(
    list(
      htmlH1("Dash Bootstrap Components Documentation for R"),
      htmlHr(),
      htmlH2("Alerts Basic Usage"),
      alerts_simple,
      htmlH2("Alerts Link Color"),
      alerts_link,
      htmlH2("Alerts Additional content"),
      alerts_content,
      htmlH2("Alerts Dismissing"),
      alerts_dismiss,
      htmlH2("Alerts Automatic Dismissing"),
      alerts_auto_dismiss
    ),
  className = "p-5")
)


app$callback(
  output("alert-fade",  "is_open"),
  list(
    input("alert-toggle-fade", "n_clicks"),
    state("alert-fade",  "is_open")
  ),
  function(n, is_open) {
    if (n > 0) {
      return(!is_open)
    }
    return(is_open)
  }
)


app$callback(
  output("alert-no-fade", "is_open"),
  list(
    input("alert-toggle-no-fade", "n_clicks"),
    state("alert-no-fade",  "is_open")
  ),
  function(n, is_open) {
    if (n > 0) {
      return(!is_open)
    }
    return(is_open)
  }
)


app$callback(
  output("alert-auto", "is_open"),
  list(
    input("alert-toggle-auto", "n_clicks"),
    state("alert-auto", "is_open")
  ),
  function(n, is_open) {
    if (n > 0) {
      return(!is_open)
    }
    return(is_open)
  }
)


app$run_server(debug = TRUE)






```