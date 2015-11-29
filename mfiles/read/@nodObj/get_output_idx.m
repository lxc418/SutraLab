function o=get_output_idx(o,varargin)
% function o=get_output_idx(o,varargin)
% this function returns the indeces of all outputs
  caller = dbstack('-completenames'); caller = caller.name;
  o.varargin       = varargin;
  [o.transpose,  varargin]  = getProp(varargin,'transpose','no');
  [delete_terms,  varargin] = getProp(varargin,'delete_terms','no');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);
  

  o.n_idx  = find(strcmp(o.data(1).label,'Node'));
  o.x_idx  = find(strcmp(o.data(1).label,'X'));
  o.y_idx  = find(strcmp(o.data(1).label,'Y'));
  o.z_idx  = find(strcmp(o.data(1).label,'Z'));
  o.p_idx  = find(strcmp(o.data(1).label,'Pressure'));
  o.c_idx  = find(strcmp(o.data(1).label,'Concentration'));
  o.s_idx  = find(strcmp(o.data(1).label,'Saturation'));

