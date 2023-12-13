server <- function(input, output, session) {
  output$app_title <- renderUI({
    h3(
      a(
        href = "https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset",
        target = "_blank", "Analysis of the Dairy Goods Sales Dataset"
      ),
      class = "affected",
      style =
        "margin: auto; background-color: #F0F8FF"
    )
  })
  
  
  output$map_frame <- renderLeaflet({
    
    revenue <- dairy_df %>% 
      summarise(total_revenue = sum(approx_total_revenue_inr, na.rm = T), .by = c(product_name, location)) %>% 
      arrange(desc(total_revenue)) %>% 
      inner_join(data, by = "location") 
    
    leaflet(data = revenue) %>% 
      addTiles() %>%
      setView(lng = 78.9629, lat = 20.5937, zoom = 5) %>% 
      addCircleMarkers(
        lng = ~longitude,
        lat = ~latitude,
        radius = sqrt(revenue$total_revenue) / 50, # Adjust the radius size based on total revenue
        color = "red",
        fillOpacity = 0.7,
        popup = paste("Location: ", revenue$location, "<br>",
                      "Total Revenue: ", format(round(revenue$total_revenue, 0), big.mark = ", "))
      )
  })
}
