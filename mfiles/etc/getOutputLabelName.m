function  o  = getOutputLabelName( pt )
%function o  = getOutputLabelName( pt ) extracts keywords from input string
%  and return them separately to the output as a cell.
%  the tricky part for this function is that it is able to catch a property
%  name that are separated by space ' '. For example, in .ELE file,
%  property  'X origin', 'Y origin', 'X velocity, 'Y velocity' are all
%  separated by space.
%  called by readELE and readNOD

       % a mask matrix for tmp indicating blank space ' '(i.e., white space)
       tmp_blank_mask=pt==' ';
%       % a mask matrix indicating the location of a blank whose both
%       % neighbours are alphabetics. such effort is to change a pattern
%       % 'X origin' to 'X_origin'
%       % if not, 
%       tmp_singleblank_mask=strfind(tmp_blank_mask,[0 1 0])+1;
%       
%       tmp(tmp_singleblank_mask)='_';
%       tmp        = textscan(tmp,'%s'   );
       %       o(n).string=tmp;    
       % I also have tried the following 
       tmp_blanks_mask=find(tmp_blank_mask(1:end-1)+tmp_blank_mask(2:end)==2);
       tmp=pt; % input can not be changed.
       tmp(tmp_blanks_mask)='#';
       % tmp=regexprep(tmp,' +','#');
       % tmp2(cc)='_'
       % but there is a problem where all words starts with a space
       % a mask matrix for tmp indicating blank space ' '(i.e., white space)
       %  tmp_blank_mask=tmp==' ';
       
       %find(tmp_blank_mask(1:end-1)==1 && tmp_blank_mask(2:end)==1)
       tmp        = textscan(tmp,'%s','delimiter','#'   );       

      % http://au.mathworks.com/matlabcentral/answers/27042-how-to-remove-empty-cell-array-contents
      tmp=tmp{1}';
      o = tmp(~cellfun('isempty',tmp))  ;

end

