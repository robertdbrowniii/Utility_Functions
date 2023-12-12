# Utility Functions
Calculates utility and certain equivalent values for prospects given a stated risk attitude.

The utility function takes the form

`u(v) = alpha *(1 - r^(-2*v/vmax))`

where `vmax` is a best prospect value, `v` is a prospect value between 0 and `vmax`, and `r` and `alpha` are values determined by the preference probability at the median prospect value `vmax/2`. This assumes that `u(vmax) = 1`, and `u(0) = 0`.

Given a prospect value `PV` between 0 and the best prospect value BPV, and given the median prospect preference probability MPPP, these functions calculate the utility or the certain equivalent of PV. The following are the parameters used in the functions.

* <b>BPV</b> = best prospect value
* <b>MPPP</b> = preference probability for the prospect at half BPV
* <b>PV</b> = a supplied prospect value
* <b>U</b> = a supplied utility value

The functions here are appropriate for a given single prospect or utility value. However, if one needs the certain equivalent for a distribution of prospect values (as in the case of a deal with multiple prospects), calculate the expected value of the utility of the deal prospects, then calculate the certain equivalent with the Calc_CE2() function. For example, suppose a deal is constructed as

  * `prob($100) = 0.2, utility = 1`
  * `prob($50) = 0.3, utility = 2/3`
  * `prob($0) = 0.5, utility = 0`

Then

`E(utility) = 0.2*1 + 0.3*2/3 + 0.5*0 = 0.4`

Using `Calc_CE2(BPV = 100, MPPP = 2/3, U = 0.4)` yields `CE = $25.73`.
 
If the deal is represented by a continuous probability distribution of prospect values (as in a net present value distribution), use the `Calc_Utility()` function on each prospect value to generate a distribution of utility values. Then determine the expected (or mean) of the resulting utility distribution. Finally, use the `Calc_CE2()` function using the expected utility to determine the certain equivalent of the prospect value distribution.
