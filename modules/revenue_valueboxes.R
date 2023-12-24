revenue_valueboxes_ui <- function(id) {
  ns <- NS(id)
  tagList(
    valueBoxOutput(ns("avg_revenue"), width = 3),
    valueBoxOutput(ns("min_revenue"), width = 3),
    valueBoxOutput(ns("max_revenue"), width = 3),
    valueBoxOutput(ns("sum_revenue"), width = 3)
  )
}

revenue_valueboxes_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    
    calc_revenue_metric <- function(summary_func) {
      metric_revenue <- 
        data %>%
          summarise(metric = round(summary_func(approx_total_revenue_inr, na.rm = TRUE))) %>%
          pull(metric)
      
      
      return(metric_revenue)
    }
    
    avg_revenue <- calc_revenue_metric(mean)
    min_revenue <- calc_revenue_metric(min)
    max_revenue <- calc_revenue_metric(max)
    sum_revenue <- calc_revenue_metric(sum)
    
    output$avg_revenue <- renderValueBox({
      valueBox(value = format(avg_revenue, big.mark = ", "), subtitle = "Average Revenue (NPR)", icon = icon("rupee-sign"), color = "primary")
    })
    
    output$min_revenue <- renderValueBox({
      valueBox(value =  format(min_revenue, big.mark = ", "), subtitle = "Minimum Revenue (NPR)", icon = icon("rupee-sign"), color = "primary")
    })
    
    output$max_revenue <- renderValueBox({
      valueBox(value = format(max_revenue, big.mark = ", "), subtitle = "Maximum Revenue (NPR)", icon = icon("rupee-sign"), color = "primary")
    })
    
    output$sum_revenue <- renderValueBox({
      valueBox(value = format(sum_revenue, big.mark = ", "), subtitle = "Total Revenue (NPR)", icon = icon("rupee-sign"), color = "primary")
    })
  })
}
