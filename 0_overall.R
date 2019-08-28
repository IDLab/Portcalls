#### Overall script for 'portcalls', containing calls to all scripts in correct running order ####


### 1 - reading and cleaning ###

## Read csv-files, do some basic formatting and save as Rda-file
#source("Scripts/1a_reading_portcalls.R", echo=TRUE)

## Clean up the raw Rda-file
source("Scripts/1b_cleaning_portcalls.R", echo=TRUE)

## Pre-process data for analysis
source("Scripts/1c_preproc_portcalls.R", echo=TRUE)


### 2 - analysis ###

## Exploratory
#rmarkdown::render("Scripts/2_analysis_portcalls.Rmd")


### 3 - presentation ###
