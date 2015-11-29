function o=get_watertable_mtx(o,varargin)
% A warning to this : if transpose is enabled, the sequence of the array
% is no longer in accordance with the nodal sequence!
% but the advantage is that the matrix is formed in a regular form
  % a string storing the caller functions
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  [o.transpose,  varargin]  = getProp(varargin,'asfd','2D');
  [delete_terms,  varargin] = getProp(varargin,'delete_terms','no');
  [inpObj,  varargin]       = getProp(varargin,'inp',[]);

% convert array into matrix
for n=1:length(o.data)
  % mask matrix for water table
  p_mtx_watertable_mask=zeros( size(o.data(1).terms_mtx{1}) )+1;

  % remove negative points (unsaturated)
  p_mtx_watertable_mask(o.data(n).terms_mtx{o.p_idx}<0) = 0;

  % http://stackoverflow.com/questions/15716898/matlab-find-row-indice-of-first-occurrence-for-each-column-of-matrix-without-u
  [~,idx] = max(p_mtx_watertable_mask(:,sum(p_mtx_watertable_mask)>0));

  %http://stackoverflow.com/questions/32941314/matlab-get-data-from-a-matrix-with-data-row-and-column-indeces-stored-in-arrays/32941538#32941538
  o.data(n).watertable_mask_mtx = sub2ind(size(p_mtx_watertable_mask),idx,[1:size(o.data(n).terms_mtx{o.p_idx},2)]);
  
  %watertable_ay=o.data(n).terms_mtx{o.p_idx}(p_mtx_watertable_mask)/(c.g*c.rhow_pure_water)+...
  %	o.data(n).terms_mtx{o.y_idx}(p_mtx_watertable_mask);

  o.data(n).watertable_ay=o.data(n).terms_mtx{o.p_idx}(o.data(n).watertable_mask_mtx)/9800+...
  	o.data(n).terms_mtx{o.y_idx}(o.data(n).watertable_mask_mtx);
end


%p_nod_mtx=nod.data(1).terms_mtx{nod.p_idx};
%y_nod_mtx=nod.data(1).terms_mtx{nod.y_idx};
