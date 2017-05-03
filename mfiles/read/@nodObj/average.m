function opt=average(o,varargin)
% get an average result of properties in nod file
% example: opt= nodobj.average('c','mtx')
% returns a concentration average result, and convert it as a matrix
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  % p_bol c_bol and s_bol determines which variable to do the average
  [p_bol,  varargin] = getWord(varargin,'p');
  [c_bol,  varargin] = getWord(varargin,'c');
  [s_bol,  varargin] = getWord(varargin,'s');
  [mtx_bol,  varargin]  = getWord(varargin,'mtx');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);

  if p_bol
      aa=arrayfun(@(y) y.terms(o.p_idx),o.data);
  elseif c_bol
      aa=arrayfun(@(y) y.terms(o.c_idx),o.data);
  elseif s_bol
      aa=arrayfun(@(y) y.terms(o.s_idx),o.data);
  end

  opt=mean(cat(3,aa{:}),3);
   if mtx_bol, opt=convert_2_mtx(o,opt); end
