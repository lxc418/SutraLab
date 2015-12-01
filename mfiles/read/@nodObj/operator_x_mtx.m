function opt=operator_x_mtx(o,varargin)
% A warning to this : if transpose is enabled, the sequence of the array
% is no longer in accordance with the nodal sequence!
% but the advantage is that the matrix is formed in a regular form
  % a string storing the caller functions
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  [o.transpose,  varargin]  = getProp(varargin,'transpose','no');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);
%  o2.output_no             = output_no;
  if strcmpi(o.transpose,'no')
        opt=reshape(o.data(1).terms{o.x_idx},[o.nn1,o.nn2]);
      
  elseif strcmpi(o.transpose,'yes')
        opt=reshape(o.data(1).terms{o.x_idx},[o.nn1,o.nn2])';
  end

