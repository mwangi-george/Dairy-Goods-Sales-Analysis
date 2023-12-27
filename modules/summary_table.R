summary_stats_table_ui <- function(id) {
  ns <- NS(id)
  tagList(
    gt_output(ns("summary_table")) %>% withSpinner(type = 4, size = .5)
  )
}

summary_stats_table_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    library(paletteer)

    summary_df <- reactive({
      data %>%
        group_by(location) %>%
        summarise(
          `Average Land Area (Acres)` = mean(total_land_area_acres, na.rm = T),
          `Average Cow population` = mean(number_of_cows, na.rm = T),
          `Total Revenue (INR)` = sum(approx_total_revenue_inr)
        ) %>%
        arrange(desc(`Average Land Area (Acres)`))
    })

    output$download_summary_stats_df <- downloadHandler(
      filename = function() {
        paste("Summary-Data-", Sys.time(), ".csv", sep = "")
      },
      content = function(file) {
        write.csv(summary_df(), file)
      }
    )

    if (nrow(summary_df()) != 0) {
      output$summary_table <- render_gt({
        summary_df() %>%
          gt() %>%
          tab_header(
            title = "Does more land area and cow population translate to more revenue?",
            subtitle = "Well, not always, toggle the controlbar, choose all locations and see the results"
          ) %>%
          tab_options(
            table.width = pct(100),
            ihtml.active = TRUE,
            column_labels.font.size = "11px",
            ihtml.use_text_wrapping = TRUE,
            ihtml.use_pagination = FALSE,
            ihtml.use_pagination_info = TRUE,
            ihtml.use_search = FALSE,
            container.height = 490,
            container.overflow.x = TRUE,
            container.overflow.y = TRUE,
            ihtml.use_compact_mode = TRUE,
            table.layout = "auto"
          ) %>%
          fmt_number(
            columns = 2:4,
            decimals = 0, sep_mark = ", "
          ) %>%
          data_color(
            columns = 2:last_col(),
            method = "numeric",
            palette = "ggsci::blue_material"
          )
      })
    } else {
      output$summary_table <- render_gt({NULL})
    }
  })
}