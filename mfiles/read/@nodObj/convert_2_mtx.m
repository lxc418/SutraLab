function opt=convert_2_mtx(o,varargin) % it is a private function
        if strcmpi(o.mtx_transpose,'no')
            opt=reshape(varargin{1},[o.nn1,o.nn2]);
        else strcmpi(o.mtx_transpose,'yes')
            opt=reshape(varargin{1},[o.nn1,o.nn2])';
        end
