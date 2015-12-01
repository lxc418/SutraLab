function opt=x(o,varargin)
% function o=x_idx(o,varargin)
  [inputnumber,  varargin] = getProp(varargin,'steps',1);
  [mtx_bol,  varargin] = getWord(varargin,'mtx');
% this function returns the indeces of all outputs
    opt=o.data(inputnumber).terms{o.x_idx};
   if mtx_bol, opt=convert_2_mtx(o,opt); end
