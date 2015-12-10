function opt=export(o,varargin)
%function opt=export(o,varargin)
  [inputnumber,  varargin] = getProp(varargin,'steps',1);
  [mtx_bol,  varargin] = getWord(varargin,'mtx');
  [x_bol,  varargin] = getWord(varargin,'x');
  [y_bol,  varargin] = getWord(varargin,'y');
  [z_bol,  varargin] = getWord(varargin,'z');
  [p_bol,  varargin] = getWord(varargin,'p');
  [c_bol,  varargin] = getWord(varargin,'c');
  [s_bol,  varargin] = getWord(varargin,'s');
  if x_bol
    opt=o.data(inputnumber).terms{o.x_idx};
  elseif y_bol
    opt=o.data(inputnumber).terms{o.y_idx};
  elseif z_bol
    opt=o.data(inputnumber).terms{o.z_idx};
  elseif p_bol
    opt=o.data(inputnumber).terms{o.p_idx};
  elseif c_bol
    opt=o.data(inputnumber).terms{o.c_idx};
  elseif s_bol
    opt=o.data(inputnumber).terms{o.s_idx};
  end
   if mtx_bol, opt=convert_2_mtx(o,opt); end
