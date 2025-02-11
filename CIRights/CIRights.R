library(tidyverse)
library(readr)
library(readxl)
library(haven)

hr_dat <- read_dta("C:/Users/austi/Downloads/cirights_v2.8.27.23_public.dta_-1 (1)/cirights_v2.8.27.23_public.dta")
hr_dat <- as_tibble(hr_dat)

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

view <- hr_dat_tidy |> 
  distinct(unsubreg)
print(view, n = Inf)
