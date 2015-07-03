function line=getNextLine(fn,keywords)
% line=readnext(fn,keywords)
% read next line that is not started from '#'
% fn  -- file handle
% keywords -- should be hatch
     line=fgetl(fn);
     while  line(1)=='#'
       line=fgetl(fn);
     end
end % function

