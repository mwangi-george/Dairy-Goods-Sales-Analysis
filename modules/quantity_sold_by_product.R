quantity_sold_by_product_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("qty_sold_by_product"), height = 380)
  )
}

quantity_sold_by_product_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(total_quantity_sold = sum(quantity_sold_liters_kg), .by = product_name) %>%
        arrange(total_quantity_sold)
    })

    if(nrow(summary_df()) != 0){
      output$qty_sold_by_product <- renderHighchart({
        summary_df() %>%
          hchart(
            type = "column",
            hcaes(x = product_name, y = total_quantity_sold),
            showInLegend = FALSE, maxSize = "15%",
            dataLabels = list(enabled = TRUE, format = "{point.y}")
          ) %>%
          hc_colors(colors = c("#00356B")) %>%
          hc_exporting(enabled = TRUE) %>%
          hc_tooltip(crosshairs = TRUE, backgroundColor = "white", shared = F, borderWidth = 4) %>%
          hc_title(text = "Total Quantity Sold by Product", align = "center", style = list(fontweight = "bold", fontsize = "15px")) %>%
          hc_subtitle(text = "Litres", align = "center", style = list(fontweight = "bold", fontsize = "13px")) %>%
          hc_add_theme(hc_theme_elementary()) %>%
          hc_chart(zoomType = "x") %>%
          hc_xAxis(title = list(text = "Product")) %>%
          hc_yAxis(
            title = list(text = "Total Quantity Sold (Litres)"),
            max = max(summary_df()$total_quantity_sold), labels = list(enabled = FALSE)
          ) %>% 
          hc_plotOptions(series = list(states = list(hover = list(enabled = TRUE, color = "red"))))
      })
    } else {
      output$qty_sold_by_product <- renderHighchart({NULL})
    }
  })
}