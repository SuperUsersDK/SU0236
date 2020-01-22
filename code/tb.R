library(reshape2)
library(plyr)
library(stringr)

tb_raw <- read.csv("SU0236/tb.csv", na.string = "")
names(tb_raw)[1] <- "country"
names(tb_raw) <- str_replace(names(tb_raw), "new_sp_", "")

tb_raw$new_sp <- NULL
tb_raw$m04 <- NULL
tb_raw$m514 <- NULL
tb_raw$f04 <- NULL
tb_raw$f514 <- NULL

tb_clean <- melt(tb_raw, id = c("country", "year"), na.rm = TRUE)

names(tb_clean)[3] <- "column"
names(tb_clean)[4] <- "cases"

tb_clean <- arrange(tb_clean, country, column, year)
tb_clean$sex <- str_sub(tb_clean$column, 1, 1)
ages <- c("04" = "0-4", "514", "5-14", "014" = "0-14",
          "1524" = "15-24", "2534" = "25-34", "3544" = "35-44",
          "4554" = "45-54", "5564" = "55-64", "65" = "65+", "u" = NA)
tb_clean$age <- factor(ages[str_sub(tb_clean$column, 2)], levels = ages)

tb_clean <- tb_clean[c("country", "year", "sex", "age", "cases")]

