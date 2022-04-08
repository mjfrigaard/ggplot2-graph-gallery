#=====================================================================#
# File name: _slides.R
# This is code to create: graphs and solutions for ODSC 2022
# Authored by and feedback to: @mjfrigaard
# Last updated: 2022-03-10
# MIT License
# Version: 1.0
#=====================================================================#

library(pagedown)
library(tidyverse)

# # render 01-amounts -----------------------------------------------------
rmarkdown::render('ggp2-gallery-01-amounts.Rmd',  encoding = 'UTF-8')
# # render 02-distributions -------------------------------------------------
rmarkdown::render('ggp2-gallery-02-distributions.Rmd',  encoding = 'UTF-8')
# render 03-proportions -------------------------------------------------
rmarkdown::render('ggp2-gallery-03-proportions.Rmd',  encoding = 'UTF-8')




#  # # render 01 - amounts -----------------------------------------------------
#  rmarkdown::render('ggp2-gallery-01-amounts.Rmd',  encoding = 'UTF-8')
# 
# # # render 02-distributions -------------------------------------------------
#  rmarkdown::render('ggp2-gallery-02-distributions.Rmd',  encoding = 'UTF-8')
# 
# # render 03-proportions -------------------------------------------------
# rmarkdown::render('ggp2-gallery-03-proportions.Rmd',  encoding = 'UTF-8')

 
# graphs_1_9 <- paste0(rep("graph-0", times = 9), 1:9, ".R")
# graphs_10_19 <- paste0(rep("graph-", times = 9), 10:19, ".R")
# graph_files <- paste0("graphs/", c(graphs_1_9, graphs_10_19))
# purrr::map(.x = graph_files, .f = fs::file_create)
# purrr::map2(.x = "_headers.R", .y = graph_files,
#             .f = fs::file_copy, overwrite = TRUE)
# 
# sols_1_9 <- paste0(rep("solution-0", times = 9), 1:9, ".R")
# sols_10_19 <- paste0(rep("solution-", times = 9), 10:19, ".R")
# sols_files <- paste0("solutions/", c(sols_1_9, sols_10_19))
# purrr::map(.x = sols_files, .f = fs::file_create)
# purrr::map2(.x = "_headers.R", .y = sols_files,
#             .f = fs::file_copy, overwrite = TRUE)