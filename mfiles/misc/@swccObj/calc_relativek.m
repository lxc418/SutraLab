function o=calc_relativek(o,varargin)
%      [fname, varargin] = getNext(varargin,'char','');
      [type,  varargin] = getProp(varargin,'type',[]);
% this subfunction gets the delta y, when meshtype is 2D and regular
    if strcmpi(type,'mualem1976')
        for n=1:o.no_session
            o.kr_mualem1976wrr{n}=RelativeK_Mualem1976(o.psim,-1/o.aa1(n),o.vn(n));
        end
    end
end % function
