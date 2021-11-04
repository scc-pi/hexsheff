# HEADER ---------------------
# Description:  Prepare some data for hexmap testing
#               i.e. Total population by LAC/ASC locality
# Author: Laurie Platt

# SETUP ---------------------
library(tidyverse); library(readxl)

# LOCAL VARIABLES ---------------------

# Location of data we're using for maps
data_folder <- str_c(
  "S:/Public Health/Policy Performance Communications/Business Intelligence/",
  "Projects/AdultSocialCare/ASC_SNA/demographics/data")

# Name of the spreadsheet with SLI indicators for different area types
sli_areas_file <- "sli_areas.xlsx"

# Name of the spreadsheet ASC locality and LAC cross references
asc_lac_xref_file <- "asc_lac_xref.xlsx"

# Get the ASC locality and LAC cross references 
df_asc_lac_xref <- read_excel(str_c(data_folder, "/", asc_lac_xref_file))


# READ & TRANSFORM ---------------------

# Total by LAC/ASC locality
df_total_pop_by_lac <- read_excel(str_c(data_folder, "/", sli_areas_file), 
                           sheet = "ASC") %>% 
  rename(asc_locality = area) %>% 
  select(asc_locality, `Total population`) %>% 
  left_join(df_asc_lac_xref, by = c("asc_locality" = "asc_name")) %>% 
  select(ca_number, asc_number, ca_name, asc_name = asc_locality, 
         `Total population`)

# WRITE ---------------------

# Save as .rds file
write_rds(df_total_pop_by_lac, file = "data/df_total_pop_by_lac.rds")