function [kfs,kfr]=FilmRelativeK_Lebeau2010WRR(psim,sw,tk,swm,por,asvl)
%function [kfs kfr]=FilmRelativeK_Lebeau2010WRR(psim,tk,swm,por,asvl)
% Relative permeability induced by film water as a function 
%   of matric potential 
% Based on:
% Lebeau, M., & Konrad, J.-M. (2010). A new capillary and thin 
%   film flow model for predicting the hydraulic conductivity of
%   unsaturated porous media. Water Resources Research, 46(12),
%   W12554. doi:10.1029/2010WR009092
% Inputs:
%    psim (m)   -- matric potential in meters. this values needs
%                  to be negative;
%    agr  (m)   -- average grain radius in meters;
%    tk(kelvin) -- bulk soil temperature in kelvin.
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
% See page 179 of the YearBook 2014


%bp   = 3.00061397378356e-24;
%% a coef associated with Young-Laplace equation
%zeta = 1.46789e-5;
%
%%    a parameter in b see page 165 of yearbook 2014
%%     bp=2.d0**5.d-1*pi**2*(relpw*permvac/2.d0/surft)**1.5*
%%    1 (botz/ecectr)**3
%%     b=bp*(tpt)**3.d0
%%     now assuming film temperature is constant
%b=bp*tk^3;
%%     (s)aturated (p)ermeability due to (f)ilm flow (spf) [m2]
%kfs=corf*b*(1-por)*(2*agr)^5.d-1;
%
%%     capillary pressure head
%psic=-psim;
%%    （r)elative (p)ermeability due to (f)ilm flow (rpf) [-]
%kfr=(1+agr*2.d0*psic/zeta)^(-1.5d0);
%
rhow0=1e3;
gva=9.81;
%psicm=-1e3;
%swm=aaa;

%   (r)elative (perm)eability of (w)ater (relpw)  [-]
relpw=78.54e0;
%(vac)cum (perm)eability [permfs] [c2j-1m-1 or f/m or s4a2/kg/m3] 
%   nsee page 165
permvac=8.854e-12;
%    (botz)mann (c)onstant (botzc)  [j/k]
botzc=1.381e-23;
%    (electr)on (c)harge   (electrc) [coulombs or as]
electrc=1.602e-19;

psicm=1e3;
%.....effective diameter equation 17 of Lebeau(2010)
ed=6*(1-por)* (-asvl/(6*pi*rhow0*gva*psicm))^(1/3)/por/swm;
%.....film thickness (warning) this is not the full part
del=(relpw*permvac/(2*rhow0*gva))^.5e0*(pi*botzc*tk/electrc);
kfs=4.e0*(1-por)*del^3.e0/pi/ed;

%.....relative permeability due to film flow
%     capillary pressure head
psic=-psim;           
kfr=(1-sw).*psic.^(-1.5d0);
%.....for checking the spf and rpf value see page 179 and relativek.sage
%      if (psic.gt.1.d3)then
%        reapl=spf*rpf
%      endif
