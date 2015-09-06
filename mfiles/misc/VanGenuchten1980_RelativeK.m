function kr=VanGenuchten1980_RelativeK(psim,alpha,nv)
% function kr=VanGenuchten1980_RelativeK(psim,alpha,nv)
% relative permeability as a function of matric potential 
% based on VanGenuchten (1980)
% Genuchten, M. Van. (1980). A closed-form equation for 
% predicting the hydraulic conductivity of unsaturated soils.
% Soil Science Society of America Journal, 8, 892-898
%      Input:
%      psim (m) -- matric potential in meters. this values needs
%                  to be negative
%      alpha(m) -- capillary fringe in matric potential meters.
%                  this value must be negative.
%      nv   (m) -- pore size distribution coefficient

%      Output
%      kr       -- relative permeability of soil 
%      TO20150906

se   = 1./( 1+(alpha*psim).^nv   ).^(1-1/nv);

kr=se.^0.5.*(1-   (   1- se.^(nv/(nv-1) ) ).^((nv-1)/nv)   ).^2;
