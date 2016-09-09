function opt=average(o,varargin)
% get an average result of properties in nod file
% example1: opt= bcofobj.average('qin')
%     Averages the qin ( specified source+/sink- of fluid [kg/s])
% example: opt= bcofobj.average('uucut','range',5:9)
%     Averages the uucut ( solute concentration of fluid [kg/kg] at 5-9 steps)
% example: opt= bcofobj.average('qu'   ,'range',5:9)
%     Averages the uucut ( solute source+/sink- [kg/s] at 5-9 steps)
%   the default for range is ':' which is all
% returns pore water velocity average result, and convert it as a matrix
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  % p_bol c_bol and s_bol determines which variable to do the average
  [qin_bol,  varargin]   = getWord(varargin,'qin');
  [uucut_bol,  varargin] = getWord(varargin,'uucut');
  [qu_bol,  varargin]    = getWord(varargin,'qu');
  [fromto,  varargin]    = getProp(varargin,'range',':');

  if qin_bol
      %  https://au.mathworks.com/matlabcentral/answers/78878-cellfun-can-not-combines-the-outputs-in-arrays-even-the-outputs-have-the-same-size
      aa=arrayfun(@(y) y.qin,o.data(fromto),'un',0);
  elseif uucut_bol
      aa=arrayfun(@(y) y.uucut,o.data(fromto),'un',0);
  elseif qu_bol
      aa=arrayfun(@(y) y.qu,o.data(fromto),'un',0);
  end
      opt=mean(cat(2,aa{:}),2);
      %opt=aa;


