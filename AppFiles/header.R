
header <- 
  dashboardHeader(
    title = dashboardBrand(
      title = "Dairy Goods Sales",
      color = "primary",
      href = "https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset",
      opacity = 0.8
    ),
    status = "#007FFF",
    fixed = TRUE,
    uiOutput("app_title"),
    rightUi = tagList(
      dropdownMenu(
        badgeStatus = "primary",
        type = "messages",
        messageItem(
          inputId = "triggerAction1",
          message = "Click here to go to the main dashboard",
          from = "George Mwangi",
          time = "today",
          color = "lime",
          href = "https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset"
        )
      )
      # userOutput("user")
    )
    
  )
