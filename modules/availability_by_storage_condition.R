availability_by_storage_condition_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("availavility_by_storage_condition"), height = 380)
  )
}

availability_by_storage_condition_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(average_availability = round(mean(quantity_in_stock_liters_kg)), .by = storage_condition) %>% 
        arrange(desc(average_availability))
    })
    
    
    if(nrow(summary_df()) != 0){
      output$availavility_by_storage_condition <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "bar", hcaes(x = storage_condition, y = average_availability),
            showInLegend = FALSE,
            maxSize = "15%",
            dataLabels = list(enabled = TRUE, format = '{point.y}')
          ) %>% 
          hc_colors(colors = c("#00356B")) %>% 
          hc_exporting(enabled = TRUE) %>% 
          hc_tooltip(
            crosshairs = TRUE, 
            backgroundColor = "white",
            shared = F, borderWidth = 4) %>%
          hc_title(text="Average Availability by Storage Condition",align="center", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(text="Litres",align="center", style = list(fontweight = "bold", fontsize = "13px")) %>%
          hc_add_theme(hc_theme_elementary()) %>% 
          hc_chart(zoomType = "x") %>% 
          hc_xAxis(title = list(text = "")) %>% 
          hc_yAxis(title = list(text = "Average Availability (Litres)"), labels = list(enabled = FALSE)) %>% 
          hc_plotOptions(series = list(states = list(hover = list(enabled = TRUE, color = "red"))))
      })
    } else {
      output$availavility_by_storage_condition <- renderHighchart({NULL})
    }
  })
}
