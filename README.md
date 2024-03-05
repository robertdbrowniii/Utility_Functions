# Utility Functions
Calculates utility, certainty equivalent, and other risk values for prospects given an entity's stated risk attitude.

A utility function takes the form

 `u(v) = alpha * (1 - r^(-2*(v - vmin)/(vmax - vmin)))`

where `vmax` is a best prospect value (BPV), `vmin` is a worst prospect value (WPV),`v` is a prospect value between `vmin` and `vmax`, and `r` and `alpha` are values determined by the preference probability at the middle prospect value `(vmax - vmin)/2`. This assumes that `u(vmax) = 1`, and `u(vmin) = 0`.

Given the preference probability `PrefProb` at the middle prospect value, we can determine

 * `alpha = (PrefProb^2)/(2 * PrefProb - 1)`, and
 * `r = PrefProb/(1 - PrefProb)`
 
`r` is the odds of the preference probability. Making the appropriate substitutions in `u(v)` gives a fully specified utility function for an entity facing a specific risky deal.

If the value of a risky deal is represented by a continuous probability distribution of prospect values, as in a net present value (NPV) distribution, the following approach will yield a certainty equivalent for the NPV distribution.

 1. Use the `calcUtility()` function on each prospect value in the NPV vector to generate a distribution of utility values.
 2. Determine the expected (or mean) of the utility distribution.
 3. With the value from (2), use the `calcCertEquiv()` function to determine the certainty equivalent of the prospect value distribution.

The certainty equivalent is the guaranteed value the entity should be indifferent to receive compared to the full range of potential values in the risky deal, if it remains consistent with its risk attitude.

Other values returned by `calcCertEquiv()` include

 * `risk_premium`: The extra return expected by a decision-maker for bearing the risk associated with the risky deal. This is the difference between the expected NPV of the risky deal and the certainty equivalent.
 * `expected_potential_loss`: The average of the loss values of the risky deal, or mean(NPV | NPV<$0).
 * `prob_loss`: The probability that loss occurs, or Pr(NPV<$0)
 * `fair_premium`: The amount a risk neutral entity should be willing to pay to transfer the deal risk with a fully covered insurance policy. This is equal to `prob_loss * abs(expected_potential_loss)`.
 * `risk_averse_prem`: The amount a risk averse entity should be willing to pay to transfer the deal risk with a fully covered insurance policy. This is the sum of the fair premium and the risk premium.
