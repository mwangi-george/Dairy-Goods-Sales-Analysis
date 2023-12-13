
ui <- 
  bs4DashPage(
    header = header,
    sidebar = sidebar,
    body = bs4DashBody(
      tabItems(home_tab)
    )
  )

  