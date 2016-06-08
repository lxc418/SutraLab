function o=calc_relativek(o,varargin)
      [tor, varargin] = getProp(varargin,'tortuosity',0.5);
      [type,  varargin] = getProp(varargin,'type',[]);
% this subfunction gets the delta y, when meshtype is 2D and regular
    if strcmpi(type,'mualem1976')
        for n=1:o.no_session
            o.kr_mualem1976wrr{n}=RelativeK_Mualem1976(o.psim,-1/o.aa1(n),o.vn(n),'tortuosity',tor);
        end
    elseif strcmpi(type,'mualem1976_sw_stretch')
        for n=1:o.no_session
            o.kr_mualem1976wrr_sw_stretch{n}=RelativeK_Mualem1976_sw_stretch(o.psim,-1/o.aa1(n),o.vn(n),o.swres(n));
        end
    elseif strcmpi(type,'tokunaga2009')
        for n=1:o.no_session
            [o.kfs_tokunaga2009wrr,o.kfr_tokunaga2009wrr{n}]=FilmRelativeK_Tokunaga2009WRR(o.psim,293.15,0.00035,o.por(n),1);
        end

    end
end % function
