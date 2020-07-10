function o=get_salt_curve_parameters(o)
%function o=get_salt_curve_parameters(o)
% this subfunction gets the delta y, when meshtype is 2D and regular

    %keynodes            = zeros(size(o.x_nod_mtx,1),size(o.x_nod_mtx,2)+1);
    %keynodes(:,2:end-1) = (o.x_nod_mtx(:,1:end-1)+o.x_nod_mtx(:,2:end))/2;
    %keynodes(:,1)       = o.x_nod_mtx(:,1);
    %keynodes(:,end)     = o.x_nod_mtx(:,end);
    %o.dx_cell_mtx       = diff(keynodes,1,2); % check inbuilding function diff
    a=(1-o.por(1))*o.rhos*o.vol_mtx(1)* o.chi1*1000^(1/o.chi2);
    b=1./o.chi2;
    fprintf ('the salt curve is written as cs=a*c^b, where cs  (kg/kg) is mass of solid salt/ mass of solid grains\n' )
    fprintf ('coefficient a is %e \n',a )
    fprintf ('coefficient b is %e \n',b )
    


end 
