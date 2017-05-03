function kr=RelativeK_Mualem1976_sw_stretch(psim,alpha,nv,slr)
%function kr=RelativeK_Mualem1976_sw_stretch(psim,alpha,nv,slr)
% liquid water sauturation as a function of matric potential 
% based on Fayer(1955)
% this modification version is to see how kr will be changed when 
% changing se to sw
% the reason of having such version is because it is found that
% during marsh evaporation case, high marsh becomes difficult
% to be wetted again, which is persumablly due to low relative k 
% at low saturation rate TO160602
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
sw=(1-slr)*se+slr;
kr=sw.^0.5.*(1-   (   1- se.^(nv/(nv-1) )       ).^((nv-1)/nv)   ).^2;

end % function


