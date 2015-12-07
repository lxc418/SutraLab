classdef inpObj <handle
% the handle is important as it updates the values when modified
% http://au.mathworks.com/help/matlab/matlab_oop/comparing-handle-and-value-classes.html
  properties
    % the following list are associated with property defination
    % http://stackoverflow.com/questions/7192048/can-i-assign-types-to-class-properties-in-matlab
    % http://undocumentedmatlab.com/blog/setting-class-property-types
    
    % now only key data are stored in vapinpObj, other non-relevant data will all be 
    % wiped out 

    % if one wish to convert from class to truct due to reasons like jasn file 
    %   one can use a=struct(vapinpObj)
    %        ML=0 FOR P AND U, ML=1 FOR P ONLY, AND ML=2 FOR U ONLY.         SUTRA........27900

    % varagin stores all the input parameters
    varargin@cell;
    
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

    % ---------------  DATASET 2B variable declaration--------------------
    %   matlab stats that, string array should be declared as cells
    %    mshtyp   = char(2,10)   
    %   http://stackoverflow.com/questions/7100841/create-an-array-of-strings
    ktype=zeros(1,2)   % ktype(1) determines the dimension of the system
                       %   ktype(1)  == 2 , 2D problem
		       %   ktype(1)  ==  3 , 3D problem
                       % ktype(2) dettermines the type of mesh
		       %   ktype(2) ==
         %.....ktype set according to the type of finite-element mesh:            
         %        2d mesh          ==>   ktype(1) = 2                             
         %        3d mesh          ==>   ktype(1) = 3                             
         %        irregular mesh   ==>   ktype(2) = 0                             
         %        layered mesh     ==>   ktype(2) = 1                             
         %        regular mesh     ==>   ktype(2) = 2                             
         %        blockwise mesh   ==>   ktype(2) = 3                             
    mshtyp@cell=repmat({''},2,1)     % mesh type
    nn1  % -- number of node in the first direction
    nn2  % -- number of node in the second direction
    nn3  % -- number of node in the third direction
    %  ---------------------- DATASET 3  ------------------------
    nn   % -- number of node 
    ne   % -- number of element
    npbc 
    nubc 
    nsop 
    nsou 
    nobs 
    %   dataset1       = repmat({''},1,2);
    %    e             = char(23);
    %    e@char(20)
    % ---------------  DATASET 4 simulation Model options ---------------
    cunsat
    cssflo
    csstra
    cread
    istore

    % ---------------  DATASET 5 Numerical control parameters ---------------
    up
    gnup
    gnuu


    % ---------- DATASET 6:  Temporal Control and Solution Cycling Data
    nsch
    npcyc
    nucyc


    % ---------------  DATASET 6A variable declaration--------------------
    scalt 
    ntmax 
    timei 
    timel 
    timec 
    ntcyc 
    tcmult
    tcmin 
    tcmax 

    % ---------------##  DATASET 7:  Iteration and Matrix Solver Controls
    itrmax 
    rpmax 
    rumax

    % ---------------   DATASET 7B ------------------------------------
    csolvp
    itrmxp
    tolp

    % ---------------   DATASET 7C ------------------------------------
    csolvu
    itrmxu
    tolu


    % ---------------  DATASET 8A variable declaration--------------------
    nprint  
    cnodal
    celmnt  
    cincid  
    cpands    
    cvel   
    ccort    
    cbudg   
    cscrn  
    cpause

    
    % ---------------  DATASET 8B variable declaration--------------------
    ncolpr
    ncol

    % ---------------  DATASET 8C variable declaration--------------------
    lcolpr
    lcol

    % ---------------  DATASET 8D variable declaration--------------------
    nbcfpr
    nbcspr
    nbcppr
    nbcupr
    cinact

    % ---------------  DATASET 9  variable declaration--------------------
    compfl           
    cw       
    sigmaw
    rhow0
    urhow0
    drwdu 
    visc0 
    dvidu

    % ---------------  DATASET 10 variable declaration--------------------
    compma
    cs
    sigmas
    rhos

    % ---------------  DATASET 11 variable declaration--------------------
    adsmod
    chi1
    chi2

    % ---------------  DATASET 12 variable declaration--------------------
    prodf0
    prods0
    prodf1
    prods1


    %  DATASET 13:  Orientation of Coordinates to Gravity
    gravx
    gravy
    gravz

    % ---------------  DATASET 14 variable declaration--------------------
    scalx  
    scaly  
    scalz  
    porfac 

    nreg
    x
    y
    z
    por

    por_actual
    % ---------------  DATASET 15 variable declaration--------------------
    pmaxfa
    pminfa 
    angfac
    almaxf
    alminf
    atmaxf
    atminf   

    lreg
    pmax
    pmin
    anglex
    almax
    almin
    atmax
    atmin 

    % required by 3D case
    pmidfa
    ang1fa
    ang2fa
    ang3fa
    almidf
    atmidf
    
    pmid
    angle1
    angle2
    angle3
    almid
    atmid
    % ---------------  DATASET 17 variable declaration--------------------
    iqcp
    qinc
    uinc
    % ---------------  DATASET 19 variable declaration--------------------
    ipbc
    pbc
    ubc
    % ---------------  DATASET 20 variable declaration--------------------
    % ---------------  DATASET 22 variable declaration--------------------
    ll
    iin1
    iin2
    iin3
    iin4
    iin5
    iin6
    iin7
    iin8
    
    
    % examples to declear cells and structs in properties
    %    dtst@cell=repmat({''},22,1)
    %    dtst{1}@cell=repmat({''},2,1)   % how to do this
    %    dtst{2}@cell=repmat({''},2,1)
    %    dtst1@cell=repmat({''},2,1)
    %    dtst2@cell=repmat({''},2,1)
    %    dtst8@cell=repmat({''},4,1)
    %    dtst9@char
    e=char(14)   %  this is working now but the 14 means have 14 strings
    %    f=char(2,4)   %  this is working now but the 14 means have 14 strings
    g=cell(2,4)   %  this is working now but the 14 means have 14 strings
    %    h{1}=repmat({''},2,1)
    %    h{2}=repmat({''},2,1)
    %            'dtst1'   ,{'title1';'title2'},...
    nnv
    dx_cell_mtx
    dy_cell_mtx
    x_nod_mtx
    y_nod_mtx
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
    function o=inpObj(varargin)
      % vapinpObj constructor
    [o.mtx_transpose,  varargin] = getProp(varargin,'mtx_transpose','no');
      caller=dbstack('-completenames'); caller=caller.name;
      o.varargin        = varargin;
      [fname, varargin] = getNext(varargin,'char','');
      [read,  varargin] = getProp(varargin,'operation',[]);

      % ---------------       DATASET 1    -------------------------
      fn=fopen([fname,'.INP']);
      if fn==-1 
        fprintf(1,'Trying to open %s .inp\n',fname);
        fn=fopen([fname,'.inp']);
        if fn==-1
          fprintf('%s: file nod found!!\n',caller,fname);
          return
        end
      end
      o.inp.dataset1a=getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      o.inp.dataset1b=getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      % ---------------       DATASET 2A   -------------------------
      o.inp.dataset2a=getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      % ---------------       DATASET 2B   -------------------------
      o.inp.dataset2b=getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      % remove single quote
      strprc      = regexprep(o.inp.dataset2b,'''','');
      % find if it is (1) 2D (3) 3D
      tmp         = textscan(strprc,'%s ');

      if strcmpi(tmp{1}{1},'2D')
        o.ktype(1)  = 2;
        tmp         = textscan(strprc,'%s %s %s %f %f');
        o.mshtyp(1) = tmp{1};
        o.mshtyp(2) = tmp{2};
        o.nn1       = tmp{4};
        o.nn2       = tmp{5};
      elseif strcmpi(tmp{1}{1},'3D')
        o.ktype(1)  = 3;
        tmp         = textscan(strprc,'%s %s %s %f %f %f');
        o.mshtyp(1) = tmp{1};
        o.mshtyp(2) = tmp{2};
        o.nn1       = tmp{4};
        o.nn2       = tmp{5};
        o.nn3       = tmp{6};
	% get relationships
	for n = 1:o.ktype(1)
          strprc = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
          tmp = textscan(strprc,'%s ');
	  fmt = repmat('%f ' , 1, str2num(tmp{1}{1})+1);
	  tmp = textscan(strprc,fmt);
        end
      end
      % ---------------       DATASET 3    -------------------------
      o.inp.dataset3 = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str            = textscan(o.inp.dataset3,'%f %f %f %f %f %f %f');
      o.nn           = str{1};
      o.ne           = str{2};
      o.npbc         = str{3};
      o.nubc         = str{4};
      o.nsop         = str{5};
      o.nsou         = str{6};
      o.nobs         = str{7};
      
      % ---------------       DATASET 4    -------------------------
      o.inp.dataset4=getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str      = regexprep(o.inp.dataset4,'''','');
      str      = textscan(str,'%s %s %s %s %f');
      o.cunsat = str{1}{1};
      o.cssflo = str{2}{1};
      o.csstra = str{3}{1};
      o.cread  = str{4}{1};
      o.istore = str{5};
      
      % ---------------       DATASET 5    -------------------------
      o.inp.dataset5 = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str      = textscan(o.inp.dataset5,'%f %f %f');
      [o.up,o.gnup,o.gnuu] =deal(str{1:3});
      
      
      % ---------------       DATASET 6a   -------------------------
      o.inp.dataset6a = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str      = textscan(o.inp.dataset6a,'%f %f %f');
      [o.nsch,o.npcyc,o.nucyc] =deal(str{1:3});


      % ---------------       DATASET 6b    -------------------------
      o.inp.dataset6b = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str = textscan(o.inp.dataset6b,'%s %s %s %s %f %f %f %f %f %f %f %f %f ');
      o.scalt  = str {5};
      o.ntmax  = str {6};
      o.timei  = str {7};
      o.timel  = str {8};
      o.timec  = str {9};
      o.ntcyc  = str {10};
      o.tcmult = str {11};
      o.tcmin  = str {12};
      o.tcmax  = str {13};

      o.inp.dataset6c = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      % ---------------       DATASET 7A   -------------------------
      o.inp.dataset7a = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str      = textscan(o.inp.dataset7a,'%f %f %f');
      [o.itrmax,o.npcyc,o.nucyc] =deal(str{1:3});
      
      % ---------------       DATASET 7B   -------------------------
      o.inp.dataset7b = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str      = regexprep(o.inp.dataset7b,'''','');
      str      = textscan(str,'%s %f %f');
      o.csolvp =str{1}{1};
      [o.itrmxp,o.tolp] =deal(str{2:3});
      
      % ---------------       DATASET 7C   -------------------------
      o.inp.dataset7c = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str      = regexprep(o.inp.dataset7c,'''','');
      str      = textscan(str,'%s %f %f');
      o.csolvu =str{1}{1};
      [o.itrmxu,o.tolu] =deal(str{2:3});
      
      % ---------------       DATASET 8A   -------------------------
      o.inp.dataset8a = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      strprc          = regexprep(o.inp.dataset8a,'''','');
      str             = textscan(strprc,'%f %s %s %s %s %s %s %s %s %s');
      o.nprint        = str{1} ;
      o.cnodal        = str{2}{1};
      o.celmnt        = str{3}{1};
      o.cincid        = str{4}{1};
      o.cpands        = str{5}{1};
      o.cvel          = str{6}{1};
      o.ccort         = str{7}{1};
      o.cbudg         = str{8}{1};
      o.cscrn         = str{9}{1};
      o.cpause        = str{10}{1};
      % ---------------       DATASET 8B   -------------------------
      o.inp.dataset8b = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      strprc          = regexprep(o.inp.dataset8b,'''',''); % remove alpostrophe
      strprc          = strtrim(strprc); % remove heading and tailing speces
      str             = regexp(strprc, '\s+','split'); % find multiple spaces ('\s+')  and make separations ('split')
      o.ncolpr=str2num(str{1});
      for i=1:length(str)-1
          o.ncol{i}=str{i+1};
      end

      % ---------------       DATASET 8C   -------------------------
      o.inp.dataset8c = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      strprc          = regexprep(o.inp.dataset8c,'''','');
      str             = textscan(strprc,'%f %s %s %s ');
      o.lcolpr=str{1};
      strprc          = regexprep(o.inp.dataset8c,'''',''); % remove alpostrophe
      strprc          = strtrim(strprc); % remove heading and tailing speces
      str             = regexp(strprc, '\s+','split'); % find multiple spaces ('\s+')  and make separations ('split')
      for i=1:length(str)-1
          o.lcol{i}=str{i+1};
      end
      % ---------------       DATASET 8D   -------------------------
      o.inp.dataset8d = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      strprc          = regexprep(o.inp.dataset8d,'''','');
      str             = textscan(strprc,'%f %f %f %f %s');
      o.nbcfpr        = str{1};
      o.nbcspr        = str{2};
      o.nbcppr        = str{3};
      o.nbcupr        = str{4};
      o.cinact        = str{5}{1};
      
      % ---------------       DATASET 9    -------------------------
      o.inp.dataset9  = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str= textscan(o.inp.dataset9,'%f %f %f %f %f %f %f %f ');
      [o.compfl,o.cw,o.sigmaw,o.rhow0,o.urhow0,o.drwdu,o.visc0,o.dvidu] =deal(str{1:8});

      
      % ---------------       DATASET 10   -------------------------
      o.inp.dataset10 = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str= textscan(o.inp.dataset10,'%f %f %f %f ');
      [o.compma,o.cs,o.sigmas,o.rhos ] =deal(str{1:4});
      
      % ---------------       DATASET 11   -------------------------
      o.inp.dataset11 = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      strprc          = regexprep(o.inp.dataset11,'''',''); % remove alpostrophe
      strprc          = strtrim(strprc); % remove heading and tailing speces
      str             = regexp(strprc, '\s+','split'); % find multiple spaces ('\s+')  and make separations ('split')
      o.adsmod =str{1};
      if strcmpi(o.adsmod,'solid')
          o.chi1=str2num(str{2});
          o.chi2=str2num(str{3});
      elseif strcmpi(o.adsmod,'FREUNDLICH')
          o.chi1=str2num(str{2});
          o.chi2=str2num(str{3});
      end

      % ---------------       DATASET 12   -------------------------
      o.inp.dataset12 = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      str             = textscan(strprc,'%f %f %f %f ');
      [o.prodf0,o.prods0,o.prodf1,o.prods1]=deal(str{1:4});

      % ---------------       DATASET 13   -------------------------
      o.inp.dataset13 = getNextLine(fn,'criterion','without','keyword','#','ignoreblankline','yes');
      if strcmpi(o.mshtyp{1},'2D')
          str = textscan(o.inp.dataset13,'%f %f');
          [o.gravx,o.gravy]=deal(str{1:2});
      elseif strcmpi(o.mshtyp{1},'3D')
          str = textscan(o.inp.dataset13,'%f %f %f');
          [o.gravx,o.gravy,o.gravz]=deal(str{1:3});
      end

      % ---------------       DATASET 14   -------------------------
      o.inp.dataset14a = getNextLine(fn,'criterion','with','keyword',...
                              '''NODE''','operation','delete');
      str      = textscan(o.inp.dataset14a,'%f %f %f %f');
      o.scalx  = str{1};
      o.scaly  = str{2};
      o.scalz  = str{3};
      o.porfac = str{4};


      o.nreg=zeros(1,o.nn);
      o.x=zeros(1,o.nn);
      o.y=zeros(1,o.nn);
      o.z=zeros(1,o.nn);
      o.por=zeros(1,o.nn);
      o.inp.dataset14b = '';
      for n = 1:o.nn
        str=getNextLine(fn,'criterion','without','keyword',...
                              '#','ignoreblankline','yes');
        o.inp.dataset14b= [o.inp.dataset14b str];

        tmp=textscan(str, '%f %f %f %f %f %f');
        o.nreg(n)=tmp{2};
        o.x(n)=tmp{3}*o.scalx;
        o.y(n)=tmp{4}*o.scaly;
        o.z(n)=tmp{5}*o.scalz;
        o.por(n)=tmp{6};
      end
        o.por_actual=o.por*o.porfac;
      % ---------------       DATASET 15   -------------------------
      o.inp.dataset15a = getNextLine(fn,'criterion','with','keyword',...
                              '''ELEMENT''','operation','delete');
      o.inp.dataset15b = '';
       
      if  strcmp(o.mshtyp{1},'2D')
        tmp=textscan(o.inp.dataset15a,'%f %f %f %f %f %f %f ') ;
        [o.pmaxfa,o.pminfa,o.angfac,o.almaxf,o.alminf,o.atmaxf,o.atminf]=deal(tmp{1:7});
        for n =1:o.ne
            tmp=getNextLine(fn,'criterion','without','keyword',...
                              '#','ignoreblankline','yes');
            o.inp.dataset15b= [o.inp.dataset15b tmp];
            tmp=textscan(tmp,'%*u %u %f %f %f %f %f %f %f') ;
            [ o.lreg(n),o.pmax(n),o.pmin(n),o.anglex(n) ,o.almax(n) ,o.almin(n)...
                ,o.atmax(n),o.atmin(n)]=deal(tmp{1:8});
        end
        o.pmax=o.pmax*o.pmaxfa;
        o.pmin=o.pmax*o.pminfa;
        o.anglex=o.anglex*o.angfac;
        o.almax=o.almax*o.almaxf;
        o.almin=o.almin*o.alminf;
        o.atmax=o.atmax*o.atmaxf;
        o.atmin=o.atmin*o.atminf;

      elseif strcmp(o.mshtype{1},'3D')
        tmp=textscan(o.inp.dataset15a,'%*s %f %f %f %f %f %f %f %f %f %f %f %f') ;
        [o.pmaxfa,o.pmidfa,o.pminfa,o.ang1fa,o.ang2fa,o.ang3fa,o.almaxf ...
           ,o.almidf,o.alminf,o.atmaxf,o.atmidf,o.atminf]=deal(tmp{1:12});
        tmp=textscan(o.inp.dataset15b,'%*f %f %f %f %f %f %f %f %f %f %f %f %f %f ') ;
        [ o.lreg,o.pmax,o.pmid,o.pmin,o.angle2,o.angle2,o.angle3,o.almax,o.almid,o.almin ]=deal(tmp{1:11});
      end

      % ---------------       DATASET 17   -------------------------
      if o.nsop~=0
           o.iqcp=zeros(1,o.nsop);
           o.qinc=zeros(1,o.nsop);
           o.uinc=zeros(1,o.nsop);
         for n=1:o.nsop
           tmp= getNextLine(fn,'criterion','without','keyword',...
                              '#','ignoreblankline','yes');
           str= textscan(tmp,'%f %f %f ');
	   o.iqcp(n) = str{1};
	   o.qinc(n) = str{2};
	   o.uinc(n) = str{3};
         end
                    tmp= getNextLine(fn,'criterion','without','keyword',...
                              '#','ignoreblankline','yes');
      end

      % ---------------       DATASET 19   -------------------------
      if o.npbc~=0
           o.ipbc = zeros(1,o.npbc);
           o.pbc  = zeros(1,o.npbc);
           o.ubc  = zeros(1,o.npbc);
         for n=1:o.npbc
           tmp= getNextLine(fn,'criterion','without','keyword',...
                              '#','ignoreblankline','yes');
           str= textscan(tmp,'%f %f %f ');
            o.ipbc(n) = str{1};
            o.pbc(n) = str{2};
            o.ubc(n) = str{3};
         end
        tmp= getNextLine(fn,'criterion','without','keyword',...
         '#','ignoreblankline','yes');
      end

      % ---------------       DATASET 22   -------------------------

      o.inp.dataset22a = getNextLine(fn,'criterion','with','keyword',...
                              '''INCIDENCE''');
        o.inp.dataset22b='';
      if strcmpi(o.mshtyp{1},'2D')
          for n = 1:o.ne
              tmp=getNextLine(fn,'criterion','without','keyword',...
                                  '#','ignoreblankline','yes');
              o.inp.dataset22b= [o.inp.dataset22b tmp];
              fmt=repmat('%f ',1,5);
              tmp=textscan(o.inp.dataset22b, fmt);
              [o.ll(n),o.iin1(n),o.iin2(n),o.iin3(n),o.iin4(n)]=deal(tmp{1:5});
          end
      elseif strcmpi(o.mshtyp{1},'3D')
              tmp=getNextLine(fn,'criterion','without','keyword',...
                                  '#','ignoreblankline','yes');
              o.inp.dataset22b= [o.inp.dataset22b tmp];
              fmt=repmat('%f ',1,9);
              tmp=textscan(o.inp.dataset22b, fmt);
              [o.ll(n),o.iin1(n),o.iin2(n),o.iin3(n),o.iin4(n)...
                o.iin5(n),o.iin6(n),o.iin7(n),o.iin8(n)]=deal(tmp{1:5});
        end
      end % Function constructor

       function nnv=get.nnv(o)
         % it is working the same time as others, which is not a procedural way.
	 % everytime when o.a is changing, nnv is changing.
         nnv=o.a+1; 
       end
%  a endless loop
%       function nns=get.nns(b), 
%         % it is working the same time as others, which is not a procedural way.
%	 % everytime when o.a is changing, nnv is changing.
%         nns=b; 
%       end
%       function nnv=set.nnv(x), nnv=1; end
%       function o=set.nns(o,10), o.nns=10; end
%        function dx_cell_mtx=set.dx_cell_mtx(o)
%            dx_cell_mtx=o.x;
%        end 

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
