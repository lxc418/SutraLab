function o=get_x_nod_mtx(o)
% function o=get_nod_dy_mtx(o)
% this subfunction gets the delta y, when meshtype is 2D and regular
    o.x_nod_mtx=reshape(o.x,[o.nn1,o.nn2]);
end %nod_dx_mtx
