function opt=average(o,varargin)
% get an average result of properties in nod file
% example: opt= eleobj.average('vx','mtx')
% example: opt= eleobj.average('vx','mtx','range',5:9)
% example: opt= eleobj.average('vx','mtx','range',5:9)
%   the default for range is ':' which is all
% returns pore water velocity average result, and convert it as a matrix
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  % p_bol c_bol and s_bol determines which variable to do the average
  [vx_bol,  varargin] = getWord(varargin,'vx');
  [vy_bol,  varargin] = getWord(varargin,'vy');
  [vz_bol,  varargin] = getWord(varargin,'vz');
  [mtx_bol,  varargin]  = getWord(varargin,'mtx');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);
  [fromto,  varargin]       = getProp(varargin,'range',':');

  if vx_bol
      aa=arrayfun(@(y) y.terms(o.vx_idx),o.data(fromto));
  elseif vy_bol
      aa=arrayfun(@(y) y.terms(o.vy_idx),o.data(fromto));
  elseif vz_bol
      aa=arrayfun(@(y) y.terms(o.vz_idx),o.data(fromto));
  end

  opt=mean(cat(3,aa{:}),3);
   if mtx_bol, opt=convert_2_mtx(o,opt); end
