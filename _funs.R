#=====================================================================#
# File name: _funs.R
# This is code to create: graphs and solutions for ODSC 2022
# Authored by and feedback to: @mjfrigaard
# Last updated: 2022-04-07
# MIT License
# Version: 1.0
#=====================================================================#

library(pagedown)
library(tidyverse)

render_pdf_slides <- function() {
  html_slides <- list.files("docs", full.names = TRUE, pattern = "ggp")
  pdfs_folders <- str_replace_all(html_slides, "docs", "pdfs")
  pdf_paths <- str_replace_all(pdfs_folders, ".html", ".pdf")
  walk2(.x = html_slides, .y = pdf_paths, .f = chrome_print, timeout = 120)
}
# render_pdf_slides()