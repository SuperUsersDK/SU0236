# kilde: https://da.wikipedia.org/wiki/Folketingsvalget_2015

Sys.setlocale("LC_ALL", "da_DK.UTF-8")
set.seed(1)

parti_bogstav <- c("A", "B", "C", "F", "I", "K", "O", "V", "Ø", "Å")
parti_navn <- c("Socialdemokratiet",
                "Radikale Venstre",
                "Det Konservative Folkeparti",
                "Socialistisk Folkeparti",
                "Liberal Alliance",
                "Kristendemokraterne",
                "Dansk Folkeparti",
                "Venstre",
                "Enhedslisten",
                "Alternativet")
pct <- c(26.3, 4.6, 3.4, 4.2, 7.5, 0.8, 21.1, 19.5, 7.8, 4.8)
stopifnot(sum(pct) == 100)

mandater <- c(47, 8, 6, 7, 13, 0, 37, 34, 14, 9)
stopifnot(sum(mandater) == 175)


blok <- c("Rød", "Rød", "Blå", "Rød", "Blå", "Blå", "Blå",
          "Blå", "Rød", "Rød")
#ft15 <- data.frame(parti_bogstav, pct, blok)
ft15 <- data.frame(parti_bogstav, pct, blok, mandater)
rownames(ft15) <- parti_navn


hvor_mange <- 100
meningsmåling <- sample(parti_bogstav, hvor_mange, replace = TRUE, prob = pct)
meningsmåling <- factor(meningsmåling, levels = parti_bogstav)
ft15$meningsmåling <- round(table(meningsmåling) / hvor_mange * 100, 1)
ft15$måling_mandater <- round(ft15$meningsmåling * 1.75)

ft15[ft15$måling_mandater < 4,]$måling_mandater <- 0
View(ft15)

sum(ft15[ft15$blok == "Rød",]$pct)
sum(ft15[ft15$blok == "Rød",]$meningsmåling)

