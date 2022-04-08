# packages ---------------------------------------------------------------
library(tidyverse)
library(rmarkdown)
library(knitr)

# # render 01-amounts -----------------------------------------------------
rmarkdown::render('ggp2-gallery-01-amounts.Rmd',  encoding = 'UTF-8')
# # render 02-distributions -------------------------------------------------
rmarkdown::render('ggp2-gallery-02-distributions.Rmd',  encoding = 'UTF-8')
# render 03-proportions -------------------------------------------------
rmarkdown::render('ggp2-gallery-03-proportions.Rmd',  encoding = 'UTF-8')
# render 04-xy-relationships -------------------------------------------------
rmarkdown::render('ggp2-gallery-04-xy-relationships.Rmd',  encoding = 'UTF-8')
# render 05-geospatial-data -------------------------------------------------
rmarkdown::render('ggp2-gallery-05-geospatial-data.Rmd',  encoding = 'UTF-8')
# render 06-uncertainty -------------------------------------------------
rmarkdown::render('ggp2-gallery-06-uncertainty.Rmd',  encoding = 'UTF-8')
# # render ggp2-graph-gallery ---------------------------------------------
# rmarkdown::render('ggp2-graph-gallery.Rmd',  encoding = 'UTF-8')

# UNLINK CACHE --------------------------------------------------------------
unlink("ggp2-gallery-01-amounts_cache/", recursive = TRUE, force = TRUE)
unlink("ggp2-gallery-02-distributions_cache/", recursive = TRUE, force = TRUE)
unlink("ggp2-gallery-03-proportions_cache/", recursive = TRUE, force = TRUE)
unlink("ggp2-gallery-04-xy-relationships_cache/", recursive = TRUE, force = TRUE)
unlink("ggp2-gallery-05-geospatial-data_cache/", recursive = TRUE, force = TRUE)
unlink("ggp2-gallery-06-uncertainty_cache/", recursive = TRUE, force = TRUE)
# unlink("ggp2-graph-gallery_cache/", recursive = TRUE, force = TRUE)

# PDF slides --------------------------------------------------------------
# html_slides <- list.files(".", pattern = ".html")
# pdf_slides <- str_replace(html_slides,
#   pattern = ".html",
#   replacement = ".pdf")
# pdf_slides <- paste0("pdfs/", pdf_slides)
# print_files <- tibble("pdfs" = pdf_slides,
#   "htmls" = html_slides)
# # print_files$pdfs[12]
# # print_files$htmls[12]
# pagedown::chrome_print(input = print_files$htmls[12], 
#                        output = print_files$pdfs[12], timeout = 120)