#!/usr/bin/Rscript

# Copyright Mark Niemann-Ross, 2017
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# Description: Originally for lynda.com, Database Clinic, Shakespeare, Problem 4
# Updated to demonstrate tidyverse concepts

# SETUP -------------------------------------------------------------------

library(checkpoint)
checkpoint("2017-12-15")

library(rlang)
library(tidyverse)

# this script assumes the working directory has copies of the db-clinic shakespeare files

# CREATE ------------------------------------------------------------------

### For each line in the Shakespeare text, CREATE a corresponding record in the
#   database. Each record will include the name of the character speaking, the
#   (absolute) line number of the phrase and the phrase itself, trimmed of any
#   leading or following spaces

list.of.characters <- as.vector(readLines("characters.txt"))

saved.speaker <- " "

save.speaker <- function(evaluateThis) {
  saved.speaker <<-switch( evaluateThis,
          Exit = " ",
          saved.speaker
          )
  if (evaluateThis %in% list.of.characters) {
    saved.speaker <<- evaluateThis
    }
  saved.speaker
}

shakespeare.results <-
  readLines("A_Midsummer_Nights_Dream.txt") %>%
  as.tibble() %>%
  mutate("speaker_name" = apply(X = ., MARGIN = 1, FUN = save.speaker)) %>%
  mutate_all(str_trim)
  

# UPDATE ------------------------------------------------------------------

### For each record in the database, search for character names, convert them to
#   UPPERCASE, then UPDATE the record in the database

find_characters_regex <- paste(list.of.characters, collapse = "|")
find_characters_regex <- paste0("(", find_characters_regex, ")")

UC_These_names <- function(lineText) {
  str_replace_all(lineText["value"],
    regex(find_characters_regex, ignore_case = TRUE),
    toupper
  )
}

shakespeare.results <- shakespeare.results %>%
  mutate(
    value = apply(X=., MARGIN = 1, FUN = UC_These_names)
    )


# DELETE ------------------------------------------------------------------


### For each record in the database, DELETE any lines that start with “ENTER” or
#   “EXIT” or “ACT” or “SCENE”

shakespeare.results <- shakespeare.results %>%
  filter(!str_detect(
    value, 
    regex("(^ACT|^ENTER|^EXIT|^SCENE)", ignore_case = TRUE)))


# Complete run ------------------------------------------------------------
shakespeare.results <-
  readLines("A_Midsummer_Nights_Dream.txt") %>%
  as.tibble() %>%
  mutate("speaker_name" = apply(X = ., MARGIN = 1, FUN = save.speaker)) %>%
  mutate_all(str_trim) %>%
  mutate(
    value = apply(X=., MARGIN = 1, FUN = UC_These_names)
  ) %>%  
  filter(!str_detect(
    value, 
    regex("(^ACT|^ENTER|^EXIT|^SCENE)", ignore_case = TRUE)))




