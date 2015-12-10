
function o=adsorption_langmuir(c,chi1,chi2)
%function o=adsorption_langmuir(c,chi1,chi2)
% adsorption function based on Langmuir equilibrium 
% see page 33 of SUTRA manual.
%      Input:
%      c (kg/kg)-- concentration of solute
%      chi1(m) -- capillary fringe in matric potential meters.
%                  this value must be negative.
%      chi2(m) -- capillary fringe in matric potential meters.
%                  this value must be negative.
%      Output

       o = chi1*(1000*c)./(1+chi2*1000*c);
