button_style_2 <- style <- "color: #007FFF; background-color: white; border-color: white; width: 150px; height: 40px; border-radius: 20px; border: 2px solid white;"

header = dashboardHeader(
  status = "primary",
  title = dashboardBrand(
    title = h4(strong("Dairy Sales Dashboard"), style= "font-size: 16px;"),
    color = "primary",
    href = "https://github.com/mwangi-george",
    image = "dp.jpg",
    opacity = 1
  ),
  fixed = TRUE,
  tooltip(
    title = "Show/Hide left sidebar",
    placement = "bottom",
    actionButton(inputId = "sidebarToggle", label = "Toggle left sidebar", style = button_style_2)
  ),
  tooltip(
    title = "Show/Hide right sidebar",
    placement = "bottom",
    actionButton(inputId = "controlbarToggle", label = "Toggle Controlbar", style = button_style_2)
  ),
  rightUi = tagList(
    dropdownMenu(
      badgeStatus = "danger",
      type = "messages",
      messageItem(
        inputId = "triggerAction1",
        message = "Happy Exploration",
        from = "George Mwangi",
        image = "dp.jpg",
        time = "today",
        color = "lime"
      )
    ),
    userOutput("user")
  ),
  leftUi = tagList(
    dropdownMenu(
      badgeStatus = "info",
      type = "notifications",
      notificationItem(
        inputId = "notification_1",
        text = "Feel free to connect with me",
        status = "primary"
      )
    ),
    dropdownMenu(
      badgeStatus = "info",
      type = "tasks",
      taskItem(
        inputId = "triggerAction3",
        text = "My progress",
        color = "orange",
        value = 10
      )
    )
  )
)
