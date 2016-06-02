function kr=RelativeK_Mualem1976(psim,alpha,nv)
%function kr=RelativeK_Mualem1976(psim,alpha,nv,psim0,slr)
% liquid water sauturation as a function of matric potential 
% based on Fayer(1955)
% Fayer, M. J., & Simmons, C. S. (1995). Modified Soil Water 
% Retention Functions for All Matric Suctions. Water Resources 
% Research, 31(5), 1233�1238.  ~/Hdrive/Saltmarsh/mfile/WRC
%      Input:
%      psim (m) -- matric potential in meters. this values needs
%                  to be negative
%      alpha(m) -- capillary fringe in matric potential meters.
%                  this value must be negative.
%      nv   (m) -- pore size distribution coefficient
%      psim0(m) -- the matric potential value where liquid water
%                  saturation becomes zero
%                  This value needs to be negative
%      Output
se=1./( 1+(psim/alpha).^nv   ).^(1-1/nv);
kr=se.^0.5.*(1-   (   1- se.^(nv/(nv-1) )       ).^((nv-1)/nv)   ).^2;

end % function


