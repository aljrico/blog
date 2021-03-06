# 8-Queen Problem using a Genetic Algorithm ---------------------------------------------------------
# Recursive Adam & Eve model
# Author: Alejandro Jiménez Rico <aljrico@gmail.com>

# Load functions
source("genetic_functions.R")

# Magnitude of the Problem
nproblem <- 10

# Probability of mutation
pmut <- 0.3

# Seed for generating initial parents
seed <- seq(nproblem)

# List to be filled
offspring <- list()

# Arrays to be filled
son <- c()
subject <- c()
fitness <- c()
max.fitness <- c()

# Number of toddlers by couple
noff <- nproblem*5

# Initial parents
par1 <- sample(seed)
par2 <- sample(seed)


b <- 0
# Creating further population ---------------------------------------------------
repeat{
	# Measuring fitness of every child
	for (i in 1:noff){
		offspring[[i]] <- gen.offspring(par1,par2,noff, pmut)[[i]]
		subject <- offspring[[i]]
		fitness[i] <- (1/(1+meas.error(subject)))
	}

	# Selecting most fittest childs as new parents
	par1 <- offspring[sort(-fitness,index.return=TRUE)[[2]][1]][[1]]
	par2 <- offspring[sort(-fitness,index.return=TRUE)[[2]][2]][[1]]
	max.fitness <- append(max.fitness, max(fitness))

	b <- b+1

	if (max(fitness)== nproblem*(nproblem-1)) break
	if (b > 5000) break
	if (max(fitness) == 1) break
}
ts.plot(max.fitness)
par1
