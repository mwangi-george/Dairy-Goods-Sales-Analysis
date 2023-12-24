controlbar <- dashboardControlbar(
  id = "controlbar",
  skin = "light",
  pinned = FALSE,
  overlay = TRUE,
  controlbarMenu(
    id = "controlbarMenu",
    type = "tabs",
    controlbarItem(
      "Inputs",
      column(
        width = 12,
        align = "center",
        pickerInput(
          "location", "Locations",
          multiple = TRUE, choices = sales_df %>% distinct(location) %>% pull(location),
          selected = sales_df %>% distinct(location) %>% pull(location),
          options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
        ),
        pickerInput(
          "farm_size", "Farm Size",
          multiple = TRUE, choices = sales_df %>% distinct(farm_size) %>% pull(farm_size),
          selected = sales_df %>% distinct(farm_size) %>% pull(farm_size),
          options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
        ),
        pickerInput(
          "product_name", "Product Name",
          multiple = TRUE, choices = sales_df %>% distinct(product_name) %>% pull(product_name),
          selected = sales_df %>% distinct(product_name) %>% pull(product_name),
          options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
        ),
        pickerInput(
          "brand", "Brand",
          multiple = TRUE, choices = sales_df %>% distinct(brand) %>% pull(brand),
          selected = sales_df %>% distinct(brand) %>% pull(brand),
          options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
        ),
        pickerInput(
          "sales_channel", "Sales Channel",
          multiple = TRUE, choices = sales_df %>% distinct(sales_channel) %>% pull(sales_channel),
          selected = sales_df %>% distinct(sales_channel) %>% pull(sales_channel),
          options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
        ),
        pickerInput(
          "storage_condition", "Storage Condition",
          multiple = TRUE, choices = sales_df %>% distinct(storage_condition) %>% pull(storage_condition),
          selected = sales_df %>% distinct(storage_condition) %>% pull(storage_condition),
          options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
        ),
        pickerInput(
          "production_year", "Production Year", multiple = TRUE, 
          choices = sales_df %>% distinct(production_year) %>% arrange(production_year) %>% pull(production_year),
          selected = sales_df %>% distinct(production_year) %>% arrange(production_year) %>% pull(production_year),
          options = list(`live-search` = TRUE, `selected-text-format` = "count > 1", `actions-box` = TRUE)
        )
      )
    ),
    controlbarItem(
      "Skin",
      skinSelector()
    )
  )
)