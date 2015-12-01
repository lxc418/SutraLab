function node=node(o,varargin)
% function o=x_idx(o,varargin)
  [inputnumber,  varargin] = getProp(varargin,'steps',1);
  [mtx_bol,  varargin] = getWord(varargin,'mtx');
    
  
  node=o.data(inputnumber).terms{o.n_idx};
    if mtx_bol
        if strcmpi(o.mtx_transpose,'no')
            node=reshape(node,[o.nn1,o.nn2]);
        else strcmpi(o.mtx_transpose,'yes')
            node=reshape(node,[o.nn1,o.nn2])';
        end
    end
