filter_data <- read.csv("../data/new_data/filter_data.csv", sep = "\t", as.is = T)
income <- read.csv("../data/new_data/income.csv", as.is = T)
theatre <- read.csv("../data/theatre_count.csv", as.is = T)
theatre <- theatre[,c("zipcode", "count")]
names(theatre)[2] <- "Theatre"

new_filter <- merge(filter_data, income, by = "zipcode")
new_filter <- merge(new_filter, theatre, all.x = TRUE, by = "zipcode")
new_filter$income_rank <- rank(-as.numeric(new_filter$Median_income))
new_filter$class_1 <- 0
new_filter$class_2 <- 0
new_filter$class_3 <- 0
new_filter$class_4 <- 0
new_filter$class_1[new_filter$income_rank < 9] <- 1
new_filter$class_2[new_filter$income_rank < 25 & new_filter$income_rank >= 9] <- 1
new_filter$class_3[new_filter$income_rank <= 31 & new_filter$income_rank >= 25] <- 1
new_filter$class_4[new_filter$income_rank > 31 ] <- 1

new_filter[,2:11] <- round(new_filter[,2:11], 0)
new_filter[,12:21] <- round(new_filter[,12:21], 2)
new_filter[,30] <- round(new_filter[,30], 0)
new_filter[,32] <- round(new_filter[,32], 2)
new_filter[,37] <- round(new_filter[,37], 1)

write.csv(new_filter, file = "../output/filter_data_used.csv", row.names = FALSE)