function o=CheckIfBlankLine(inp)
%   function o=CheckIfBlankLine(inp)
%   it checks if the input string is either one with spaces or empty.
%   if the string is empty or full of spaces, it returns 1
%   if there is any non-space character, it returns 0
%   this command is created as INP file in SUTRA can smartly ignore 
%     one line that is empty
   if isempty(inp) || length(inp)==sum(isspace(inp))
     o=1;
   else
     o=0;
   end



