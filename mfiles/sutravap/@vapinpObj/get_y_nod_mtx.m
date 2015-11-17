function o=get_y_nod_mtx(o)
% this subfunction gets the delta y, when meshtype is 2D and regular
    o.y_nod_mtx=reshape(o.y,[o.nn1,o.nn2]);
end %nod_dx_mtx
