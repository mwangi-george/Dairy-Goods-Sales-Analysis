pacman::p_load(
  tidyverse, janitor, shiny, bs4Dash, DT, waiter, thematic, shinyWidgets, gt, highcharter, paletteer, ggsci, shinycssloaders
)

button_style <- style <- "color: #fff; background-color: #007FFF; border-color: #007FFF; width: 150px; max-width: 150px; height: 40px; border-radius: 20px; border: 2px solid #007FFF;"

# toast options
toastOpts <- list(
  autohide = TRUE,
  icon = "fas fa-home",
  close = FALSE,
  position = "topRight"
)

sales_df <- as_tibble(data.table::fread("data/dairy_dataset.csv")) %>%
  clean_names() %>%
  mutate(
    production_date = ymd(production_date),
    date = ymd(date), 
    production_year = year(production_date), 
    expiration_date = ymd(expiration_date)
  )


# Modules
modules <- str_c("modules/", list.files("modules/"))
map(modules, ~ source(.x))

# App structure files
app_files <- str_c("app_structure/", list.files("app_structure/"))
map(app_files, ~ source(.x))


ui <- dashboardPage(
  preloader = list(html = tagList(spin_1(), "Loading Data..."), color = "#343a40"),
  header = header,
  sidebar = sidebar,
  controlbar = controlbar,
  body = body,
  footer = footer,
  skin = "light",
  dark = FALSE,
  help = TRUE,
  fullscreen = TRUE,
  scrollToTop = TRUE
)

server <- function(input, output, session) {
  output$user <- renderUser({
    dashboardUser(
      name = "George Mwangi",
      image = "dp.jpg",
      title = a("Data Scientist", href = "https://github.com/mwangi-george", target = "_blank", style = "text-decoration: underline;"),
      subtitle = a("Let's Connect on LinkedIn", href = "https://linkedin.com/in/georgemwangikenya", target = "_blank", style = "text-decoration: underline;")
    )
  })
  a("AI & Data Associate", href = "https://github.com/mwangi-george", target = "_blank", style = "text-decoration: underline;")


  observe({
    input$location

    updatePickerInput(
      session, "locations_4_qty_sold",
      choices = input$location,
      options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
    )
    
    updatePickerInput(
      session, "locations_4_shelf_life_qty_stocked",
      choices = input$location,
      options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
    )
    
    updatePickerInput(
      session, "locations_4_revenue_over_time",
      choices = input$location, selected = input$location[1],
      options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
    )
  })
  

  df <- reactive({
    sales_df %>%
      filter(
        location %in% c(input$location),
        farm_size %in% c(input$farm_size),
        product_name %in% c(input$product_name),
        brand %in% c(input$brand),
        sales_channel %in% c(input$sales_channel),
        storage_condition %in% c(input$storage_condition),
        production_year %in% c(input$production_year)
      )
  })

  observe({
    df()

    summary_stats_hchart_server("summary_hchart_output", data = df())
    summary_stats_table_server("summary_table_output_2", data = df())
    quantity_sold_by_product_server("qty_sold_by_product", data = df())
    total_revenue_by_location_server("revenue_by_location", data = df())
    avg_shelf_life_by_product_server("avg_shelf_life", data = df())
    availability_by_storage_condition_server("availability_by_storage", data = df())
    storage_condition_on_shelf_life_server("storage_condition_on_shelf_life", data = df())
    shelf_life_analysis_over_time_server("shelf_life_over_time", data = df())
    shelf_life_valueboxes_server("shelf_life_metrics", data = df())
    revenue_valueboxes_server("revenue_metrics", data = df())
  })

  observe({
    list(df(), input$locations_4_qty_sold, input$location)

    qty_sold_by_product_sales_channel_location_server("qty_litres_kg_location", data = df(), location_to_plot = input$locations_4_qty_sold)
  })
  
  observe({
    list(df(), input$locations_4_shelf_life_qty_stocked, input$shelf_life_products, input$location)
    
    shelf_life_and_qty_in_stock_server("rship_btw_shelf_qty_stocked", data = df(), location_to_plot = input$locations_4_shelf_life_qty_stocked)
  })

  observe({
    list(df(), input$locations_4_revenue_over_time, input$location)
    
    revenue_over_time_server("revenue_over_time", data = df(), location_to_plot = input$locations_4_revenue_over_time)
  })

  

  observeEvent(input$controlbarToggle, {
    updateControlbar(id = "controlbar")
  })

  observeEvent(input$toggle_card_sidebar, {
    updateBoxSidebar("locations_sidebar")
  })
  
  observeEvent(input$locations_4_shelf_life_qty_stocked_button, {
    updateBoxSidebar("locations_sidebar_shelf_life_2")
  })
  
  observeEvent(input$locations_4_revenue_over_time_toggle, {
    updateBoxSidebar("locations_sidebar_shelf_life")
  })
  
  observeEvent(input$dark_mode, {
    toast(
      title = if (input$dark_mode) "Dark theme on!" else "Light theme on",
      options = list(position = "topRight", class = "bg-warning", autohide = TRUE)
    )
  })
  
  observeEvent(input$sidebarToggle, {
    updateSidebar(id = "sidebar")
  })
  
}

shinyApp(ui, server)