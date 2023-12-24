footer = dashboardFooter(
  fixed = FALSE,
  left = a(
    href = "https://twitter.com/mwangi__george",
    target = "_blank", HTML(paste("Developed with", icon("heart"), "by", "George Mwangi", icon("twitter"))),
    style = "text-decoration: underline; font-size: 14px"
  ),
  right = h6(
    a(
      HTML(paste(icon("github"), "&copy; 2023 George Mwangi | All Rights Reserved")),
      style = "text-decoration: underline; font-size: 14px", href = "https://github.com/mwangi-george", target = "_blank"
    ), 
    class = "center-text")
)