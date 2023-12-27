summary_stats_hchart_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("summary_highchart"), height = 530) %>% withSpinner(type = 4, size = .5)
  )
}

summary_stats_hchart_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(
          revenue = round(sum(approx_total_revenue_inr)), .by = location
        ) %>%
        arrange(desc(revenue))
    })

    if (nrow(summary_df()) != 0) {
      output$summary_highchart <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "bar", hcaes(x = location, y = revenue),
            showInLegend = FALSE,
            maxSize = "15%",
            dataLabels = list(enabled = TRUE, format = "{point.y: 3f}")
          ) %>%
          hc_colors(colors = "#00356B") %>%
          hc_exporting(enabled = TRUE) %>%
          hc_tooltip(
            crosshairs = TRUE,
            backgroundColor = "white",
            shared = F, borderWidth = 4
          ) %>%
          hc_title(text = "Total Dairy Revenue by Region", align = "center", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_add_theme(hc_theme_elementary()) %>%
          hc_chart(zoomType = "x") %>%
          hc_xAxis(title = list(text = "")) %>%
          hc_yAxis(labels = list(enabled = FALSE), title = list(text = "Total Revenue (NPR)")) %>% 
          hc_plotOptions(series = list(states = list(hover = list(enabled = TRUE, color = "red"))))
      })
    } else {
      output$summary_highchart <- renderHighchart({NULL})
    }
  })
}