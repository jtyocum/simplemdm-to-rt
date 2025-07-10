library(here)
library(tidyverse)

simplemdm <- read_csv(here("data/input/simplemdm_export.csv"))

simplemdm_cleaned <- simplemdm %>%
  filter(`Group: DEOHS Standard Installation` == TRUE | `Group: DEOHS Standard No Filevault` == TRUE | `Group: EPI Standard Deployment` == TRUE) %>%
  select(`SimpleMDM Name`,`Model`,`Product type`,`Serial number`,`assigned_user`) %>%
  rename(name = `SimpleMDM Name`, model = `Model`, type = `Product type`, serial = `Serial number`, user = `assigned_user`) %>%
  mutate(name = str_remove(name, '.clients.uw.edu')) %>%
  mutate(type = str_replace(type, 'MacBook.*', 'Laptop')) %>%
  mutate(type = str_replace(type, 'iMac.*', 'Desktop / Workstation')) %>%
  mutate(type = str_replace(type, 'Mac mini.*', 'Desktop / Workstation')) %>%
  mutate(make = 'Apple')

write_csv(simplemdm_cleaned, here("data/output/simplemdm_cleaned.csv"))