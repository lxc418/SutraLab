function o=getNextLine(varargin)
% getNextLine get the next line of the file based on the keyword and criteria.
% if search ends up to the end of the file, function returns -1.
% Arguments:
%         'keyword'   --  the keyword to search at the beginning of the line
%         'criterion' --  Can be 'with', 'without' or 'equal'
%                         'with'  find the line start with the keyword
%                         'without' find the line started without the keyword
%                         'equal' find out the NEXT line of one line that equals
%                                 the given keyword 
%         'operation' --  Can be 'delete' (only works when 'criterion'='with')
%                         delete the keyword from the extracted line
%         'ignoreblankline' -- can be 'yes' or 'no'
%                         if 'yes' under 'without' criterion, the lines with
%                         full spaces or empty lines will be ignored
%                         Such funtion is created as SUTRA can smartly ignore
%                         empty lines in INP file (i.e., empty line is the same
%                         as comment line) TO 150904
% Examples:
% line=getNextLine(fn,'criterion','with','keyword','##','operation','delete');
%    purpose: find line from the file handled by fn with line started with '##'.
%    once found, delete the starting '##'
% line=getNextLine(fn,'criterion','without','#')
%    Goal: find the first non-commented line ( with commentting notation as '#')
%  o2.str2      =getNextLine(fn,'criterion','equal','keyword','## ');
%    Goal: omit all lines that are same as '## ' and return the first line not
%         the same as '## '
% if 'ceriterion' is set as 'with'
%   function returns to a line match with the keyword
% if 'ceriterion' is set as 'without'
%   function returns to a line that does not start with keyword
% read next line that is not started from '#'
% fn  -- file handle
% keywords -- should be hatchk
% TO 06/07/15 


  [fn, varargin] = getNext(varargin,'double','');
  % an option to see whether use inp contents to guide the reading process
  %   a hard reading process will be conducted if left empty
  [criterion,  varargin] = getProp(varargin,'criterion',[]);
  [keyword  ,  varargin] = getProp(varargin,'keyword'  ,[]);
  [operation,  varargin] = getProp(varargin,'operation',[]);
  [ignoreblankline,varargin] = getProp(varargin,'ignoreblankline','no');
  

  o=fgetl(fn);
  kw_length=length(keyword);


  if strcmp(ignoreblankline,'yes')
      isblankline=CheckIfBlankLine(o);
  elseif strcmp(ignoreblankline,'no')
      isblankline=0;
  end


  if strcmpi(criterion,'without')
     while strcmp(o(1:min(kw_length,length(o))), keyword) || isblankline
       o=fgetl(fn);

       if strcmp(ignoreblankline,'yes')
           isblankline=CheckIfBlankLine(o);
       elseif strcmp(ignoreblankline,'no')
           isblankline=0;
       end


       if o==-1 
         fprintf(1,'Search up to the end of the file\n');
	 return
       end

     end
  elseif strcmpi(criterion,'equal')
     while ~strcmp(o,keyword)
       o=fgetl(fn);
       if o==-1 
         fprintf(1,'Search up to the end of the file\n');
	 return 
       end
     end
     o=fgetl(fn);
  elseif strcmpi(criterion,'with')
     while ~strcmp(o(1:min(kw_length,length(o))), keyword)
       o=fgetl(fn);
       if o==-1 
         fprintf(1,'Search up to the end of the file\n');
	 return
       end
     end

     if strcmp(operation,'delete')
       o=o(length(keyword)+1:end);
     end
  end
end % function

