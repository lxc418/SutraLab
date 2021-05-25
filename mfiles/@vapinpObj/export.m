function opt=export(o,varargin)
% function o=x_idx(o,varargin)
  [inputnumber,  varargin] = getProp(varargin,'steps',1);
  [mtx_bol,  varargin] = getWord(varargin,'mtx');
  [x_bol,  varargin] = getWord(varargin,'x');
  [y_bol,  varargin] = getWord(varargin,'y');
  [z_bol,  varargin] = getWord(varargin,'z');
%  [p_bol,  varargin] = getWord(varargin,'p');
  [por_bol,  varargin] = getWord(varargin,'por');
  [nreg_bol,  varargin] = getWord(varargin,'nreg');
% this function returns the indeces of all outputs
  if x_bol
    opt=o.x;
  elseif y_bol
      opt=o.y;
  elseif z_bol
      opt=o.z;
  elseif por_bol
      opt=o.por;
  elseif nreg_bol
      opt=o.nreg;
  end
   if mtx_bol, opt=convert_2_mtx(o,opt); end
