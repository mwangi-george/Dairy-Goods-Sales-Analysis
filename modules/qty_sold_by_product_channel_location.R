qty_sold_by_product_sales_channel_location_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("qty_sold_by_product_sales_channel_location"), height = 560)
  )
}

qty_sold_by_product_sales_channel_location_server <- function(id, data, location_to_plot) {
  moduleServer(id, function(input, output, session) {
    summary_df <- reactive({
      data %>%
        summarise(quantity_sold_liters_kg = sum(quantity_sold_liters_kg), .by = c(product_name, sales_channel, location)) %>%
        arrange(product_name, quantity_sold_liters_kg)
    })

    # Define a function to create plots for each location
    create_location_plots <- function(location_df) {
      location_df %>%
        hchart(
          type = "column",
          hcaes(x = product_name, y = quantity_sold_liters_kg, group = sales_channel),
          showInLegend = TRUE,
          maxSize = "15%",
          dataLabels = list(enabled = TRUE, format = "{point.y: 3f}")
        ) %>%
        hc_legend(align = "center") %>%
        hc_colors(colors = c("#007FFF", "#CCCCFF", "#00356B")) %>%
        hc_exporting(enabled = TRUE) %>%
        hc_tooltip(crosshairs = TRUE, backgroundColor = "white", shared = F, borderWidth = 4) %>%
        hc_title(
          text = "Total Quantities Sold by Product and Sales Channel",
          align = "left",
          style = list(fontweight = "bold", fontsize = "15px")
        ) %>%
        hc_subtitle(
          text = paste("Showing data for", unique(location_df$location)),
          align = "left",
          style = list(fontweight = "bold", fontsize = "13px")
        ) %>%
        hc_add_theme(hc_theme_elementary()) %>%
        hc_chart(zoomType = "x") %>%
        hc_xAxis(title = list(text = "Product")) %>%
        hc_yAxis(title = list(text = "Quantity Sold (Litres/kg)"), labels = list(enabled = FALSE)) %>% 
        hc_plotOptions(series = list(states = list(hover = list(enabled = TRUE, color = "red"))))
    }


    if (nrow(summary_df()) != 0) {
      output$qty_sold_by_product_sales_channel_location <- renderHighchart({
        summary_df() %>%
          filter(location == location_to_plot) %>%
          create_location_plots()
      })
    } else {
      output$qty_sold_by_product_sales_channel_location <- renderHighchart({NULL})
    }
  })
}