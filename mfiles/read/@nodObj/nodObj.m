%function [o,o2]=nodObj(varargin)
classdef nodObj <handle
  % readNOD reads NOD file   
  %
  % INPUT
  %   filename     -- if file is named as 'abc.nod', a filename='abc'
  %                   is required
  %   outputnumber -- number of result extracted, this is useful when
  %                   output file is huge
  %   outputstart  -- (not implimented yet) the start of the result
  %
  % OUTPUT
  % o  -- a struct the same size as the number of output.
  % o -- a struct extracting headers with the extraction inf
  %
  % Example:
  % [noddata,nodhead]=readNOD('project','outputnumber',3);
  %    Purpose: parsing 'project.nod' (or 'project.NOD')
  %            only the first three result gets extracted

  % a string storing the caller functions
  properties


  n_idx
  x_idx
  y_idx
  z_idx
  p_idx
  c_idx
  s_idx

  varargin
  data
  transpose

  output_no
  title1
  title2
  MeshInfo
  mshtyp
  nn1
  nn2
  nn
  ne
  ktprn
  itt
  tt
  cphorp
  ishorp
  cptorc
  istorc
  cpsatu
  issatu
  
  end % properties

  properties (Access=protected)
  c ,d
  end

  properties (Dependent=true)
  % these values are only called when input are changed
  %   a, b, c ,d, e,
  %nns
  end

  methods
    function o=nodObj(varargin)
  	caller = dbstack('-completenames'); caller = caller.name;

  	o.varargin       = varargin;
  	[fname, varargin] = getNext(varargin,'char','');
  	% an option to see whether use inp contents to guide the reading process
  	%   a hard reading process will be conducted if left empty
  	[output_no,  varargin]   = getProp(varargin,'outputnumber',0);
  	[output_from,  varargin] = getProp(varargin,'outputfrom',0);
  	[inpObj,  varargin]      = getProp(varargin,'inpObj',[]);
  	o.output_no             = output_no;
  	fn                       = fopen([fname,'.NOD']);

  	if fn==-1 
  	  fprintf(1,'%s : Trying to open %s .nod\n',caller,fname);
  	  fn=fopen([fname,'.nod']);
  	  if fn==-1
  	    fprintf('%s: file nod found!!\n',caller,fname);
  	    o=-1;o=-1;
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
  	tmp2=textscan(tmp,'%s %s %s %f %f %f %*s %f %*s');
  	o.mshtyp{1}                    = tmp2{1}{1};
  	o.mshtyp{2}                    = tmp2{2}{1};
  	if strcmp(o.mshtyp{1},'2-D') && strcmp(o.mshtyp{2},'REGULAR')
  	  tmp=textscan(tmp,'%s %s %s %f %f %f %*s %f %*s');
  	% how to realize this by one-liner
  	%  [o.mshtyp{1} o.mshtyp{2} ] = deal(tmp{1:2}{1});
  	  [o.nn1,o.nn2,o.nn,o.ne ]    = deal(tmp{4:7});
  	elseif strcmp(o.mshtyp{1},'3-D') && strcmp(o.mshtyp{2},'BLOCKWISE')
  	  tmp=textscan(tmp,'%s %s %s %f %f %f %f %*s %f %*s');
  	  [o.nn1,o.nn2,o.nn3,o.nn,o.ne ]    = deal(tmp{4:8});
  	end
  	% ---------------- parsing the number of results    ------------------------
  	tmp = getNextLine(fn,'criterion','with','keyword',...
  	               '## NODEWISE RESULTS','operation','delete');
  	tmp           = textscan(tmp,'%f ');
  	o.ktprn      = tmp{1};  % expected no. time steps
  	if output_no ~= 0;
  	  output_no   = min(o.ktprn,output_no);
  	else
  	  output_no = o.ktprn;
  	end

  	% ---------------- parsing expected results    ----------------------------
  	% Refering to OUTNOD.......19900
  	tmp       = getNextLine(fn,'criterion','with','keyword','##   --');
  	tmp_table = textscan(fn,'##  %f %f %s %f %s %f %s %f ',o.ktprn);
  	[o.itt,o.tt,o.cphorp,o.ishorp,o.cptorc,o.istorc,o.cpsatu,o.issatu]=...
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

  	    tmp = getNextLine(fn,'criterion','with'...
  	                  ,'keyword','##  ','operation','delete');
  	    %tmp        = textscan(tmp,'%s');
  	    %o.data(n).label = tmp{1}';
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
end
  end % construction method
  end % end class
