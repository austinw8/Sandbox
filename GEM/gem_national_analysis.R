library(tidyverse)
library(haven)


# Data Import / Tidying ---------------------------------------------------


standardise_col_names <- function(df) {
  colnames(df) <- tolower(gsub("\\d{2}$", "", colnames(df)))
  return(df)
}

us_2002 <- read_sav("data/APS-National/2002 APS Global National Level Data.sav") |> 
  filter(country == 1) |> 
  mutate(year = 2002) %>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("02", "", colnames(df)))
    df
  }

us_2003 <- read_sav("data/APS-National/2003 APS Global National Level Data.sav") |> 
  filter(country == 1) %>% 
  mutate(year = 2003) %>%
  {
    df <- .  
    colnames(df) <- tolower(gsub("03", "", colnames(df)))
    df  
  }

us_2004 <- read_sav("data/APS-National/2004 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2004) %>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("04", "", colnames(df)))
    df
  }

us_2005 <- read_sav("data/APS-National/2005 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2005)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("05", "", colnames(df)))
    df
  }

us_2006 <- read_sav("data/APS-National/2006 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2006)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("06", "", colnames(df)))
    df
  }

us_2007 <- read_sav("data/APS-National/2007 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2007)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("07", "", colnames(df)))
    df
  }

us_2008 <- read_sav("data/APS-National/2008 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2008)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("08", "", colnames(df)))
    df
  }

us_2009 <- read_sav("data/APS-National/2009 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2009)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("09", "", colnames(df)))
    df
  }

us_2010 <- read_sav("data/APS-National/2010 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2010)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("10", "", colnames(df)))
    df
  }

us_2011 <- read_sav("data/APS-National/2011 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2011)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("11", "", colnames(df)))
    df
  }

us_2012 <- read_sav("data/APS-National/2012 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2012)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("12", "", colnames(df)))
    df
  }

us_2013 <- read_sav("data/APS-National/2013 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2013)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("13", "", colnames(df)))
    df
  }

us_2014 <- read_sav("data/APS-National/2014 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2014)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("14", "", colnames(df)))
    df
  }

us_2015 <- read_sav("data/APS-National/2015 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2015)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("15", "", colnames(df)))
    df
  }

us_2016 <- read_sav("data/APS-National/2016 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2016)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("16", "", colnames(df)))
    df
  }

us_2017 <- read_sav("data/APS-National/2017 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2017)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("17", "", colnames(df)))
    df
  }

us_2018 <- read_sav("data/APS-National/2018 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2018)|> 
  standardise_col_names() |> 
  rename()

us_2019 <- read_sav("data/APS-National/2019 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2019)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("19", "", colnames(df)))
    df
  }

us_2020 <- read_sav("data/APS-National/2020 APS Global National Level Data.sav") |> 
  filter(country == 1)|> 
  mutate(year = 2020)%>%
  {
    df <- . 
    colnames(df) <- tolower(gsub("20", "", colnames(df)))
    df
  }

labels <- lapply(us_2008, function(x) attr(x, "label"))


us_gem_combined <- bind_rows(us_2002, us_2003, us_2004, us_2005, us_2006, us_2007, us_2008, us_2009, 
                             us_2010, us_2011, us_2012, us_2013, us_2014, us_2015, us_2016, us_2017, us_2018, us_2019, 
                             us_2020) |> 
  relocate(year) |> 
  select(where(~ mean(!is.na(.)) >= 0.75),
         -ctryalp, -country)


#--------------------------------------------------------------------


ggplot(us_gem_combined, aes(x = year, y = tea)) +
  geom_line() +
  theme_bw()

ggplot(us_gem_combined) +
  geom_line(aes(x = year, y = teanec), color = "red", linewidth = 1) +
  geom_line(aes(x = year, y = teaopp), color = "blue", linewidth = 1) +
  theme_bw()

ggplot(us_gem_combined) +
  geom_line(aes(x = year, y = teamal), color = "red", linewidth = 1) +
  geom_line(aes(x = year, y = teafem), color = "blue", linewidth = 1) +
  theme_bw()
         