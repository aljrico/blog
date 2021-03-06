# 8-Queen Problem using a Genetic Algorithm ---------------------------------------------------------
# Killing Half of the Population model
# Author: Alejandro Jiménez Rico <aljrico@gmail.com>

# Load functions
source("genetic_functions.R")
library(ggplot2)
library(viridis)

# Define Variables --------------------------------------------------------

# Number of toddlers by couple
noff <- 4

# Magnitude of the Problem
nproblem <- 13

# Probability of mutation
pmut <- 0.1

# Mortality
mort <- 0.45

# List to be filled
offspring <- list()
population <- list()

# Arrays to be filled
son <- c()
subject <- c()
fitness <- c()
av.fitness <- c()
max.fitness <- c()

# Count Variables
b <- 0
ind <- 0

# Initial Population ------------------------------------------------------
ipop <- (nproblem)^2*2
for(i in 1:ipop){
	population[[i]] <- sample(seq(1:nproblem))
}

# Reproduction ---------------------------------------------------

repeat{
	m <- 1
	ind <- ind + length(population)
	while(length(population)>1){
		# Selecting parents from population
		par1 <- population[[1]]; population <- population[-1]
		par2 <- population[[1]]; population <- population[-1]

		# Measuring fitness of every child
		for (i in 1:noff){
			offspring[[m]] <- gen.offspring(par1,par2,noff,pmut)[[i]]
			subject <- offspring[[m]]
			fitness[m] <- (1/(1+meas.error(subject)))
			m <- m+1
		}
	}

	# Performance measures
	av.fitness <- append(av.fitness, mean(fitness))
	max.fitness <- append(max.fitness, max(fitness))

	# Get the most fittest individual
	bestguy <- offspring[max(fitness,index.return=TRUE)]
	if (max(fitness) == 1) {
		print <- 'SUCCESS!'
		break
	}

	# Kill all parents
	population <- list()
	rm(par1,par2)

	# Populating the new world
	a <- round(length(offspring)*(1-mort)*0.5)*2
	k <- 1
	while (length(offspring) != 0){
		population[[k]] <- offspring[[max(fitness,index.return=TRUE)]]
		fitness <- fitness[-max(fitness,index.return=TRUE)]
		offspring <- offspring[-max(fitness,index.return=TRUE)]
		k <- k +1
		if(k > a) break
	}
	b <- b+1
	offspring <- list() # Kill all children not fitted enough

	if (b > 5000) {
		print <- "FAILURE"
		break
		}
	if (length(population)<2){
		print <- 'EXTINCTION'
		break
	}
}

# Print results
par()
ts.plot(as.ts(av.fitness), xlab="Generations", ylab="Fitness")
bestguy[[1]]
ind
print

time <- as.data.frame(cbind(av.fitness,max.fitness))
time$gen <- as.numeric(rownames(time))

time <- melt(time, id = "gen")

time$lol[time$variable == "av.fitness"] <- "Average Population"
time$lol[time$variable == "max.fitness"] <- "Best Individual"

labels_names <- list(
	max.fitness="Best Individual",
	av.fitness="Average Population"
)

ggplot(time, aes ( y = value, x = gen, group = lol, colour = variable)) +
	geom_line(size = 1) +
	facet_grid( lol ~ ., scales = "free") +
	scale_colour_viridis(discrete=TRUE, begin = 0, end = 0.7, option = "A") +
	labs(x = "Number of Generations", y = "Fitness Value") +
	theme(
		legend.position = "none",
		strip.text.y = element_text(size = 12, face = "bold"),
		strip.background = element_rect(colour="black", fill = "grey"),
		panel.grid.major = element_line(colour="grey")
	)
