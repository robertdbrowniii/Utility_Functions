Calc_Utility <- function(BPV, MPPP, PV) {
  # The utility function takes the form u(v) = alpha *(1 - r^(-2*v/vmax)), where
  # vmax is the best prospect value, v is a prospect value between 0 and vmax,
  # and r and alpha are values determined by the preference probability at the
  # median prospect value vmax/2. This assumes that u(vmax) = 1, and u(0) = 0.
  
  # Given a prospect value PV between 0 and the best prospect value BPV, and
  # given the median prospect preference probability MPPP, this calculates the
  # utility of PV.

  # BPV = best prospect value
  # MPPP = preference probability for the prospect at half BPV
  # PV = a supplied prospect value

  r <- MPPP / (1 - MPPP)
  
  alpha <- r^2 / (r^2 - 1)
  
  u <- alpha * (1 - r^(-2*PV/BPV))
  
  return(u)
}

Calc_CE1 <- function(BPV, MPPP, PV) {
  # The utility function takes the form u(v) = alpha *(1 - r^(-2*v/vmax)), where
  # vmax is the best prospect value, v is a prospect value between 0 and vmax,
  # and r and alpha are values determined by the preference probability at the
  # median prospect value vmax/2. This assumes that u(vmax) = 1, and u(0) = 0.
  
  # Given a prospect value PV between 0 and the best prospect value BPV, and
  # given the median prospect preference probability MPPP, this calculates the
  # Certain Equivalent of PV.

  # BPV = best prospect value
  # MPPP = preference probability for the prospect at half BPV
  # PV = a supplied prospect value
  
  r <- MPPP / (1 - MPPP)
  
  alpha <- r^2 / (r^2 - 1)
  
  rnupv <- PV / BPV # the risk neutral utility of the prospect.
  
  cert_eq <- -BPV * log(1 - rnupv / alpha)/(2 * log(r))
  
  return(cert_eq)
}

Calc_CE2 <- function(BPV, MPPP, U) {
  # The utility function takes the form u(v) = alpha *(1 - r^(-2*v/vmax)), where
  # vmax is the best prospect value, v is a prospect value between 0 and vmax,
  # and r and alpha are values determined by the preference probability at the
  # median prospect value vmax/2. This assumes that u(vmax) = 1, and u(0) = 0.
  
  # Given a utility value that correspondes to a PV between 0 and the best
  # prospect value BPV, and given the median prospect preference probability
  # MPPP, this calculates the Certain Equivalent of PV.
  
  # BPV = best prospect value
  # MPPP = preference probability for the prospect at half BPV
  # U = a supplied utility value
  
  r <- MPPP / (1 - MPPP)
  
  alpha <- r^2 / (r^2 - 1)
  
  cert_eq <- -BPV * log(1 - U / alpha)/(2 * log(r))
  
  return(cert_eq)
}
