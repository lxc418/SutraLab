function n_mtx=n_mtx(o,varargin)
% function o=x_idx(o,varargin)
  [inputnumber,  varargin] = getProp(varargin,'input_number',1);
%  [inputnumber,  varargin] = getProp(varargin,'input_number',1);
% this function returns the indeces of all outputs
%  o.n_idx  = find(strcmp(o.data(checkinput).label,'Node'));
%  x_idx  = find(strcmp(o.data(1).label,'X'));
%  o.y_idx  = find(strcmp(o.data(1).label,'Y'));
%  o.z_idx  = find(strcmp(o.data(1).label,'Z'));
%  o.p_idx  = find(strcmp(o.data(1).label,'Pressure'));
%  o.c_idx  = find(strcmp(o.data(1).label,'Concentration'));
%  o.s_idx  = find(strcmp(o.data(1).label,'Saturation'));
    if strcmpi(o.mtx_transpose,'no')
        n_mtx=reshape(o.data(inputnumber).terms{o.n_idx},[o.nn1,o.nn2]);
    else strcmpi(o.mtx_transpose,'yes')
        n_mtx=reshape(o.data(inputnumber).terms{o.n_idx},[o.nn1,o.nn2])';
    end
