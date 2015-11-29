function o=get_output_idx(o,varargin)
% function o=get_output_idx(o,varargin)
% this function returns the indeces of all outputs
  caller = dbstack('-completenames'); caller = caller.name;
  o.varargin       = varargin;
  [o.transpose,  varargin]  = getProp(varargin,'transpose','no');
  [delete_terms,  varargin] = getProp(varargin,'delete_terms','no');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);
  

  o.e_idx  = find(strcmpi(o.data(1).label,'Element'));
  o.x_idx  = find(strcmp(o.data(1).label,'X origin'));
  o.y_idx  = find(strcmp(o.data(1).label,'Y origin'));
  o.z_idx  = find(strcmp(o.data(1).label,'Z origin'));
  o.vx_idx  = find(strcmp(o.data(1).label,'X velocity'));
  o.vy_idx  = find(strcmp(o.data(1).label,'Y velocity'));
  o.vz_idx  = find(strcmp(o.data(1).label,'Z velocity'));

