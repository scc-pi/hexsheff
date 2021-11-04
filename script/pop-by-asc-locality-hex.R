# HEADER ---------------------
# Description: Total population by ASC locality hexagons
# Author: Laurie Platt

# SETUP ----------------------------------
library(tidyverse); library(geojsonio)
library(broom); library(rgeos) #TODO: rgeos being retired
library(viridis); library(scales); library(ggrepel)

# Disable use of scientific notation
options(scipen=999)

# READ ------------------------------------

# Read the hexagon descriptions
hex <- geojson_read("data/lac-asc-hex.geojson", what="sp")

# Read the data we want to plot by hexagon
df_total_pop_by_lac <- read_rds(file = "data/df_total_pop_by_lac.rds")

# TRANSFORM ------------------------------

# Fortify the hexagons for ggplot
hex_fortified <- tidy(hex, region = "ca_number") %>% 
  mutate(id = as.integer(id))

# Join the hexagons to the data we want to plot 
hex_fortified <- hex_fortified %>% 
  left_join(df_total_pop_by_lac, by=c("id"="ca_number"), all.y=TRUE)

# Get hex centres and join to data we're plotting
hex_centres <- cbind.data.frame(data.frame(gCentroid(hex, byid=TRUE), 
                                       id=hex@data$ca_number)) %>%
  left_join(df_total_pop_by_lac, by=c("id"="ca_number"))

# PLOT -------------------------------------

(hex_plot <- ggplot() +
  geom_polygon(data = hex_fortified, aes(x = long, y = lat, group = group, 
               fill = `Total population`), colour = "white") +
  coord_fixed() + 
  theme_void() +
  theme(legend.position = c(0.05, 0.7),
        legend.title = element_text(size = 9),
        legend.text = element_text(size = 8)) +
  geom_text_repel(data = hex_centres, size = 3.5, force = 0, 
                  bg.color = "white", bg.r = 0.15,
                  aes(x, y, 
                      label = 
                        str_c(comma(get('Total population')), "\n", 
                              asc_name, "\n(",
                              ca_name, ")"))) +
  scale_fill_viridis(discrete = FALSE,
                     name = "Total population",
                     direction = -1,
                     labels = function(x) comma(x),
                     guide = guide_colourbar(
                       direction = "horizontal",
                       barheight = unit(2, units = "mm"),
                       barwidth = unit(50, units = "mm"),
                       draw.ulim = F,
                       title.position = 'top',
                       title.hjust = 0.5,
                       label.hjust = 0.5)))

# WRITE ------------------------------------

ggsave("plot/pop-by-asc-locality-hex.png")
  