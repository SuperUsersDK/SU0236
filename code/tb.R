library(reshape2)
library(stringr)

tb_raw <- read.csv("SU0236/datasets/tb.csv", na.string = "")

names(tb_raw)[1] <- "country"
names(tb_raw) <- str_replace(names(tb_raw), "new_sp_", "")

tb_raw$new_sp <- NULL
tb_raw$m04 <- NULL
tb_raw$m514 <- NULL
tb_raw$f04 <- NULL
tb_raw$f514 <- NULL

tb_clean <- melt(tb_raw, id = c("country", "year"), na.rm = TRUE)

names(tb_clean)[3] <- "sex_and_age"
names(tb_clean)[4] <- "cases"

tb_clean$sex <- substring(tb_clean$sex_and_age, 1, 1)
tb_clean$age <- substring(tb_clean$sex_and_age, 2)

tb_clean$sex_and_age <- NULL

tb_clean$country <- as.factor(tb_clean$country)
tb_clean$year <- as.factor(tb_clean$year)
tb_clean$sex <- as.factor(tb_clean$sex)
tb_clean$age <- as.factor(tb_clean$age)

