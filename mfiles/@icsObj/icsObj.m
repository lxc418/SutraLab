classdef icsObj <handle
% the handle is important as it updates the values when modified
% http://au.mathworks.com/help/matlab/matlab_oop/comparing-handle-and-value-classes.html
% sw_
  properties
    % the following list are associated with property defination
    % http://stackoverflow.com/questions/7192048/can-i-assign-types-to-class-properties-in-matlab
    % http://undocumentedmatlab.com/blog/setting-class-property-types
    % block_reading 
    % now only key data are stored in vapinpObj, other non-relevant data will all be 
    % wiped out 

    % if one wish to convert from class to truct due to reasons like jasn file 
    %   one can use a=struct(vapinpObj)
    %        ML=0 FOR P AND U, ML=1 FOR P ONLY, AND ML=2 FOR U ONLY.         SUTRA........27900
    fname

    % varagin stores all the input parameters
    varargin cell;
    
    %   inp should later be removed now it is here for storing all strings extracted
    %     from the file
    inp

    % NOTICE TO DEVELOPERS:
    %   please make sure that all decleared varables here are in accordance with 
    %    Original SUTRA code for the convinence of 1. better understanding of the 
    %    original code (input are in indat1 and indat2) and 2. make code consistent
    %   A comment can be made after the name declaration 
    transpose
    mtx_transpose

    % this is a switch to enable blockreading for dataset 14 -20
    % because reading lines by lines is a bit too slow
    sw_block_reading

    sw_read_from_file
    % ---------------  DATASET 1 variable declaration--------------------
    title1   
    title2
    nnv

    tics
    cpuni    % pressure format
    cuuni    % concentration format
    ctuni    % temperature format

    pm1      % initial pressure
    um1      % initial concentration
    tm1      % initial temperature
   
    pm1_mtx
    um1_mtx
    tm1_mtx
    nn
    ne


  end
  
  
  properties (Access=protected)
  c ,d
  end

  properties (Dependent=true)
  % these values are only called when input are changed
  %   a, b, c ,d, e,
  %nns
  end

  methods    % seems that all functions in methods needs to be called.
    function o=icsObj(varargin)
        %% a string storing the caller functions
        caller = dbstack('-completenames'); caller = caller.name;
      
        o2.varargin       = varargin;
      
        [o.fname, varargin] = getNext(varargin,'char','');
        [inp,  varargin]      = getProp(varargin,'inpObj',[]);
        [o.sw_read_from_file,  varargin] = getProp(varargin,'read_from_file','yes');
      
        if strcmpi(o.sw_read_from_file,'yes')
          fn                       = fopen([o.fname,'.ICS']);
          if fn==-1
            fprintf(1,'%s : Trying to open %s .ics\n',caller,o.fname);
            fn=fopen([o.fname,'.ics']);
            if fn==-1 
                fprintf(1,'%s : Trying to open %s (without adding extention name)\n',caller,o.fname);
                fn=fopen(o.fname);
            end
            if fn==-1
              fprintf('%s: file ics found!!\n',caller,o.fname);
              o=-1;o2=-1;
              return
            end
          end
        
          o.nn=inp.nn;
          o.ne=inp.nn;
          temp=textscan(fn,'%d',1);
          o.tics=temp{1};
          temp=textscan(fn,'%s',1);
          temp=regexprep(temp{1}{1},'''','');
          o.cpuni=temp;
        
        
          temp=textscan(fn,'%f',inp.nn);
          o.pm1=temp{1};
        
        
          temp=textscan(fn,'%s',1);
          temp=regexprep(temp{1}{1},'''','');

          o.cuuni=temp;
       
          temp=textscan(fn,'%f',inp.nn);
          o.um1=temp{1};
        end

      end % Function constructor

       function nnv=get.nnv(o)
         % it is working the same time as others, which is not a procedural way.
	 % everytime when o.a is changing, nnv is changing.
         nnv=o.a+1; 
       end

   end  % end methods

   methods

  function mtx_transpose=get.mtx_transpose(o) 
  if isempty(o.mtx_transpose) % give a initial result
      mtx_transpose='no';
  else

 mtx_transpose  = o.mtx_transpose; 
  end
  end
  function o=set.mtx_transpose(o,varargin), o.mtx_transpose  = varargin{1}; end

   end % methods

  % http://stackoverflow.com/questions/27729618/define-method-in-a-separate-file-with-attributes-in-matlab
  methods (Access=private)
    opt=convert_2_mtx(o,varargin)
  end  % private methods
   methods(Static)
     function nns = nnns(o)
       % it is working the same time as others, which is not a procedural way.
       % everytime when o.a is changing, nnv is changing.
       nns.nns = o.a+7;
     end % function
   end % methods (static)
end % classdef
