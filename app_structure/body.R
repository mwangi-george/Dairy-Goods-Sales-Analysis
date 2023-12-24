summary_stats_tab <- tabItem(
  tabName = "summary_statistics",
  fluidRow(
    box(
      title = "Revenue Analysis",
      width = 5,
      height = 550,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      div(
        summary_stats_hchart_ui("summary_hchart_output"),
      )
    ),
    box(
      title = "A deeper look",
      width = 7,
      height = 550,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      dropdownMenu = boxDropdown(
        fluidRow(downloadButton("download_summary_stats_df", "Download", style = "background-color: #007FFF; width: 80%; padding: 0px; border-radius: 5px; margin: auto;"))
      ),
      div(
        summary_stats_table_ui("summary_table_output_2"),
      )
    )
  )
)

qty_sold_by_product_sales_channel_location_tab <- tabItem(
  tabName = "customer_prefrences",
  fluidRow(
    box(
      title = "Customer Location Analysis",
      width = 12,
      height = 610,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      sidebar = boxSidebar(
        startOpen = FALSE,
        id = "locations_sidebar",
        width = 25,
        background = "#00356B",
        pickerInput("locations_4_qty_sold", "Choose Location", choices = "", multiple = F, width = "97%", choicesOpt = list(style = "margin: auto"))
      ),
      actionButton("toggle_card_sidebar", "Show Locations", style = button_style),
      qty_sold_by_product_sales_channel_location_ui("qty_litres_kg_location")
    )
  )
)

sales_vs_revenu_tab <- tabItem(
  tabName = "reveune_details",
  fluidRow(
    box(
      title = "Use the Controlbar to Choose Specific Locations",
      width = 12,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      fluidRow(revenue_valueboxes_ui("revenue_metrics"))
    )
  ),
  fluidRow(
    box(
      title = "Sales Analysis",
      width = 6,
      height = 400,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      quantity_sold_by_product_ui("qty_sold_by_product")
    ),
    box(
      title = "Revenue Analysis",
      width = 6,
      height = 400,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      total_revenue_by_location_ui("revenue_by_location")
    )
  )
)

time_series_analysis <- tabItem(
  tabName = "time_series_revenue",
  fluidRow(
    box(
      title = "Time Series Analysis",
      width = 12,
      height = 610,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      sidebar = boxSidebar(
        startOpen = FALSE,
        id = "locations_sidebar_shelf_life",
        width = 25,
        background = "#00356B",
        pickerInput("locations_4_revenue_over_time", "Choose Location", choices = "", multiple = TRUE, width = "97%", choicesOpt = list(style = "margin: auto")),
      ),
      actionButton("locations_4_revenue_over_time_toggle", "Show Locations", style = button_style),
      revenue_over_time_ui("revenue_over_time")
    )
  )
)




shelf_life_analysis <- tabItem(
  tabName = "shelf_life_analysis",
  fluidRow(
    shelf_life_valueboxes_ui("shelf_life_metrics")
  ),
  fluidRow(
    box(
      title = "Shelf Life Analysis",
      width = 6,
      height = 400,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      avg_shelf_life_by_product_ui("avg_shelf_life")
    ),
    box(
      title = "Availability Analysis",
      width = 6,
      height = 400,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      availability_by_storage_condition_ui("availability_by_storage")
    ),
    box(
      title = "Storage Condition Analysis",
      width = 12,
      height = 400,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      storage_condition_on_shelf_life_ui("storage_condition_on_shelf_life")
    )
  )
)

shelf_life_analysis_over_time <- tabItem(
  tabName = "time_series_shelf_life",
  fluidRow(
    box(
      title = "Time Series Analysis",
      width = 12,
      height = 380,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      shelf_life_analysis_over_time_ui("shelf_life_over_time")
    ),
    box(
      title = "Shelf Life and Quantity in Stock",
      width = 12,
      height = 400,
      maximizable = TRUE,
      solidHeader = FALSE,
      status = "primary",
      sidebar = boxSidebar(
        startOpen = FALSE,
        id = "locations_sidebar_shelf_life_2",
        width = 25,
        background = "#00356B",
        pickerInput("locations_4_shelf_life_qty_stocked", "Choose Location", choices = "", multiple = F, width = "97%", choicesOpt = list(style = "margin: auto")),
      ),
      actionButton("locations_4_shelf_life_qty_stocked_button", "Show Locations", style = button_style),
      shelf_life_and_qty_in_stock_ui("rship_btw_shelf_qty_stocked")
    )
    
  )
)

app_description <- tabItem(
  tabName = "description",
  userBox(
    width = 12,
    title = userDescription(
      image = "dp.jpg",
      title = "George Mwangi",
      subtitle = "Dashboard Description"
    ),
    collapsible = FALSE,
    ribbon(
      text = "Shiny Dev",
      color = "fuchsia"
    ),
    status = "primary",
    elevation = 4,
    app_description
  )
)

body <- dashboardBody(
  tabItems(
    qty_sold_by_product_sales_channel_location_tab,
    sales_vs_revenu_tab,
    summary_stats_tab,
    time_series_analysis,
    shelf_life_analysis,
    shelf_life_analysis_over_time,
    app_description
  )
)