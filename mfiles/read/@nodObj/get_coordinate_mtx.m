function o=get_coordinate_mtx(o,varargin)
% A warning to this : if transpose is enabled, the sequence of the array
% is no longer in accordance with the nodal sequence!
% but the advantage is that the matrix is formed in a regular form
  % a string storing the caller functions
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
%  [o.transpose,  varargin]  = getProp(varargin,'transpose','no');
  [x_output,  varargin] = getProp(varargin,'x_mtx','no');
  [y_output,  varargin] = getProp(varargin,'y_mtx','no');
  [z_output,  varargin] = getProp(varargin,'z_mtx','no');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);
%  o2.output_no             = output_no;
  if strcmpi(o.mtx_transpose,'no')
      if strcmpi(x_output,'yes')
        o.x_mtx=reshape(o.data(1).terms{o.x_idx},[o.nn1,o.nn2]);
      end
      if strcmpi(y_output,'yes')
        o.y_mtx=reshape(o.data(1).terms{o.y_idx},[o.nn1,o.nn2]);
      end
      if strcmpi(z_output,'yes')
        o.z_mtx=reshape(o.data(1).terms{o.z_idx},[o.nn1,o.nn2]);
      end
      
  elseif strcmpi(o.mtx_transpose,'yes')
      if strcmpi(x_output,'yes')
        o.x_mtx=reshape(o.data(1).terms{o.x_idx},[o.nn1,o.nn2])';
      end
      if strcmpi(y_output,'yes')
        o.y_mtx=reshape(o.data(1).terms{o.y_idx},[o.nn1,o.nn2])';
      end
      if strcmpi(z_output,'yes')
        o.z_mtx=reshape(o.data(1).terms{o.z_idx},[o.nn1,o.nn2])';
      end
  end

