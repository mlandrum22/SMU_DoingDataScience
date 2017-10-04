data_science_skill<-c('Computer Programming', "Math", "Statistics", "Machine Learning", "Domain Expertise", "Communications", "Presentation Skills", "Data Vizulation")
data_science_skill_rank<-c(3.5, 2.5, 2, 1,4,4,3,3)
data_science_profile<-data.frame(data_science_skill,data_science_skill_rank, stringsAsFactors = FALSE)
data_science_profile
barplot(data_science_profile$data_science_skill_rank,
        names.arg = data_science_profile$data_science_skill,
        cex.names = .5, ylab = "Rank - Self Assessment",
        main="Data Science Skill - Self Assessment"
        )
?barplot

#REORDER VALUES

df <- data_science_profile[order(data_science_profile$data_science_skill_rank,decreasing = TRUE),]
barplot(df$data_science_skill_rank,
        names.arg = df$data_science_skill,
        cex.names = .465, ylab = "Rank",
        main="Data Science Skill - Self Assessment"
)
