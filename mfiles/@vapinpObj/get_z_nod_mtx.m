function o=get_z_nod_mtx(o,varargin)
% function o=get_nod_dz_mtx(o)
% this subfunction gets the delta z, when meshtype is 2D and regular

  [o.transpose,  varargin]  = getProp(varargin,'transpose','no');
  if strcmpi(o.transpose,'no')
    o.z_nod_mtx=reshape(o.z,[o.nn1,o.nn2]);
  elseif strcmpi(o.transpose,'yes')
    o.z_nod_mtx=reshape(o.z,[o.nn1,o.nn2])';
  end

end %nod_dx_mtx
