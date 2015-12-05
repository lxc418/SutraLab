function opt=get_watertable_mtx(o,varargin)
% A warning to this : if transpose is enabled, the sequence of the array
% is no longer in accordance with the nodal sequence!
% but the advantage is that the matrix is formed in a regular form
  % a string storing the caller functions
  % currently there is no way to append on the output matrix
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  %[o.transpose,  varargin]  = getProp(varargin,'asfd','2D');
  [delete_terms,  varargin] = getProp(varargin,'delete_terms','no');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);
%http://stackoverflow.com/questions/24961828/add-field-to-existing-struct-or-variable-via-function-without-renaming-or-destro
%  if ~isempty(opt)
%      kkkkkkkkkkk
% convert array into matrix
for n=1:length(o.data)
  % mask matrix for water table
  p_mtx_watertable_mask=zeros( size(o.export('x','mtx')) )+1;

  % remove negative points (unsaturated)
  p_mtx_watertable_mask(o.export('p','mtx','steps',n)<0) = 0;

  % http://stackoverflow.com/questions/15716898/matlab-find-row-indice-of-first-occurrence-for-each-column-of-matrix-without-u
  [~,idx] = max(p_mtx_watertable_mask(:,sum(p_mtx_watertable_mask)>0));

  %http://stackoverflow.com/questions/32941314/matlab-get-data-from-a-matrix-with-data-row-and-column-indeces-stored-in-arrays/32941538#32941538
  if o.mtx_transpose
      x_mtx_length=o.nn1;
  elseif o.mtx_transpose==0
      x_mtx_length=o.nn2;
  end
  opt(n).watertable_mask_mtx = sub2ind(size(p_mtx_watertable_mask),idx,1:x_mtx_length);
  
  %watertable_ay=o.data(n).terms_mtx{o.p_idx}(p_mtx_watertable_mask)/(c.g*c.rhow_pure_water)+...
  %	o.data(n).terms_mtx{o.y_idx}(p_mtx_watertable_mask);

  %o.data(n).watertable_ay=o.data(n).terms_mtx{o.p_idx}(o.data(n).watertable_mask_mtx)/9800+...
 % 	o.data(n).terms_mtx{o.y_idx}(o.data(n).watertable_mask_mtx);
 p_mtx=o.export('p','mtx','steps',n);
 p_ay=p_mtx(opt(n).watertable_mask_mtx);
 y_mtx=o.export('y','mtx');
 y_ay=y_mtx(opt(n).watertable_mask_mtx);
   opt(n).watertable_ay=p_ay/9800+y_ay;
end


%p_nod_mtx=nod.data(1).terms_mtx{nod.p_idx};
%y_nod_mtx=nod.data(1).terms_mtx{nod.y_idx};
