function opt=average(o,varargin)
% get an average result
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  [property,  varargin]  = getProp(varargin,'property','');
%  [transpose,  varargin]  = getProp(varargin,'transpose','no');
  [mtx,  varargin]  = getWord(varargin,'mtx');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);

  if strcmpi(property,'p')
      aa=arrayfun(@(y) y.terms(o.p_idx),o.data);
  elseif strcmpi(property,'c')
      aa=arrayfun(@(y) y.terms(o.c_idx),o.data);
  elseif strcmpi(property,'s')
      aa=arrayfun(@(y) y.terms(o.s_idx),o.data);
  end

  opt=mean(cat(3,aa{:}),3);
    if mtx
      if strcmpi(o.mtx_transpose,'yes')
        opt=reshape(opt,[o.nn1,o.nn2])';
      else
        opt=reshape(opt,[o.nn1,o.nn2]);
      end
    end
