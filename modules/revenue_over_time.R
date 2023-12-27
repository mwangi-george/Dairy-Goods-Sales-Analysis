revenue_over_time_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("total_revenue_over_time"), height = 560)
  )
}

revenue_over_time_server <- function(id, data, location_to_plot) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        filter(location == location_to_plot) %>%
        summarise(total_revenue = round(sum(approx_total_revenue_inr, na.rm = T)), .by = c(location, production_date)) %>%
        arrange(production_date)
    })


    #if (nrow(summary_df()) != 0) {
      output$total_revenue_over_time <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "line", hcaes(x = production_date, y = total_revenue, group = location, color = location),
            showInLegend = TRUE,
            # visible = FALSE,
            maxSize = "15%",
            dataLabels = list(enabled = FALSE, format = "{point.y}")
          ) %>%
          hc_exporting(enabled = TRUE) %>%
          hc_tooltip(crosshairs = TRUE, backgroundColor = "white", shared = F, borderWidth = 4) %>%
          hc_title(text = "Total Revenue by Customer Location over Time", align = "center", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(text = "NRP", align = "center", style = list(fontweight = "bold", fontsize = "13px")) %>%
          hc_caption(text = "Select locations to show on chart", style = list(fontweight = "bold", fontsize = "10px"), align = "right") %>%
          hc_add_theme(hc_theme_elementary()) %>%
          hc_chart(zoomType = "x") %>%
          hc_xAxis(title = list(text = "Date")) %>%
          hc_yAxis(title = list(text = "Total Revenue"), max = max(summary_df()$total_revenue)) %>%
          hc_rangeSelector(enabled = TRUE, selected = 6, verticalAlign = "bottom") %>% 
          hc_plotOptions(series = list(states = list(hover = list(enabled = TRUE, color = "red"))))
      })
    # } else {
    #   output$total_revenue_over_time <- renderHighchart({NULL})
    # }
  })
}