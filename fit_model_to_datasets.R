##################################################################################
##              Multiple landscapes Joint species movement modelling            ##
##                                   Fit Model                                  ##
##################################################################################

## authors: "Danielle Leal Ramos, Otso Ovaskainen, Marco Aurélio Pizo, Milton Cezar Ribeiro, and Juan Manuel Morales"
## date: "January, 2019"

## CHANGE THIS ### This code can also be viewed in http://htmlpreview.github.io/?https://github.com/LEEClab/JSMM/blob/master/JSMM.html , with more detailed comments.

## Set working directory

setwd("C:/Users/Danielle/OneDrive/projetos/manuscritos/traits/results/_JSMM")

## Required packages
if (!require("MCMCpack")) install.packages("MCMCpack") # for function riwish
if (!require("mvtnorm")) install.packages("mvtnorm") # for functions dmvnorm and rmvnorm
library(Matrix)
library(doParallel) # for parallel computing

## Required functions

trunca <- function(x) min(max(x, 10^-5), 10^5) # required function to run the JSMM function below
source("MLjsmm.r")
source("loglik_steps.r")
# source("loglik_time.r")

## Load dataset

load("multi_landscape_simulated_dataset.Rdata")
# load("multi_landscape_real_bird_dataset.Rdata")
# load("multi_landscape_real_bird_dataset_PT.Rdata")

load("multi_landscape_real_bird_dataset_corrFO.Rdata")

## Fitting the model ##

# cl <- makeCluster(5)
# registerDoParallel(cl)

# tpm <- foreach(repl = 1:5, .export = c("loglik", "trunca", "jsmm.mcmc"), .packages = c('Matrix','mvtnorm','MCMCpack')) %dopar%
# {
output <- jsmm.mcmc(loglikelihood = loglik, data = data, n.iter = 500, n.adapt.iter = 100, n.thin = 10, rotate = TRUE)
# }
# stopCluster(cl)

save(output, file = "simulated_data_300it_19_01_17.Rdata")
# save(output, file = "real_data_steps_1000it_19_01_17.Rdata")
# save(output, file = "real_data_PT_100it_19_01_16.Rdata")
