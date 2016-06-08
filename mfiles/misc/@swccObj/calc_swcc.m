function o=calc_swcc(o,varargin)
%      [fname, varargin] = getNext(varargin,'char','');
      [type,  varargin] = getProp(varargin,'type',[]);
%function o=get_dy_cell_mtx(o)
% this subfunction gets the delta y, when meshtype is 2D and regular
    if strcmpi(type,'fayer1995')
        for n=1:o.no_session
            [o.sw_fayer1995wrr{n},~]=SWCC_Fayer1995WRR(o.psim,-1/o.aa1(n),o.vn(n),o.psim0(n),o.swres(n));
        end
    end
end % function
