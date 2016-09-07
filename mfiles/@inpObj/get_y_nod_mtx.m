function o=get_y_nod_mtx(o,varargin)
% function o=get_nod_dy_mtx(o)
% this subfunction gets the delta y, when meshtype is 2D and regular

  [o.transpose,  varargin]  = getProp(varargin,'transpose','no');
  if strcmpi(o.transpose,'no')
    o.y_nod_mtx=reshape(o.y,[o.nn1,o.nn2]);
  elseif strcmpi(o.transpose,'yes')
    o.y_nod_mtx=reshape(o.y,[o.nn1,o.nn2])';
  end

end %nod_dx_mtx
