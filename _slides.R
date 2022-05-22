#=====================================================================#
# File name: _slides.R
# This is code to create: graphs and solutions for graph gallery
# Authored by and feedback to: @mjfrigaard
# Last updated: 2022-03-10
# MIT License
# Version: 1.0
#=====================================================================#

library(pagedown)
library(tidyverse)

# # render 01-amounts -----------------------------------------------------
pagedown::chrome_print('docs/ggp2-amounts.html', output = "pdfs/ggp2-amounts.pdf")
# # render 02-distributions -------------------------------------------------
rmarkdown::render('ggp2-distributions.Rmd',  encoding = 'UTF-8')
# render 03-proportions -------------------------------------------------
rmarkdown::render('ggp2-gallery-03-proportions.Rmd',  encoding = 'UTF-8')
