function o=get_dx_cell_mtx(o)
%function o=get_dy_cell_mtx(o)
% this subfunction gets the delta y, when meshtype is 2D and regular

    o.vol_mtx       = o.dx_cell_mtx.*o.dy_cell_mtx.*o.dz_cell_mtx;

end 
