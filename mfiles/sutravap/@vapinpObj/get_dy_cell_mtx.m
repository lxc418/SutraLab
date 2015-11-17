function o=get_dy_cell_mtx(o)
%function o=get_dy_cell_mtx(o)
% this subfunction gets the delta y, when meshtype is 2D and regular

    keynodes            = zeros(size(o.y_nod_mtx,1)+1,size(o.y_nod_mtx,2));
    keynodes(2:end-1,:) = (o.y_nod_mtx(1:end-1,:)+o.y_nod_mtx(2:end,:))/2;
    keynodes(1,:)       = o.y_nod_mtx(1,:);
    keynodes(end,:)     = o.y_nod_mtx(end,:);
    o.dy_cell_mtx=diff(keynodes,1,1) % check inbuilding function diff
end 
