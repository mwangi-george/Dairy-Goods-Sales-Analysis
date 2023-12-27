shelf_life_and_qty_in_stock_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("shelf_life_qty_stocked"), height = 350) %>% withSpinner(type = 4, size = .5)
  )
}

shelf_life_and_qty_in_stock_server <- function(id, data, location_to_plot) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>% 
        filter(location == location_to_plot) 
    })
    
    if(nrow(summary_df()) != 0){
      output$shelf_life_qty_stocked <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "scatter", 
            hcaes(x = shelf_life_days, y = quantity_in_stock_liters_kg,  color = product_name, group = product_name),
            showInLegend = TRUE,
            maxSize = "15%",
            dataLabels = list(enabled = F, format = '{point.y}')
          ) %>%
          hc_exporting(enabled = TRUE) %>% 
          hc_tooltip(
            crosshairs = F, 
            backgroundColor = "white",
            shared = T, borderWidth = 4) %>%
          hc_title(text="Relationship between shelf life and quantity in stock by Product",align="left", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(text="A higher shelf life does not necessarily mean dairy farmers will hold more quantity in stock",align="left", style = list(fontweight = "bold", fontsize = "13px")) %>%
          hc_add_theme(hc_theme_elementary()) %>% 
          hc_chart(zoomType = "x") %>% 
          hc_xAxis(title = list(text = "Shelf Life (Days)")) %>% 
          hc_yAxis(title = list(text = "Quantity in Stock (Litres)")) 
      })
    } else {
      output$shelf_life_qty_stocked <- renderHighchart({NULL})
    }
  })
}