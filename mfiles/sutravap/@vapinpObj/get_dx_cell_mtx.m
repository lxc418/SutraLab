function o=get_dx_cell_mtx(o)
%function o=get_dy_cell_mtx(o)
% this subfunction gets the delta y, when meshtype is 2D and regular

    keynodes            = zeros(size(o.x_nod_mtx,1),size(o.x_nod_mtx,2)+1);
    keynodes(:,2:end-1) = (o.x_nod_mtx(:,1:end-1)+o.x_nod_mtx(:,2:end))/2;
    keynodes(:,1)       = o.x_nod_mtx(:,1);
    keynodes(:,end)     = o.x_nod_mtx(:,end);
    o.dx_cell_mtx       = diff(keynodes,1,2) % check inbuilding function diff
end 
