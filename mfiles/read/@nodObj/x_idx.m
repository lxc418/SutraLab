function x_idx=x_idx(o,varargin)
% function o=x_idx(o,varargin)
  [checkinput,  varargin] = getProp(varargin,'checkinput',1);
% this function returns the indeces of all outputs
%  o.n_idx  = find(strcmp(o.data(checkinput).label,'Node'));
  x_idx  = find(strcmp(o.data(1).label,'X'));
%  o.y_idx  = find(strcmp(o.data(1).label,'Y'));
%  o.z_idx  = find(strcmp(o.data(1).label,'Z'));
%  o.p_idx  = find(strcmp(o.data(1).label,'Pressure'));
%  o.c_idx  = find(strcmp(o.data(1).label,'Concentration'));
%  o.s_idx  = find(strcmp(o.data(1).label,'Saturation'));

