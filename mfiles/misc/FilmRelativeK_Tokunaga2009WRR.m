function [kfs kfr]=FilmRelativeK_Tokunaga2009WRR(psim,tk,agr,por,corf)
%function [kfs kfr]=FilmRelativeK_Tokunaga2009WRR(psim,tk,agr,por,corf)
% Relative permeability induced by film water as a function 
%   of matric potential 
% Based on;
% Tokunaga, T. K. (2009). Hydraulic properties of adsorbed water
%   films in unsaturated porous media. Water Resources Research,
%   45, W06415. doi:10.1029/2009WR007734
% Notice that the impact of viscosity is neglected in this 
%   function
% Inputs:
%    psim (m)   -- matric potential in meters. this values needs
%                  to be negative;
%    agr  (m)   -- average grain radius in meters;
%    tk(kelvin) -- bulk soil temperature in kelvin;
%    por  (-)   -- porosity;
%    corf (-)   -- a corefficient to increase the amplitude of 
%                    saturated permeability. this coefficient
%                    is endorsed by Zhang(2010) and Peters(2009)
%                    as the enhancement of film water due to 
%                    capillary water is not considered in this 
%                    model.
% Outputs:
%    kfs  (m2)  -- saturated permeability induced by film water;
%    kfr  (-)   -- relative permeability induced by film water.
%      TO20150906

    bp   = 3.00061397378356e-24;
% a coef associated with Young-Laplace equation
    zeta = 1.46789e-5;


%    a parameter in b see page 165 of yearbook 2014
%     bp=2.d0**5.d-1*pi**2*(relpw*permvac/2.d0/surft)**1.5*
%    1 (botz/ecectr)**3
%     b=bp*(tpt)**3.d0
%     now assuming film temperature is constant
    b=bp*tk^3;
%     (s)aturated (p)ermeability due to (f)ilm flow (spf) [m2]
    kfs=corf*b*(1-por)*(2*agr)^5.d-1;

%     capillary pressure head
    psic=-psim;
%    （r)elative (p)ermeability due to (f)ilm flow (rpf) [-]
    kfr=(1+agr*2.d0*psic/zeta).^(-1.5d0);
end
