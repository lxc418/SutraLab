function [o,o2]=readICS(varargin)
  % readNOD reads NOD file   
  %
  % INPUT
  %   filename     -- if file is named as 'abc.nod', a filename='abc'
  %                   is required
  %   outputnumber -- number of result extracted, this is useful when
  %                   output file is huge
  %   output_from  -- the start of the result
  %
  % OUTPUT
  % o  -- a struct the same size as the number of output.
  % o2 -- a struct extracting headers with the extraction inf
  %
  % Example:
  % [noddata,nodhead]=readNOD('project','outputnumber',3);
  %    Purpose: parsing 'project.nod' (or 'project.NOD')
  %            only the first three result gets extracted



  %% a string storing the caller functions
  caller = dbstack('-completenames'); caller = caller.name;

  o2.varargin       = varargin;

  [fname, varargin] = getNext(varargin,'char','');
  % an option to see whether use inp contents to guide the reading process
  %   a hard reading process will be conducted if left empty
  %[output_no,  varargin]   = getProp(varargin,'outputnumber',0);
  %output_from,  varargin] = getProp(varargin,'outputfrom',1);
  [inp,  varargin]      = getProp(varargin,'inpObj',[]);

  fn                       = fopen([fname,'.ICS']);
  if fn==-1 
    fprintf(1,'%s : Trying to open %s .ics\n',caller,fname);
    fn=fopen([fname,'.ics']);
    if fn==-1
      fprintf('%s: file ics found!!\n',caller,fname);
      o=-1;o2=-1;
      return
    end
  end

  o.time=textscan(fn,'%d',1);
  temp=textscan(fn,'%s',1);
  o.pressure_format=temp{1}{1};


  temp=textscan(fn,'%f',inp.nn);
  o.pressure=temp{1};

 
  temp=textscan(fn,'%s',1);
  o.concentration_format=temp{1}{1};

  temp=textscan(fn,'%f',inp.nn);
  o.concentration=temp{1};
