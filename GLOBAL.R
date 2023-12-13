pacman::p_load(
  tidyverse, bs4Dash, janitor, shiny, leaflet
)


dairy_df <- read_csv("data/dairy_dataset.csv", show_col_types = F) %>% clean_names()

source("AppFiles/sidebar.R")
source("AppFiles/header.R")
source("AppFiles/tab_items.R")
