sidebar = dashboardSidebar(
  fixed = TRUE,
  skin = "light",
  status = "primary",
  id = "sidebar",
  customArea = fluidRow(
    actionButton(
      inputId = "myAppButton",
      label = NULL,
      icon = icon("users"),
      width = NULL,
      status = "primary",
      style = "margin: auto",
      dashboardBadge(textOutput("btnVal"), color = "danger")
    )
  ),
  sidebarUserPanel(
    image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png",
    name = "Welcome Onboard!"
  ),
  sidebarMenu(
    id = "sidabar",
    flat = FALSE,
    compact = FALSE,
    childIndent = TRUE,
    sidebarHeader("Home"),
    menuItem("Revenue Analysis", tabName = "reveune_details", icon = icon("chart-simple")),
    menuItem("Sales Analysis", tabName = "customer_prefrences", icon = icon("magnifying-glass-chart")),
    menuItem("Performance Analysis", tabName = "summary_statistics", icon = icon("sliders")),
    menuItem("Revenue Over Time", tabName = "time_series_revenue", icon = icon("arrow-trend-up")),
    menuItem("Shelf Life Analysis", tabName = "shelf_life_analysis", icon = icon("heart-pulse")),
    menuItem("More about Shelf Life", tabName = "time_series_shelf_life", icon = icon("chart-line")),
    
    sidebarHeader("About"),
    menuItem("Description", tabName = "description", icon = icon("circle-info")
    )
  )
)