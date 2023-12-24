shelf_life_analysis_over_time_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("shelf_life_over_time_by_product"), height = 350) %>% withSpinner(type = 4, size = .5)
  )
}

shelf_life_analysis_over_time_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(shelf_life_days = round(mean(shelf_life_days, na.rm = T)), .by = c(product_name, production_year)) %>%
        arrange(production_year)
    })

    if (nrow(summary_df()) != 0) {
      output$shelf_life_over_time_by_product <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "line", hcaes(x = as.factor(production_year), y = shelf_life_days, group = product_name, color = product_name),
            showInLegend = TRUE,
            maxSize = "15%",
            dataLabels = list(enabled = TRUE, format = "{point.y}")
          ) %>%
          hc_exporting(enabled = TRUE) %>%
          hc_tooltip(crosshairs = TRUE, backgroundColor = "white", shared = F, borderWidth = 4) %>%
          hc_title(text = "Average Shelf Life over Time (Days)", align = "left", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(
            text = "The shelf life of most products seems to have remained relatively constant over the 4 years",
            align = "left", style = list(fontweight = "bold", fontsize = "13px")
          ) %>%
          hc_add_theme(hc_theme_elementary()) %>%
          hc_chart(zoomType = "x") %>%
          hc_xAxis(title = list(text = "Year")) %>%
          hc_yAxis(title = list(text = "Shelf Life (Days)"), labels = list(enabled = FALSE)) %>%
          hc_rangeSelector(enabled = TRUE, selected = 6, verticalAlign = "bottom")
      })
    }
  })
}