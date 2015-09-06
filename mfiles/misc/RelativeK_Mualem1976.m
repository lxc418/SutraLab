function kr=RelativeK_Mualem1976(psim,alpha,nv,psim0,slr)
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
%      Output

beta = (log(-psim0)-log(-psim))/log(-psi0);
se   = 1./( 1+(alpha*psim).^nv   ).^(1-1/nv);
sw   = (1-beta_ss*slr).*se +beta*slr;
