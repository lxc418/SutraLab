classdef eleObj <handle
    properties
        mtx_transpose

        varargin
        output_no
        title1
        title2
        MeshInfo
        ne1   % ne1 always equals nn1-1. it is written as nn1-1 in SUTRA OUTELE
        ne2
        ne
        nn
        mshtyp
        ktprn
        itt
        tt
        cpvx
        isvx
        cpvy
        isvy
        cpvz
        isvz



        data
        transpose

        e_idx
        x_idx
        y_idx
        z_idx
        vx_idx
        vy_idx
        vz_idx
        
        x_mtx
        y_mtx
        z_mtx
    end

    properties (Access=protected)
        c ,d
    end
    
    properties (Dependent=true)
    % these values are only called when input are changed
    %   a, b, c ,d, e,
    %nns
    end

  methods
    function o = eleObj(varargin)
      % readELE reads ELE file   
      %
      % INPUT
      %   filename     -- if file is named as 'abc.ele', a filename='abc'
      %                   is required
      %   outputnumber -- number of result extracted, this is useful when
      %                   output file is huge
      %   outputstart  -- (not implimented yet) the start of the result
      %
      % OUTPUT
      % o  -- a struct the same size as the number of output.
      % o2 -- a struct extracting headers with the extraction inf
      %
      % Example:
      % [eledata,elehead]=readELE('project','outputnumber',3);
      %    Purpose: parsing 'project.ele' (or 'project.ELE')
      %            only the first three result gets extracted
    
      % a string storing the caller functions
      caller = dbstack('-completenames'); caller = caller.name;
    
      o.varargin       = varargin;
      [fname, varargin] = getNext(varargin,'char','');
        [o.mtx_transpose,  varargin] = getProp(varargin,'mtx_transpose','no');
      % an option to see whether use inp contents to guide the reading process
      % a hard reading process will be conducted if left empty
      [output_no,  varargin]   = getProp(varargin,'outputnumber',0);
      [output_from,  varargin] = getProp(varargin,'outputfrom',0);
      [inpObj,  varargin]      = getProp(varargin,'inpObj',[]);
      o.output_no             = output_no;
      fn                       = fopen([fname,'.ELE']);
    
      if fn==-1 
        fprintf(1,'%s : Trying to open %s .ele\n',caller,fname);
        fn=fopen([fname,'.ele']);
        if fn==-1
          fprintf('%s: file ele found!!\n',caller,fname);
          o=-1;o2=-1;
          return
        end
      end
      
      o.title1 = getNextLine(fn,'criterion',...
                             'with','keyword','## ','operation','delete');
      o.title2 = getNextLine(fn,'criterion',...
                             'with','keyword','## ','operation','delete');
    
      % ---------------- Parsing the line with node, element info-----------------
      o.MeshInfo =getNextLine(fn,'criterion','equal','keyword','## ');
      tmp=regexprep(o.MeshInfo,{'#','(',')','\,','*','='},{'','','','','',''});
      tmp=textscan(tmp,'%s %s %s %f %f %f %*s %f %*s');
      % how to realize this by one-liner
      %  [o.mshtyp{1} o.mshtyp{2} ] = deal(tmp{1:2}{1});
      [o.ne1,o.ne2,o.ne,o.nn ]    = deal(tmp{4:7});
      o.mshtyp{1}                    = tmp{1}{1};
      o.mshtyp{2}                    = tmp{2}{1};
    
      % ---------------- parsing the number of results    ------------------------
      tmp = getNextLine(fn,'criterion','with','keyword',...
                     '## VELOCITY RESULTS','operation','delete');
      tmp           = textscan(tmp,'%f ');
      o.ktprn      = tmp{1};  % expected no. time steps
      if output_no ~= 0;
        output_no   = min(o.ktprn,output_no);
      else
        output_no = o.ktprn;
      end
    
      % ---------------- parsing expected results    ----------------------------
      % Refering to OUTELE.......19900
      tmp       = getNextLine(fn,'criterion','with','keyword','##   --');
      tmp_table = textscan(fn,'##  %f %f %s %f %s %f %s %f ',o.ktprn);
      [o.itt,o.tt,o.cpvx,o.isvx,o.cpvy,o.isvy,o.cpvz,o.isvz]=...
        deal(tmp_table{:});
    
      % ---------------- Parsing simulation results -----------------------------
      fprintf(1,'%s is parsing the %g of %g outputs\n', caller,output_no,o.ktprn);
      for n=1:output_no
        fprintf('.');
        if rem(n,50)==0; fprintf('%d\n',n);   end
        tmp       = getNextLine(fn,'criterion','with','keyword','## TIME STEP');
        if tmp  ~= -1
          tmp = regexprep(tmp,{'## TIME STEP','Duration:','sec','Time:'}...
                        ,{'','','',''});
          tmp   = textscan(tmp,'%f %f %f');
          [ o.data(n).itout,o.data(n).durn,o.data(n).tout] = deal(tmp{:});
    
    
                    
          tmp = getNextLine(fn,'criterion','without'...
                        ,'keyword','## ==');                
          % remove '## ' at the beginning
          tmp=tmp(4:end);
    %        % a mask matrix for tmp indicating blank space ' '(i.e., white space)
    %        tmp_blank_mask=tmp==' ';
    % %       % a mask matrix indicating the location of a blank whose both
    % %       % neighbours are alphabetics. such effort is to change a pattern
    % %       % 'X origin' to 'X_origin'
    % %       % if not, 
    % %       tmp_singleblank_mask=strfind(tmp_blank_mask,[0 1 0])+1;
    % %       
    % %       tmp(tmp_singleblank_mask)='_';
    % %       tmp        = textscan(tmp,'%s'   );
    %        %       o(n).string=tmp;    
    %        % I also have tried the following 
    %        tmp_blanks_mask=find(tmp_blank_mask(1:end-1)+tmp_blank_mask(2:end)==2);
    %        tmp(tmp_blanks_mask)='#';
    % 
    % 
    %        % tmp=regexprep(tmp,' +','#');
    %        % tmp2(cc)='_'
    %        % but there is a problem where all words starts with a space
    %        % a mask matrix for tmp indicating blank space ' '(i.e., white space)
    %        %  tmp_blank_mask=tmp==' ';
    %        
    %        %find(tmp_blank_mask(1:end-1)==1 && tmp_blank_mask(2:end)==1)
    %        tmp        = textscan(tmp,'%s','delimiter','#'   );       
    % 
    %       % http://au.mathworks.com/matlabcentral/answers/27042-how-to-remove-empty-cell-array-contents
    %       tmp=tmp{1}';
    %       o(n).label = tmp(~cellfun('isempty',tmp))  ;
          o.data(n).label = getOutputLabelName( tmp );
          fmt        = repmat('%f ',1, length(o.data(n).label));
          o.data(n).terms = textscan(fn,fmt,o.nn);
        else
          fprintf(1,['WARNING FROM %s: Simulation is not completed\n %g'...
                 'out of %g outputs extracted\n'],caller,n,o.ktprn);
          return
        end % if condition
      end  % n loops
      fprintf('%s: Parsed %g of %g outputs\n', caller,output_no,o.ktprn);
  end % constructor function
    function e_idx=get.e_idx(o), e_idx  = find(strcmp(o.data(1).label,'Element')); end
    function x_idx=get.x_idx(o), x_idx  = find(strcmp(o.data(1).label,'X origin')); end
    function y_idx=get.y_idx(o), y_idx  = find(strcmp(o.data(1).label,'Y origin')); end
    function z_idx=get.z_idx(o), z_idx  = find(strcmp(o.data(1).label,'Z origin')); end
    function vx_idx=get.vx_idx(o), vx_idx  = find(strcmp(o.data(1).label,'X velocity')); end
    function vy_idx=get.vy_idx(o), vy_idx  = find(strcmp(o.data(1).label,'Y velocity')); end
    function vz_idx=get.vz_idx(o), vz_idx  = find(strcmp(o.data(1).label,'Z velocity')); end
    end
  methods
    function mtx_transpose=get.mtx_transpose(o) 
      if isempty(o.mtx_transpose) % give a initial result
          mtx_transpose='no';
      else
          mtx_transpose  = o.mtx_transpose; 
      end
    end
    
    
    function o=set.mtx_transpose(o,varargin), o.mtx_transpose  = varargin{1}; end

    end % construction method

    % http://stackoverflow.com/questions/27729618/define-method-in-a-separate-file-with-attributes-in-matlab
  

  methods (Access=private)
    opt=convert_2_mtx(o,varargin)
  end  % private methods
  end %class

