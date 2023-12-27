storage_condition_on_shelf_life_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("storage_condition_effect_on_shelf_life"), height = 380)
  )
}

storage_condition_on_shelf_life_server <- function(id, data, locations) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(shelf_life_days = round(mean(shelf_life_days, na.rm = T)), .by = c(product_name, storage_condition)) %>%
        arrange(shelf_life_days)
    })

    if (nrow(summary_df()) != 0) {
      output$storage_condition_effect_on_shelf_life <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "column", hcaes(x = product_name, y = shelf_life_days, group = storage_condition, color = storage_condition),
            showInLegend = TRUE,
            maxSize = "15%",
            dataLabels = list(enabled = TRUE, format = "{point.y}")
          ) %>%
          hc_exporting(enabled = TRUE) %>%
          hc_tooltip(crosshairs = TRUE, backgroundColor = "white", shared = F, borderWidth = 4) %>%
          hc_title(text = "Average Shelf Life by Product and Storage Condition (Days)", align = "left", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(text = "How does the storage condition affect the shelf life of each Product?", align = "left", style = list(fontweight = "bold", fontsize = "13px")) %>%
          hc_add_theme(hc_theme_elementary()) %>%
          hc_chart(zoomType = "x") %>%
          hc_xAxis(title = list(text = "Product")) %>%
          hc_yAxis(title = list(text = "Shelf Life (Days)"), labels = list(enabled = FALSE)) %>% 
          hc_plotOptions(series = list(states = list(hover = list(enabled = TRUE, color = "red"))))
      })
    } else {
      output$storage_condition_effect_on_shelf_life <- renderHighchart({NULL})
    }
  })
}