function opt=convert_2_mtx(o,varargin) % it is a private function
        if strcmpi(o.mtx_transpose,'no')
            opt=reshape(varargin{1},[o.ne1,o.ne2]);
        elseif strcmpi(o.mtx_transpose,'yes')
            opt=reshape(varargin{1},[o.ne1,o.ne2])';
        end
