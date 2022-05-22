# create a smaller version of movie data
library(ggplot2movies)
library(tidyverse)

create_movie_data <- function() {
  movies <- ggplot2movies::movies
    MovieData <- movies %>%
        dplyr::filter(year > 2000 & mpaa != "") %>%
        tidyr::pivot_longer(cols = c(Action:Short),
                     names_to = "genre_key",
                     values_to = "genre_value") %>%
        dplyr::select(title:rating, mpaa, genre_key, genre_value) %>%
        dplyr::filter(genre_value == 1) %>%
        dplyr::mutate(
            genre_value = case_when(
                genre_key == 'Action' ~ "action",
                genre_key == 'Animation' ~ "animation",
                genre_key == 'Comedy' ~ "comedy",
                genre_key == 'Drama' ~ "drama",
                genre_key == 'Documentary' ~ "documentary",
                genre_key == 'Romance' ~ "romance",
                genre_key == 'Short' ~ "short",
                TRUE ~ NA_character_)) %>%
        tidyr::pivot_wider(names_from = genre_key,
                    values_from = genre_value) %>%
        tidyr::unite(col = "genres",
                     Action:Short,
                     sep = ", ") %>%
        dplyr::mutate(
            genres = str_remove_all(string = genres, pattern = "NA, "),
            genres = str_remove_all(string = genres, pattern = ", NA"))
    return(MovieData)
}
