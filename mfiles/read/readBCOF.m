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

  o2.varargin              = varargin;
  [fname, varargin]        = getNext(varargin,'char','');
  [output_no  ,  varargin] = getProp(varargin,'outputnumber',0);
  [output_from,  varargin] = getProp(varargin,'outputfrom',1);
  [inpObj,  ~]      = getProp(varargin,'inpObj',[]);
  o2.output_no             = output_no;

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

  o2.title1 = getNextLine(fn,'criterion',...
                           'with','keyword','## ','operation','delete');
  o2.title2 = getNextLine(fn,'criterion',...
                         'with','keyword','## ','operation','delete');

  % ---------------- Parsing the line with bcof, element info-----------------
  o2.MeshInfo = getNextLine(fn,'criterion','equal','keyword','## ');
  tmp = regexprep(o2.MeshInfo,{'#','(',')','\,','*','='},{'','','','','',''});
  tmp = textscan(tmp,'%s %s %s %f %f %f %*s %f %*s');
  % think about how to realize in one-liner
  %  [o2.mshtyp{1} o2.mshtyp{2} ] =deal(tmp{1:2}{1});
  [o2.nn1 o2.nn2 o2.nn o2.ne ] =deal(tmp{4:7});
  o2.mshtyp{1} = tmp{1}{1};
  o2.mshtyp{2} = tmp{2}{1};

  % ---------------- parsing the number of results    ------------------------
  tmp      = getNextLine(fn,'criterion','with','keyword',...
                 '## FLUID SOURCE/SINK NODE RESULTS','operation','delete');
  tmp      = textscan(tmp,'%f ');
  o2.ktprn = tmp{1};  % expected no. time steps
  if output_no ~= 0;
    output_no   = min(o2.ktprn,output_no);
  else
    output_no = o2.ktprn;
  end

  % ---------------- parsing expected results    ----------------------------
  tmp             = getNextLine(fn,'criterion','with','keyword','##   --');
  tmp_table       = textscan(fn,'##  %f %f',o2.ktprn);
  [o2.itt o2.tt ] = deal(tmp_table{:});

  
    %% ---jumping results when started point is not the first output TO190308----
%   if output_from~=0
%      fprintf(1,'Jumping and starting to read from %d th output\n which is %d th time step, actual time %d\n',output_from,o2.itt(output_from),o2.tt(output_from));
%      % this has been found to use out of memories 
%      textscan(fn,'%s', output_from*(o2.nsop+5));
%      % below is too slow
%      %textscan(fn,'', output_from*(o2.nn+5));
%      % this is slower but would not use out of memories
%      %textscan(fn,'%s',1,'headerLines' , output_from*(o2.nn+5)-1);
%   end
%   
    n=1;parsing_start_node=1;
    tmp       = getNextLine(fn,'criterion','with','keyword','## TIME STEP');
    if tmp  ~= -1 %&& output_from==1  % check if simulation is incomplete
      tmp = regexprep(tmp,{'## TIME STEP','Duration:','sec','Time:'}...
                    ,{'','','',''});
      if output_from==1
          tmp = textscan(tmp,'%f %f %f');
          [ o(n).itout o(n).durn o(n).tout] = deal(tmp{:});
      end

      tmp = getNextLine(fn,'criterion','with'...
                    ,'keyword','##   Node');

      [tmp o2.nsop] = getBlock(fn,'keyword','#'); %TO190312 sutraset learns nsop from the first trial
      tmp = textscan(tmp,'%f %s %s %f %f %f ',o2.nsop);
      if output_from==1
          parsing_start_node=2;
          [o(n).i,o(n).ibc,o(n).notapp,o(n).qin,o(n).uucut,...
                   o(n).qu]= deal(tmp{:});
      end
%           end
%       elseif n>=output_from
%           tmp = textscan(fn ,'%f %s %s %f %f %f ',o2.nsop);
%           [o(n).i,o(n).ibc,o(n).notapp,o(n).qin,o(n).uucut,...
%                   o(n).qu]= deal(tmp{:});          
%       end
%       % get o.nbcp as it is not disclosed in *.bcof
%       if n==output_from 
%         [tmp o2.nsop] = getBlock(fn,'keyword','#'); %TO190312 sutraset learns nsop from the first trial
%         tmp = textscan(tmp,'%f %s %s %f %f %f ',o2.nsop);
%       else
%         tmp = textscan(fn ,'%f %s %s %f %f %f ',o2.nsop);
%       end
% 
%       [o(n).i,o(n).ibc,o(n).notapp,o(n).qin,o(n).uucut,...
%                       o(n).qu]= deal(tmp{:});
    else
      fprintf(1,['WARNING FROM %s: Simulation is not completed\n %g'...
             ' out of %g outputs extracted\n'],caller,n,o2.ktprn);
      return
    end % if condition

    if output_from~=1
      fprintf(1,'Jumping and starting to read from %d th output\n which is %d th time step, actual time %d\n'); %,output_from,o2.itt(output_from),o2.tt(output_from));
      % this has been found to use out of memories 
        textscan(fn,'%s', output_from*(o2.nsop+5));
    end

  % ---------------- Parsing simulation results -----------------------------
  fprintf(1,'%s is parsing the %g of %g outputs\n', caller,output_no,o2.ktprn);
  for n=parsing_start_node:output_no
    fprintf('.'); if rem(n,50)==0; fprintf('%d\n',n); end
    tmp       = getNextLine(fn,'criterion','with','keyword','## TIME STEP');
    if tmp  ~= -1  % check if simulation is incomplete
      tmp = regexprep(tmp,{'## TIME STEP','Duration:','sec','Time:'}...
                    ,{'','','',''});
      tmp = textscan(tmp,'%f %f %f');
      [ o(n).itout o(n).durn o(n).tout] = deal(tmp{:});

      tmp = getNextLine(fn,'criterion','with'...
                    ,'keyword','##   Node');
%       if n==1
%           [tmp o2.nsop] = getBlock(fn,'keyword','#'); %TO190312 sutraset learns nsop from the first trial
%           if n==output_from
%               tmp = textscan(tmp,'%f %s %s %f %f %f ',o2.nsop);
%               [o(n).i,o(n).ibc,o(n).notapp,o(n).qin,o(n).uucut,...
%                   o(n).qu]= deal(tmp{:});
%           end
%       elseif n>=output_from
           tmp = textscan(fn ,'%f %s %s %f %f %f ',o2.nsop);
           [o(n).i,o(n).ibc,o(n).notapp,o(n).qin,o(n).uucut,...
                   o(n).qu]= deal(tmp{:});          
%       end
%       % get o.nbcp as it is not disclosed in *.bcof
%       if n==output_from 
%         [tmp o2.nsop] = getBlock(fn,'keyword','#'); %TO190312 sutraset learns nsop from the first trial
%         tmp = textscan(tmp,'%f %s %s %f %f %f ',o2.nsop);
%       else
%         tmp = textscan(fn ,'%f %s %s %f %f %f ',o2.nsop);
%       end
% 
%       [o(n).i,o(n).ibc,o(n).notapp,o(n).qin,o(n).uucut,...
%                       o(n).qu]= deal(tmp{:});
    else
      fprintf(1,['WARNING FROM %s: Simulation is not completed\n %g'...
             ' out of %g outputs extracted\n'],caller,n,o2.ktprn);
      return
    end % if condition
  end  % n loops
  fprintf('%s: Parsed %g of %g outputs\n', caller,output_no,o2.ktprn);
