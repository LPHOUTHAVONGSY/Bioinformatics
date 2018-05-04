# BIF705
# Lab 9
# 21 March 2018

# This R script is based on the tutorial from: http://www.r-bloggers.com/genetic-algorithms-a-simple-r-example/
# Some of the packages have been updated since the tutorial was posted, therefore some commands no longer exist.
# This R script has the adjusted code so that you can reproduce the output.

install.packages(c("genalg","ggplot2"))
library(genalg)
library(ggplot2)

dataset <- data.frame(item = c("DeRozan", "Lowry", "Ibaka", "Valanciunas", "Wright", "Siakam", "VanVleet"), survivalpoints = c(25, 25, 10, 20, 5, 15, 15), weight = c(20, 20, 10, 15, 15, 5, 5))
weightlimit <- 50

chromosome = c(1, 0, 0, 1, 1, 0, 0)
dataset[chromosome == 1, ]
cat(chromosome %*% dataset$survivalpoints)

evalFunc <- function(x) {
	current_solution_survivalpoints <- x %*% dataset$survivalpoints
	current_solution_weight <- x %*% dataset$weight
		if (current_solution_weight > weightlimit) 
			return(0) else return(-current_solution_survivalpoints)
}

iter = 100
GAmodel <- rbga.bin(size = 7, popSize = 200, iters = iter, mutationChance = 0.01, elitism = T, evalFunc = evalFunc)
cat(summary(GAmodel))

solution = c(1, 1, 1, 1, 1, 0, 1)
dataset[solution == 1, ]

cat(paste(solution %*% dataset$survivalpoints, "/", sum(dataset$survivalpoints)))

# For creating the animation, I suggest creating a folder and navigating to that folder so that all plots are saved there (you will generate 100 plots)

# Ignore warning when executing below code: "geom_path: Each group consists of only one observation. Do you need to adjust the group aesthetic?" i.e., you don't need to type any response to the question; just let the commands execute in the background.

plotlist<-list()
for (i in seq(1, iter)) {
	temp <- data.frame(Generation = c(seq(1, i), seq(1, i)), Variable = c(rep("mean", i), rep("best", i)), Survivalpoints = c(-GAmodel$mean[1:i], -GAmodel$best[1:i]))
	p = ggplot(temp, aes(x = Generation, y = Survivalpoints, group = Variable, colour = Variable)) + geom_line() + scale_x_continuous(limits = c(0, iter)) + scale_y_continuous(limits = c(0, 110)) + geom_hline(aes(yintercept=max(temp$Survivalpoints)), lty = 2) + annotate("text", x = 1, y = max(temp$Survivalpoints) + 2, hjust = 0, size = 3, color = "black", label = paste("Best solution:", max(temp$Survivalpoints))) + scale_colour_brewer(palette = "Set1")
	plotlist[[i]]<-p
}

for (i in seq(1, iter)) {
	filename<-paste("Rplot",i,".png",sep="")
	png(filename)
	print(plotlist[[i]])
	dev.off()
}

# go to: https://imgflip.com/images-to-gif and upload all png files in your respective folder to create animation