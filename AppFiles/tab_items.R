home_tab <- tabItem(
  tabName = "home",
  fluidRow(
    box(
      title = "Total Profit by Location",
      solidHeader = T,
      status = "primary",
      maximizable = T,
      width = 8,
      div(
        class = "map", style = "height: 100%;",
        leafletOutput("map_frame")
      )
    )
  )
)