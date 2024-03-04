#### Utility of a Risky Decision ####
calcUtility <- function(PrefProb, V) {
  # The utility function takes the form
  # u(v) = alpha * (1 - r^(-2*(v - vmin)/(vmax - vmin))), where
  # vmax is the best prospect value, vmin is the worst prospect value, v is a
  # prospect value between vmin and vmax, and r and alpha are values determined
  # by the preference probability PrefProb at the median prospect value (vmax-vmin)/2.
  # This assumes that u(vmax) = 1, and u(vmin) = 0.
  # 
  # alpha = (PrefProb^2)/(2 * PrefProb - 1)
  # r = PrefProb/(1 - PrefProb)
  # r is the odds of the preference probability.
  # 
  # Given a prospect value V between the worst prospect value WPV and the best
  # prospect value BPV, and given the median prospect preference probability
  # PrefProb, this calculates the utility of V.
  #
  # V = a vector of prospect values
  # PrefProb = preference probability
  
  # Find the Min and Max of V
  vmin <- quantile(V, 0.0005)
  vmax <- quantile(V, 0.9995)
  
  # Calculate the preference odds
  r <- PrefProb / (1 - PrefProb)
  
  # Calculate the scaling factor
  alpha <- ifelse(PrefProb != 0.5,
                  (PrefProb ^ 2) / (2 * PrefProb - 1),
                  1)
  
  if (PrefProb != 0.5) {
    u <-
      sapply(1:length(V), function(v)
        alpha * (1 - r ^ (-2 * (V[v] - vmin) / (vmax - vmin))))
  } else {
    u <- sapply(1:length(V), function(v)
      (V[v] - vmin) / (vmax - vmin))
  }
  
  return(u)
}

#### Certainty Equivalent of a Risky Decision ####
calcCertEquiv <- function(ExpU, PrefProb, V) {
  # V = a vector of prospect values representing the distribution of V.
  # ExpU = The mean utility of the distribution of V.
  # PrefProb = the preference probability for the gamble with worst prospect
  # value WPV and best prospect value BPV from V.
  # Returns a list of essential risk characteristics of the risky decision.
  
  # Find the WPV and BPV of V
  vmin <- quantile(V, 0.0005)
  vmax <- quantile(V, 0.9995)
  
  # Calculate the preference odds
  r <- PrefProb/(1 - PrefProb)
  
  # Calculate the scaling factor
  alpha <- ifelse(PrefProb != 0.5,
                  (PrefProb^2)/(2 * PrefProb - 1),
                  1)
  
  cert_eq <- ifelse(PrefProb != 0.5,
                    vmin - (vmax - vmin) * log(1 - ExpU/alpha)/(2 * log(r)),
                    (ExpU * (vmax - vmin)) + vmin)
  
  # The amount an insured should be willing to pay to cover the their incremental
  # risk aversion.
  risk_premium <- mean(V) - cert_eq
  
  # The average value of the potential outcomes less than $0.
  expected_potential_loss <- mean(V[V<0])
  
  # The probability of facing outcomes less than $0.
  prob_loss <- mean(V<0)
  
  # The amount a risk neutral insured should be willing to pay to cover losses.
  fair_premium <- prob_loss * abs(expected_potential_loss)
  
  # The total amount an insured should be willing to pay if they are risk averse.
  risk_averse_prem <- fair_premium + risk_premium
  
  X <- list(
    cert_eq = cert_eq,
    risk_premium = risk_premium,
    expected_potential_loss = expected_potential_loss,
    prob_loss = prob_loss,
    fair_premium = fair_premium,
    risk_averse_prem = risk_averse_prem
  )
  
  return(X)
}


#### Example Problem ####
set.seed(42)
Project_NPV <- rlnorm(n = 1000000,
                      meanlog = log(50) - (0.2935^2)/2,
                      sdlog = 0.2935) - 40

my_preference_prob <- 2/3

Project_Utility <- calcUtility(PrefProb = my_preference_prob,
                                     V = Project_NPV)

Project_eUtility <- mean(Project_Utility)

Project_CE <- calcCertEquiv(ExpU = Project_eUtility,
                            PrefProb = my_preference_prob,
                            V = Project_NPV)
