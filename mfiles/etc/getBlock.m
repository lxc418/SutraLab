function [o,k]=getBlock(varargin)
% function [o,k]=getBlock(varargin)
% getBlock reads a block of text and end with one line that start with special
%           keyword specified
% Outputs :
%        o   -- output block
%        k   -- number of lines in the output block
%
% Arguments:
%         'keyword'   --  the keyword to search at the beginning of the line
%         'criterion' --  Can be 'with', 'without' or 'equal'
%                         'with'  find the line start with the keyword
%                         'without' find the line started without the keyword
%                         'equal' find out the NEXT line of one line that equals
%                                 the given keyword 
%                         (not implimented)
%         'operation' --  Can be 'delete' (only works when 'criterion'='with')
%                         delete the keyword from the extracted line
%                         (not implimented)
% Examples:
%        [tmp o2.bcop] = getBlock(fn,'keyword','#');
%         Goal: it reads a file handled by fn, from the point where it is called
%                 to a line starting from '#'

  [fn       ,  varargin] = getNext(varargin,'double','');
  [keyword  ,  varargin] = getProp(varargin,'keyword',[]);
  

  tmp=fgets(fn);
  o=tmp;
  kw_length=length(keyword);
  k=1;
  while ~strcmp(tmp(1:kw_length), keyword)
    k   = k+1;
    tmp = fgets(fn);
    o   = [o, tmp];
    if tmp == -1
      fprintf(1,'Search up to the end of the file\n');
      return
    end
  end

  return
end % function

