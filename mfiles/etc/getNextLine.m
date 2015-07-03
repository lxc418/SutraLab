function line=getNextLine(varargin)
% line=readnext(filehandle,'cerierion','with','')
% if 'ceriterion' is set as 'with'
%   function returns to a line match with the keyword
% if 'ceriterion' is set as 'without'
%   function returns to a line that does not start with keyword
% read next line that is not started from '#'
% fn  -- file handle
% keywords -- should be hatchk

  [fn, varargin] = getNext(varargin,'double','');
  % an option to see whether use inp contents to guide the reading process
  %   a hard reading process will be conducted if left empty
  [criterion,  varargin] = getProp(varargin,'criterion',[]);
  [keyword,  varargin]   = getProp(varargin,'keyword',[]);
  [operation,  varargin] = getProp(varargin,'operation',[]);
  
  if strcmp(criterion,'without')
     line=fgetl(fn);
     while strcmp(line(length(keyword)), keyword)
       line=fgetl(fn);
     end
  elseif strcmp(criterion,'with')
  end
end % function

