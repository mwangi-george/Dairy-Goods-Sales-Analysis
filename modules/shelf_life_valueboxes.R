shelf_life_valueboxes_ui <- function(id) {
  ns <- NS(id)
  tagList(
    valueBoxOutput(ns("avg_shelf_life")),
    valueBoxOutput(ns("min_shelf_life")),
    valueBoxOutput(ns("max_shelf_life"))
  )
}

shelf_life_valueboxes_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    
    
    calc_shelf_life_metric <- function(summary_func) {
      metric_shelf_life <- 
        data %>%
          summarise(metric = round(summary_func(shelf_life_days, na.rm = TRUE))) %>%
          pull(metric)
      
      
      return(metric_shelf_life)
    }
    
    avg_shelf_life <- calc_shelf_life_metric(mean)
    min_shelf_life <- calc_shelf_life_metric(min)
    max_shelf_life <- calc_shelf_life_metric(max)
    
    output$avg_shelf_life <- renderValueBox({
        valueBox(value = avg_shelf_life, subtitle = "Average Shelf Life", icon = icon("briefcase-medical"), color = "primary")
    })
    
    output$min_shelf_life <- renderValueBox({
      valueBox(value =  min_shelf_life, subtitle = "Minimum Shelf Life", icon = icon("briefcase-medical"), color = "primary")
    })
    
    output$max_shelf_life <- renderValueBox({
      valueBox(value = max_shelf_life, subtitle = "Maximum Shelf Life", icon = icon("briefcase-medical"), color = "primary")
    })
  })
}
