function [o,o2]=readNOD(varargin)
  % readNOD reads NOD file   
  % o is a struct the same size as the number of output.
  % o2   a struct extracting headers with the extraction inf
  
  % a string storing the caller functions
  caller=dbstack('-completenames'); caller=caller.name;

  o2.varargin        = varargin;
  [fname, varargin] = getNext(varargin,'char','');
  % an option to see whether use inp contents to guide the reading process
  %   a hard reading process will be conducted if left empty
  [read,  varargin] = getProp(varargin,'inpobj',[]);
  fn=fopen(fname);
  o2.title1=getNextLine(fn,'criterion',...
                         'with','keyword','## ','operation','delete');
  o2.title2=getNextLine(fn,'criterion',...
                         'with','keyword','## ','operation','delete');

  % ---------------- Parsing the line with node, element info-----------------
  o2.MeshInfo =getNextLine(fn,'criterion','equal','keyword','## ');
  tmp=regexprep(o2.MeshInfo,{'#','(',')','\,','*','='},{'','','','','',''});
  tmp=textscan(tmp,'%s %s %s %f %f %f %*s %f %*s');
%  [o2.mshtyp{1} o2.mshtyp{2} ] =deal(tmp{:}{1});
%  [o2.nn1 o2.nn2 o2.nn o2.ne ] =deal(tmp{4,5,6,8});
  o2.mshtyp{1} = tmp{1}{1};
  o2.mshtyp{2} = tmp{2}{1};
  o2.nn1=tmp{4};
  o2.nn2=tmp{5};
  o2.nn=tmp{6};
  o2.ne=tmp{7};

  % ---------------- parsing the number of results    ------------------------
  o2.OutputInfo =getNextLine(fn,'criterion','with','keyword',...
                 '## NODEWISE RESULTS','operation','delete');
  tmp=textscan(o2.OutputInfo,'%f ');
  o2.ktprn=tmp{1};  % expected no. time steps 

  % ---------------- parsing expected results    ----------------------------
  % Refering to OUTNOD.......19900
  tmp       = getNextLine(fn,'criterion','with','keyword','##   --');
  tmp_table = textscan(fn,'##  %f %f %s %f %s %f %s %f ',o2.ktprn);
  [o2.itt o2.tt o2.cphorp o2.ishorp o2.cptorc o2.istorc o2.cpsatu o2.issatu]=...
    deal(tmp_table{:});

  % ---------------- Parsing simulation results -----------------------------
  for n=1:o2.ktprn
    fprintf(1,'%s is parsing the %g of %g outputs\n', caller,n,o2.ktprn);
    tmp       = getNextLine(fn,'criterion','with','keyword','## TIME STEP');
    if tmp  ~= -1
      tmp=regexprep(tmp,{'## TIME STEP','Duration:','sec','Time:'}...
                    ,{'','','',''});
      tmp   = textscan(tmp,'%f %f %f');
      [ o(n).itout o(n).durn o(n).toutr] = deal(tmp{:});

      tmp    = getNextLine(fn,'criterion','with'...
                    ,'keyword','##  ','operation','delete');
      tmp        = textscan(tmp,'%s');
      o(n).label = tmp{1}';
      fmt        = repmat('%f ',1, length(o(n).label));
      o(n).terms = textscan(fn,fmt,o2.nn);
    else
      fprintf(1,['WARNING FROM %s: Simulation is not completed\n %g'...
             'out of %g outputs extracted\n'],caller,n,o2.ktprn);
      return
    end % if condition
  end  % loops
