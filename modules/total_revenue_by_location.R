total_revenue_by_location_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("total_revenue_by_location"), height = 380)
  )
}

total_revenue_by_location_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(total_revenue = round(sum(approx_total_revenue_inr, na.rm = TRUE)), .by = customer_location) %>%
        arrange(total_revenue)
    })

    if (nrow(summary_df()) != 0) {
      output$total_revenue_by_location <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "column", hcaes(x = customer_location, y = total_revenue),
            showInLegend = FALSE,
            maxSize = "15%",
            dataLabels = list(enabled = TRUE, format = "{point.y}")
          ) %>%
          hc_colors(colors = c("#007FFF")) %>%
          hc_exporting(enabled = TRUE) %>%
          hc_tooltip(
            crosshairs = TRUE,
            backgroundColor = "white",
            shared = F, borderWidth = 4
          ) %>%
          hc_title(text = "Total Revenue by Customer Location", align = "center", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(text = "NRP", align = "center", style = list(fontweight = "bold", fontsize = "13px")) %>%
          hc_add_theme(hc_theme_elementary()) %>%
          hc_chart(zoomType = "x") %>%
          hc_xAxis(title = list(text = "")) %>%
          hc_yAxis(title = list(text = "Total Revenue"), max = max(summary_df()$total_revenue), labels = list(enabled = FALSE))
      })
    }
  })
}