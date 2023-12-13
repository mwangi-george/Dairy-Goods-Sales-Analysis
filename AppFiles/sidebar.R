sidebar <-
  dashboardSidebar(
    width = 320,
    fixed = TRUE,
    skin = "light",
    status = "primary",
    id = "sidebar",
    # customArea = fluidRow(
    #   actionButton(
    #     inputId = "myAppButton",
    #     label = NULL,
    #     icon = icon("users"),
    #     width = NULL,
    #     status = "primary",
    #     style = "margin: auto",
    #     dashboardBadge(textOutput("btnVal"), color = "danger")
    #   )
    # ),
    sidebarUserPanel(
      image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png",
      name = "Welcome Onboard!"
    ),
    sidebarMenu(
      id = "current_tab",
      flat = FALSE,
      compact = FALSE,
      childIndent = TRUE,
      sidebarHeader("Navigator"),
      menuItem(
        "Home",
        tabName = "home",
        icon = icon("sliders")
      ),
      menuItem(
        "National Outlook",
        badgeLabel = "New",
        badgeColor = "success",
        tabName = "narrowing_down",
        icon = icon("flag-checkered")
      ),
      sidebarHeader("About"),
      menuItem(
        "Project Description",
        tabName = "description",
        icon = icon("droplet")
      )
    )
  )
