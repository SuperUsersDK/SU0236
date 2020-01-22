# kilde: https://da.wikipedia.org/wiki/Folketingsvalget_2019

Sys.setlocale("LC_ALL", "da_DK.UTF-8")
set.seed(1)

parti_bogstav <- c("A", "B", "C", "D", "E", "F", "I", "K", "O", "P", "V", "Ø", "Å")
parti_navn <- c("Socialdemokratiet",
                "Radikale Venstre",
                "Det Konservative Folkeparti",
                "Nye Borgelige",
                "Klaus Riskær Pedersen",
                "Socialistisk Folkeparti",
                "Liberal Alliance",
                "Kristendemokraterne",
                "Dansk Folkeparti",
                "Stram Kurs",
                "Venstre",
                "Enhedslisten",
                "Alternativet")
pct <- c(25.9, 8.6, 6.6, 2.4, 0.8, 7.7, 2.3, 1.7, 8.7, 1.8, 23.4, 6.9, 3)

mandater <- c(48, 16, 12, 4, 0, 14, 4, 0, 16, 0, 43, 13, 5)
stopifnot(sum(mandater) == 175)


blok <- c("Rød", "Rød", "Blå", "Blå", "Blå", "Rød", "Blå", "Blå", "Blå",
          "Blå", "Blå", "Rød", "Rød")
#ft15 <- data.frame(parti_bogstav, pct, blok)
ft19 <- data.frame(parti_bogstav, pct, blok, mandater)
rownames(ft19) <- parti_navn


hvor_mange <- 600
meningsmåling <- sample(parti_bogstav, hvor_mange, replace = TRUE, prob = pct)
meningsmåling <- factor(meningsmåling, levels = parti_bogstav)
ft19$meningsmåling <- round(table(meningsmåling) / hvor_mange * 100, 1)
ft19$måling_mandater <- round(ft19$meningsmåling * 1.75)

ft19[ft19$måling_mandater < 4,]$måling_mandater <- 0
View(ft19)

sum(ft19[ft19$blok == "Rød",]$pct)
sum(ft19[ft19$blok == "Rød",]$meningsmåling)

