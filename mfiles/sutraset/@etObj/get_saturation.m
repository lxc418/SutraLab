function opt=get_saturation(o,varargin)
%function opt=get_saturation
% this function gives the soil water retention curve of selected parameters
% The default suctio input is psim: 
% input:
% psim -- matric potential (m)
% nreg -- the index of SWCC parameter from  ET.inp
% 'psim',-[0.1:0.1:1,2:1:10,20:10:100,200:100:1000,2000:1000:50000]
% in ET.INP
% c=ConstantObj();
% psim=c.psim_log_range(1:max_adr);
% TO190308
% example:
%    ET.get_saturation('psim',-500,'nreg',1)
  [psim,  varargin] = getProp(varargin,'psim',-[0.1:0.1:1,2:1:10,20:10:100,200:100:1000,2000:1000:50000]);
  [nreg,  varargin] = getProp(varargin,'nreg',1);
  if nreg==1
    opt=SWCC_Fayer1995WRR(psim,-1/o.aa1,o.vn1,-o.phy0,o.swres1);
  elseif nreg==2
    opt=SWCC_Fayer1995WRR(psim,-1/o.aa2,o.vn2,-o.phy0,o.swres2);
  end

end % function
