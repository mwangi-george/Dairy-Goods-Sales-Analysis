avg_shelf_life_by_product_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("avg_shelf_life"), height = 380)
  )
}

avg_shelf_life_by_product_server <- function(id, data, locations) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(avg_shelf_life = round(mean(shelf_life_days)), .by = product_name) %>% 
        arrange(desc(avg_shelf_life))
    })
    
    if(nrow(summary_df()) != 0){
      output$avg_shelf_life <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "bar", hcaes(x = product_name, y = avg_shelf_life),
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
          hc_title(text="Average Shelf Life by Product",align="center", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(text="Days",align="center", style = list(fontweight = "bold", fontsize = "13px")) %>%
          hc_add_theme(hc_theme_elementary()) %>% 
          hc_chart(zoomType = "x") %>% 
          hc_xAxis(title = list(text = "")) %>% 
          hc_yAxis(title = list(text = "Average Shelf Life (Days)"), max = max(summary_df()$avg_shelf_life), labels = list(enabled = FALSE)) %>% 
          hc_plotOptions(series = list(states = list(hover = list(enabled = TRUE, color = "red"))))
      })
    } else {
      output$avg_shelf_life <- renderHighchart({NULL})
    }
  })
}