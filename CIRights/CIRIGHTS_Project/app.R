#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#


# Setup -------------------------------------------------------------------
library(shiny)
library(tidyverse)
library(readr)
library(readxl)
library(haven)
library(leaflet)
library(rnaturalearth)
library(rnaturalearthdata)
library(bslib)

# Import ------------------------------------------------------------------
hr_dat <- read_dta("C:/Users/austi/Downloads/cirights_v2.8.27.23_public.dta_-1 (1)/cirights_v2.8.27.23_public.dta")

world <- ne_countries() |> 
  filter(admin != "Antarctica") |> 
  select(name_ciawf, geometry) |> 
  rename(country = "name_ciawf")


# Tidy --------------------------------------------------------------------
hr_dat_tidy <- hr_dat |> 
  mutate(unreg = case_when(
    unreg == "2" ~ "Africa",
    unreg == "9" ~ "Oceania",
    unreg == "21" ~ "North America",
    unreg == "142" ~ "Asia",
    unreg == "150" ~ "Europe",
    unreg == "419" ~ "Latin America and the Caribbean"
  )) |> 
  mutate(unsubreg = case_when(
    unsubreg == "5" ~ "South America",
    unsubreg == "11" ~ "Western Africa",
    unsubreg == "13" ~ "Central America",
    unsubreg == "14" ~ "Eastern Africa",
    unsubreg == "15" ~ "Northern Africa",
    unsubreg == "17" ~ "Middle Africa",
    unsubreg == "18" ~ "Southern Africa",
    unsubreg == "21" ~ "Northern America",
    unsubreg == "29" ~ "Caribbean",
    unsubreg == "30" ~ "Eastern Asia",
    unsubreg == "35" ~ "South-eastern Asia",
    unsubreg == "39" ~ "Southern Europe",
    unsubreg == "53" ~ "Australia and New Zealand",
    unsubreg == "54" ~ "Melanesia",
    unsubreg == "57" ~ "Micronesia",
    unsubreg == "61" ~ "Polynesia",
    unsubreg == "145" ~ "Western Asia",
    unsubreg == "151" ~ "Eastern Europe",
    unsubreg == "154" ~ "Northern Europe",
    unsubreg == "155" ~ "Western Europe",
  )) |> 
  mutate(unsubreg = case_when(
    country %in% c("Afghanistan", "Maldives", "Pakistan", "Sri Lanka", "Bangladesh", "Nepal", "Bhutan", "Iran", "India") ~ "Southern Asia",
    country %in% c("Uzbekistan", "Kyrgyz Republic", "Turkmenistan", "Kazakhstan", "Tajikistan") ~ "Central Asia",
    TRUE ~ unsubreg
  )) |> 
  select(-ciri, -cow, -polity, -unctry)

hr_dat_tidy <- world |> 
  left_join(hr_dat_tidy, by = "country")


# UI ----------------------------------------------------------------------

ui <- page_sidebar(
  title = "CIRIGHTS Project",
  sidebar = sidebar(
    list(
      selectInput("country", "Select Country:",
                  choices = c("All", unique(hr_dat_tidy$country)),
                  selected = "All"),
      selectInput("year", "Select Year:",
                  choices = unique(hr_dat_tidy$year),
                  selected = 2021)
    )),
  layout_columns(
    card(card_header("Human Rights Map"),
         leafletOutput("map"))
    )
  )
  

# Server ------------------------------------------------------------------

server <- function(input, output, session) {
  
  observe({
    filtered_data <- hr_dat_tidy |> 
      filter(year == input$year)
    
    if (input$country != "All") {
      filtered_data <- filtered_data |> 
        filter(country == input$country)
    }
    
    col_pal <- colorBin(
      palette = c("#67001F", "#B2182B", "#D6604D", "#F4A582", "#FDDBC7", "#D1E5F0", "#92C5DE", "#4393C3", "#2166AC", "#053061"),
      domain = hr_dat_tidy$human_rights_score,
      bins = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100),
      na.color = "grey"
    )
    
    output$map <- renderLeaflet({
      leaflet(data = hr_dat_tidy) |> 
        addTiles(options = tileOptions(noWrap = TRUE)) |>
        setView(lng = 0, lat = 0, zoom = 1) |> 
        addPolygons(
          fillColor = ~col_pal(human_rights_score),
          weight = 1,
          opacity = 1,
          color = "white",
          fillOpacity = 0.7,
          highlight = highlightOptions(
            weight = 2,
            color = "blue",
            fillOpacity = 0.7,
            bringToFront = TRUE)
        ) |> 
        addLegend(
          pal = col_pal,
          values = ~human_rights_score,
          opacity = 0.7,
          title = "Human Rights Score",
          position = "bottomright"
        )
    })
  })
}

# Run App -----------------------------------------------------------------
shinyApp(ui = ui, server = server)