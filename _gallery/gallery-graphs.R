# =====================================================================#
# File name: gallery-graphs.R
# This is code to create: code for graphs in slides
# Authored by and feedback to: @mjfrigaard
# Last updated: 2022-03-28
# MIT License
# Version: 1.3
# =====================================================================#

# PACKAGES --------
library(knitr)
library(tidyverse)
library(fontawesome)
library(ggwaffle)
library(ggpubr)
library(ggrepel)
library(ggridges)
library(ggtern)
library(ggsunburst)
library(ggbeeswarm)
library(ggcorrplot)
library(openintro)
library(ggwaffle)
library(statebins)
library(ggmosaic)
library(treemapify)
library(fivethirtyeight)
library(fivethirtyeightdata)
library(gt)
library(glue)


# Comprehensive Graph Gallery ---
CompGraphGallery <- structure(list(`Graph group` = c(
  "Comparing categories and distributions", 
  "Hierarchies/proportions",
  "Correlations and connections", 
  "Trends and intervals over time",
  "Maps, overlays, and distortions", 
  "Statistical measures"
), `Graph type` = c(
  "Amounts & Distributions", "Part-to-whole relationships", "X–Y relationships", 
  "X–Y relationships", "Geospatial Data", "Uncertainty"
)), class = c("tbl_df", "tbl",
  "data.frame"), 
row.names = c(NA, -6L))

gt_tbl <- CompGraphGallery %>% 
  gt(rowname_col = "Graph group") %>% 
  tab_stubhead(label = "Graph group") %>% 
  tab_header(
    title = "Comprehensive Graph Gallery",
    subtitle = "Graphs by group and type ")



# DATA -----
## penguins -------
penguins <- palmerpenguins::penguins

## movies_data -----
source("../src/create-movie-data.R")
movies_data <- create_movie_data()
movies_data <- filter(movies_data, !is.na(budget)) %>%
  mutate(mpaa = factor(mpaa,
    levels = c("PG", "PG-13", "R")
  ))


# fivethirtyeight -------
source("../src/vcsExtra-datasets-fun.R")
library(fivethirtyeight)
library(fivethirtyeightdata)
datasets538 <- datasets(package = "fivethirtyeight")
datasets538

# AMOUNTS ----
## bar graph ---------------------------------------------------------------
labs_geom_bar <- labs(
  x = "MPAA rating",
  title = "IMDB movie information/user ratings"
)
ggplot(
  data = movies_data,
  aes(x = mpaa)
) +
  geom_bar(aes(fill = mpaa)) +
  labs_geom_bar


## column graph ------------------------------------------------------------
labs_geom_col <- labs(
  x = "MPAA rating",
  y = "Average IMDB user rating",
  title = "IMDB movie information/user ratings"
)
ggplot(
  data = movies_data,
  aes(
    x = mpaa,
    y = rating
  )
) +
  geom_col(aes(fill = mpaa)) +
  labs_geom_col


## stacked bar graph -------------------------------------------------------
labs_geom_bar_stacked <- labs(
  x = "Flipper length (millimeters)",
  title = "Adult foraging penguins"
)
penguins_stacked <- filter(
  penguins,
  !is.na(sex)
)
ggplot(
  data = penguins_stacked,
  aes(
    x = flipper_length_mm,
    fill = sex
  )
) +
  geom_bar() +
  labs_geom_bar_stacked


## stacked-bars-2  ----------------------------------------------------------
geom_bar_stacked_2 <- labs(
  x = "Island in Palmer Archipelago",
  y = "Flipper length (millimeters)",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins,
  aes(
    fill = sex,
    x = island,
    y = flipper_length_mm
  )
) +
  # use this to determine how many
  # sex values are NA (and in what
  # categories)
  geom_bar(
    position = "stack",
    stat = "identity"
  ) +
  geom_bar_stacked_2

## diverging bar graph -------------------------------------------------------
unisex_names <- fivethirtyeight::unisex_names
unisex_names_diff <- mutate(unisex_names,
  male_female_diff = male_share - female_share,
  diff_cat = if_else(male_female_diff > 0,
    true = "More common male name",
    false = "More common female name"
  )
)
sample_names <- slice_sample(unisex_names_diff, n = 10)

labs_geom_bar_diverg <- labs(
  x = "Name",
  y = "Male share - female share",
  title = "Most Common Unisex Names In America",
  fill = "Difference category"
)

ggplot(
  data = sample_names,
  aes(
    x = reorder(
      x = name,
      male_female_diff
    ),
    # reorder this by x
    y = male_female_diff,
    label = diff_cat
  )
) +
  geom_bar(
    aes(fill = diff_cat),
    stat = "identity",
    width = .5
  ) +
  labs_geom_bar_diverg

### diverging bar graph (vertical) ------------------------------------------
unisex_names <- fivethirtyeight::unisex_names
unisex_names_diff <- mutate(unisex_names,
  male_female_diff = male_share - female_share,
  diff_cat = if_else(male_female_diff > 0,
    true = "More common male name",
    false = "More common female name"
  )
)
sample_names <- slice_sample(unisex_names_diff, n = 20)

labs_geom_bar_diverg_vert <- labs(
  x = "Name",
  y = "Male share - female share",
  title = "Most Common Unisex Names In America",
  fill = "Difference category"
)

ggplot(
  data = sample_names,
  aes(
    x = male_female_diff,
    # reorder this by x
    y = reorder(
      x = name,
      male_female_diff
    ),
    label = diff_cat
  )
) +
  geom_bar(
    aes(fill = diff_cat),
    stat = "identity",
    width = .5
  ) +
  labs_geom_bar_diverg_vert


# DISTRIBUTIONS ----
## histograms --------------------------------------------------------------
labs_histogram <- labs(
  x = "Flipper length (millimeters)",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins,
  aes(x = flipper_length_mm)
) +
  geom_histogram() +
  labs_histogram

## frequency polygon ----
labs_freqpoly <- labs(
  x = "Flipper length (millimeters)",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins,
  aes(x = flipper_length_mm)
) +
  geom_freqpoly() +
  labs_freqpoly

## frequency polygon (2) ----
labs_freqpoly_2 <- labs(
  x = "Flipper length (millimeters)",
  color = "Penguins species",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins,
  aes(x = flipper_length_mm)
) +
  geom_freqpoly(
    aes(
      color = species,
      group = species
    )
  ) +
  labs_freqpoly_2

## dot-plot ------
labs_dotplot <- labs(
  x = "Flipper length (millimeters)",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins,
  aes(x = flipper_length_mm)
) +
  geom_dotplot() +
  labs_dotplot

## dotplot (2) -------------------------------------------------------------
penguins_histodot <- filter(penguins, !is.na(sex))
labs_histodot <- labs(
  x = "Flipper length (millimeters)",
  fill = "Sex",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins_histodot,
  aes(
    x = flipper_length_mm,
    fill = factor(sex)
  )
) +
  geom_dotplot(
    stackgroups = TRUE,
    binwidth = 1,
    method = "histodot"
  ) +
  labs_histodot


## beeswarm plot -----------------------------------------------------------
labs_beeswarm <- labs(
  x = "Island in Palmer Archipelago, Antarctica",
  y = "Body mass (grams)",
  color = "Penguin sex (female, male)",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins,
  aes(
    x = island,
    y = body_mass_g,
    color = island
  )
) +
  ggbeeswarm::geom_beeswarm(
    alpha = 1 / 2
  ) +
  labs_beeswarm

## density plot ------------------------------------------------------------
labs_density <- labs(
  x = "Flipper length (millimeters)",
  title = "Adult foraging penguins"
)
ggplot(
  data = penguins,
  aes(x = flipper_length_mm)
) +
  geom_density() +
  labs_density

## density plot (2) ------------------------------------------------------------
labs_density_alpha <- labs(
  x = "Flipper length (millimeters)",
  fill = "Penguin sex (female, male)",
  title = "Adult foraging penguins"
)
# remove missing sex
penguins_density <- filter(penguins, !is.na(sex))
ggplot(
  data = penguins_density,
  aes(
    x = flipper_length_mm,
    fill = sex
  )
) +
  geom_density(alpha = 1 / 3) +
  labs_density_alpha


## ridgeline plots ---------------------------------------------------------
labs_density_ridges <- labs(
  x = "Flipper length (millimeters)",
  y = "Island in Palmer Archipelago, Antarctica",
  title = "Adult foraging penguins"
)
# remove missing island
penguins_density_ridges <- filter(penguins, !is.na(island))
ggplot(
  data = penguins_density_ridges,
  aes(
    x = bill_length_mm,
    y = island,
    fill = island
  )
) +
  # adjust alpha
  ggridges::geom_density_ridges(alpha = 2 / 3) +
  labs_density_ridges


## box-plot  ---------------------------------------------------------------
labs_boxplot <- labs(
  y = "length",
  title = "IMDB Movie information and user ratings"
)
ggplot(
  data = movies_data,
  # place an empty string in the
  # x axis
  aes(
    x = " ",
    # place the length on the y
    y = length
  )
) +
  geom_boxplot() +
  labs_boxplot


## box-plot stats ----------------------------------------------------------
lgnth_skim <- skimr::skim(movies_data$length)
LengthBoxStats <- select(lgnth_skim,
  `25th` = numeric.p25, Median = numeric.p50,
  `75th` = numeric.p75, Histogram = numeric.hist
) %>%
  mutate(IQR = IQR(movies_data$length, na.rm = TRUE)) %>%
  select(`25th`, Median, `75th`, IQR, Histogram)
LengthBoxStats


## box-plot comparisons (patchwork) -----------------------------------------
small_ggp2_theme <- theme(
  axis.ticks.x.bottom = element_blank(),
  axis.text.x = element_blank(),
  axis.title.x.bottom = element_blank(),
  axis.title.x = element_blank(),
  text = element_text(size = 7),
  axis.text = element_text(size = 7),
  axis.title = element_text(size = 7),
  plot.title = element_text(size = 8),
  legend.text = element_text(size = 7),
  legend.title = element_text(size = 7)
)

ggp_point <- ggplot(
  data = movies_data,
  aes(x = " ", y = length)
) +
  geom_point() +
  labs(y = "length", title = "geom_point()") +
  small_ggp2_theme
ggp_box <- ggplot(
  data = movies_data,
  aes(x = " ", y = length)
) +
  geom_boxplot() +
  labs(y = "length", title = "geom_boxplot()") +
  small_ggp2_theme
ggp_freqp <- ggplot(
  data = movies_data,
  aes(x = length)
) +
  geom_freqpoly() +
  coord_flip() +
  labs(x = "length", title = "geom_freqpoly()") +
  small_ggp2_theme
ggp_hist <- ggplot(
  data = movies_data,
  aes(x = length)
) +
  geom_histogram() +
  coord_flip() +
  labs(x = "length", title = "geom_histogram()") +
  small_ggp2_theme
ggp_density <- ggplot(
  data = movies_data,
  aes(x = length)
) +
  geom_density() +
  coord_flip() +
  labs(x = "length", y = " ", title = "geom_density()") +
  small_ggp2_theme
ggp_box <- ggplot(
  data = movies_data,
  aes(x = " ", y = length)
) +
  geom_boxplot() +
  labs(y = "length", title = "geom_boxplot()") +
  small_ggp2_theme
patchwork::wrap_plots(ggp_point, ggp_freqp,
  ggp_hist, ggp_density, ggp_box,
  ncol = 5
)



# HIERARCHIES/PART-TO-WHOLE RELATIONSHIPS ----
## waffle chart  -----------------------------------------------------------
waffle_data <- waffle_iron(mpg, aes_d(group = class))

ggplot(waffle_data, aes(x, y, fill = group)) +
  geom_waffle()

# data
penguins <- palmerpenguins::penguins
penguins <- mutate(penguins, species = as.character(species))
waffle_penguins <- waffle_iron(penguins, aes_d(group = species))

ggplot(waffle_penguins, aes(x, y, fill = group)) +
  geom_waffle()


## mosaic plot  ------------------------------------------------------------
flights <- ggmosaic::fly
glimpse(flights)
ggplot(data = flights) +
  geom_mosaic(aes(
    x = product(do_you_recline, rude_to_recline),
    fill = do_you_recline
  )) +
  labs(title = "f(do_you_recline | rude_to_recline) f(rude_to_recline)")

flying <- fivethirtyeight::flying
flying_mosaic_data <- filter(flying, !is.na(baby) & !is.na(unruly_child))
ggplot(data = flying_mosaic_data) +
  geom_mosaic(aes(
    x = product(unruly_child, baby),
    fill = unruly_child
  )) +
  labs(
    title = "In general...",
    x = "...is it rude to bring a baby on a plane?",
    y = "..is it rude to knowingly bring unruly children on a plane?",
    fill = "Responses"
  ) +
  theme(legend.position = "top")


## treemaps ----------------------------------------------------------------
treemap_penguins <- filter(penguins, !is.na(sex))
treemap_penguins_grouped <- group_by(treemap_penguins, species, island, sex)
treemap_penguins_counts <- ungroup(count(treemap_penguins_grouped, species, island))

labs_treemap <- labs(title = "Species, island, and sex of adult penguins")


### geom_treemap ------
ggplot(treemap_penguins_counts, 
       aes(area = n, 
           fill = sex, 
           label = species,
           subgroup = island)) +
       geom_treemap() + 
       labs_treemap


### geom_treemap_subgroup_border ------
ggplot(treemap_penguins_counts, 
       aes(area = n, 
           fill = sex, 
           label = species,
           subgroup = island)) +
       geom_treemap() + 
       geom_treemap_subgroup_border() + 
       labs_treemap


### geom_treemap_subgroup_text -------
ggplot(treemap_penguins_counts, 
       aes(area = n, 
           fill = sex, 
           label = species,
           subgroup = island)) +
       geom_treemap() + 
       geom_treemap_subgroup_border() +
       geom_treemap_subgroup_text(place = "center", 
                                  grow = TRUE, 
                                  alpha = 0.9, 
                                  color = "white",
                                  fontface = "bold",
                                  family = "sans",
                                  min.size = 0) + 
       labs_treemap


### geom_treemap_text -------
ggplot(treemap_penguins_counts, 
       aes(area = n, 
           fill = sex, 
           label = species,
           subgroup = island)) +
       geom_treemap() + 
       geom_treemap_subgroup_border() +
       geom_treemap_subgroup_text(place = "center", 
                                  grow = TRUE, 
                                  alpha = 0.9, 
                                  color = "white",
                                  fontface = "bold",
                                  family = "sans",
                                  min.size = 0) + 
       geom_treemap_text(colour = "gray90", 
                    place = "center", 
                    alpha = 0.85, 
                    family = "mono",
                    fontface = "italic",
                    reflow = TRUE) + 
       labs_treemap


