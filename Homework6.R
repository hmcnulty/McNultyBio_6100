# Script for Homework #6
# 02/18/2026
# Hannah Grace McNulty

#######################################################




# Question 1


library(deSolve)




 # create storage dataframe
  #df_length <- length(beta)*length(gamma) 
  #beta <- rep(NA, df_length)
  #gamma <- rep(NA, df_length)






############################################################
# FUNCTION: run_sir_model
# PURPOSE: Solve deterministic SIR model with deSolve
# INPUTS:
#   beta, gamma : transmission & recovery rates
#   N           : total population
#   S0, I0, R0  : initial conditions
#   t_start     : start time
#   t_end       : end time
#   dt          : timestep
# OUTPUT:
#   data.frame with columns: time, S, I, R
############################################################

run_sir_model <- function(
  beta    = 0.1,
  gamma   = 0.1,
  N       = 1000,
  S0      = 999,
  I0      = 1,
  R0      = 0,
  t_start = 0,
  t_end   = 160,
  dt      = 1
) {

  init  <- c(S = S0, I = I0, R = R0)
  times <- seq(t_start, t_end, by = dt)

  sir_equations <- function(time, state, parameters) {
    with(as.list(c(state, parameters)), {
      dS <- -beta * S * I / N
      dI <-  beta * S * I / N - gamma * I
      dR <-  gamma * I
      list(c(dS, dI, dR))
    })
  }

  out <- ode(
    y     = init,
    times = times,
    func  = sir_equations,
    parms = c(beta = beta, gamma = gamma, N = N)
  )

  as.data.frame(out)
}

run_sir_model()








infected <- function(beta = seq(from = 0, to = 0.5, by = 0.01), gamma = seq(from = 0, to = 0.5, by = 0.01)){
  # row indexing variable
    counter <- 1

  # create storage dataframe
    dfLength <- length(beta)*length(gamma) # how long is DF
    b_out <- rep(NA, dfLength)
    g_out <- rep(NA, dfLength)
    maxi_out <- rep(NA, dfLength)

  # turn vecs into df
  storageDF <- data.frame(b_out, g_out, maxi_out)

  # enter our loops
  for (i in seq_along(beta)){ # rows
    for (j in seq_along(gamma)){ # cols

      # run log growth
      tmp_df <- run_sir_model(beta = beta[i], gamma = gamma[j])

      # store max n in dataframe
      storageDF$maxi_out[counter] <- max(tmp_df$I)
      storageDF$b_out[counter] <- beta[i] # value for beta stored
      storageDF$g_out[counter] <- gamma[j] # value for gamma stored

      counter <- counter + 1 # increase counter

    }
  }
return(storageDF)
}  
  


infected()
