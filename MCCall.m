function pmean = MCCall ( s0, k, r, sig, t, m )
  % simulate asset price
  svals(1:m,1) = s0 * exp ( ( r - 0.5 * sig^2 ) * t ...
    + sig * sqrt ( t ) * randn ( m, 1 ) );
  % calculate call option price
  pvals(1:m,1) = exp ( - r * t ) * max ( svals(1:m,1) - k, 0.0 );
  pmean = mean ( pvals(1:m,1) );
  return
end