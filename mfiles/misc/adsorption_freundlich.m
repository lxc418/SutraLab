
function o=adsorption_freundlich(c,chi1,chi2)
% function o=adsorption_freundlich(c,chi1,chi2)
% adsorption function based on Freundlich equilibrium 
% see page 33 of SUTRA manual.
%      Input:
%      c (kg/kg)-- concentration of solute
%      chi1(m) -- capillary fringe in matric potential meters.
%                  this value must be negative.
%      nv   (m) -- pore size distribution coefficient
%      psim0(m) -- the matric potential value where liquid water
%                  saturation becomes zero
%      Output

%beta = (log(-psim0)-log(-psim))/log(-psi0);
%se   = 1./( 1+(alpha*psim).^nv   ).^(1-1/nv);
%sw   = (1-beta_ss*slr).*se +beta*slr;
       o = chi1*(1000*c).^(1/chi2);
