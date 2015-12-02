classdef bcofObj <handle
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

  varargin
  data
%  mtx_transpose

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
  npbc

  end % properties

  properties (Access=protected)
  caa ,da
  end

  properties (Dependent=true)
  % these values are only called when input are changed
  %   a, b, c ,d, e,
  %nns
  end

  methods
  

    function [o,o2]=readBCOF(varargin)
      % readBCOF reads BCOF file   
      % 
      % Argument: 
      %   'outputnumber' -- the number of output wish to extract
      %
      % Output:
      %   o  -- struct storing the simulation results
      %   o2 -- struct extracting headers
      % Example:
      % [bcofdata,nodhead]=readBCOF('project','outputnumber',3);
      %    Function: parsing 'project.bcof' (or 'project.BCOF')
      %              only the first 3 outputs get extracted
    
      % a string storing the caller functions
      caller=dbstack('-completenames'); caller=caller.name;
    
      o.varargin              = varargin;
      [fname, varargin]        = getNext(varargin,'char','');
      [output_no  ,  varargin] = getProp(varargin,'outputnumber',0);
      [output_from,  varargin] = getProp(varargin,'outputfrom',1);
      [inpObj,  varargin]      = getProp(varargin,'inpObj',[]);
      o.output_no             = output_no;
    
      fn = fopen([fname,'.BCOF']);
      if fn == -1
        fprintf(1,'%s : Trying to open %s .bcof\n',caller,fname);
        fn = fopen([fname,'.bcof']);
        if fn == -1
          fprintf('%s: file bcof found!!\n',caller,fname);
          o=-1;o2=-1;
          return
        end
      end
    
      o.title1 = getNextLine(fn,'criterion',...
                               'with','keyword','## ','operation','delete');
      o.title2 = getNextLine(fn,'criterion',...
                             'with','keyword','## ','operation','delete');
    
      % ---------------- Parsing the line with bcof, element info-----------------
      o.MeshInfo = getNextLine(fn,'criterion','equal','keyword','## ');
      tmp = regexprep(o.MeshInfo,{'#','(',')','\,','*','='},{'','','','','',''});
      tmp = textscan(tmp,'%s %s %s %f %f %f %*s %f %*s');
      % think about how to realize in one-liner
      %  [o.mshtyp{1} o.mshtyp{2} ] =deal(tmp{1:2}{1});
      [o.nn1 o.nn2 o.nn o.ne ] =deal(tmp{4:7});
      o.mshtyp{1} = tmp{1}{1};
      o.mshtyp{2} = tmp{2}{1};
    
      % ---------------- parsing the number of results    ------------------------
      tmp      = getNextLine(fn,'criterion','with','keyword',...
                     '## FLUID SOURCE/SINK NODE RESULTS','operation','delete');
      tmp      = textscan(tmp,'%f ');
      o.ktprn = tmp{1};  % expected no. time steps
      if output_no ~= 0;
        output_no   = min(o.ktprn,output_no);
      else
        output_no = o.ktprn;
      end
    
      % ---------------- parsing expected results    ----------------------------
      tmp             = getNextLine(fn,'criterion','with','keyword','##   --');
      tmp_table       = textscan(fn,'##  %f %f',o.ktprn);
      [o.itt o.tt ] = deal(tmp_table{:});
    
      % ---------------- Parsing simulation results -----------------------------
      fprintf(1,'%s is parsing the %g of %g outputs\n', caller,output_no,o.ktprn);
      for n=output_from:output_no
        fprintf('.'); if rem(n,50)==0; fprintf('%d\n',n); end
        tmp       = getNextLine(fn,'criterion','with','keyword','## TIME STEP');
        if tmp  ~= -1  % check if simulation is incomplete
          tmp = regexprep(tmp,{'## TIME STEP','Duration:','sec','Time:'}...
                        ,{'','','',''});
          tmp = textscan(tmp,'%f %f %f');
          [ o.data(n).itout o.data(n).durn o.data(n).tout] = deal(tmp{:});
    
          tmp = getNextLine(fn,'criterion','with'...
                        ,'keyword','##   Node');
    		    
          % get o.nbcp as it is not disclosed in *.bcof
          if n==output_from 
            [tmp o.nsop] = getBlock(fn,'keyword','#');
            tmp = textscan(tmp,'%f %s %s %f %f %f ',o.nsop);
          else
            tmp = textscan(fn ,'%f %s %s %f %f %f ',o.nsop);
          end
    
          [o.data(n).i,o.data(n).ibc,o.data(n).notapp,o.data(n).qin,o.data(n).uucut,...
                          o.data(n).qu]= deal(tmp{:});
        else
          fprintf(1,['WARNING FROM %s: Simulation is not completed\n %g'...
                 ' out of %g outputs extracted\n'],caller,n,o.ktprn);
          return
        end % if condition
      end  % n loops
      fprintf('%s: Parsed %g of %g outputs\n', caller,output_no,o.ktprn);
      end
    
  end % function
    
  end % end class
