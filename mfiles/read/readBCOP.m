function [o,o2]=readBCOP(varargin)
  % readBCOP reads BCOP file   
  % o  a struct the same size as the number of output.
  % o2   a struct extracting headers with the extraction inf
  % Example:
  % [npbcdata,nodhead]=readBCOP('project','outputnumber',3);
  %    Purpose: parsing 'project.npbc' (or 'project.BCOP')
  % a string storing the caller functions
  caller=dbstack('-completenames'); caller=caller.name;

  o2.varargin              = varargin;
  [fname, varargin]        = getNext(varargin,'char','');
  [output_no  ,  varargin] = getProp(varargin,'outputnumber',0);
  [output_from,  varargin] = getProp(varargin,'outputfrom',1);
  [inpObj,  varargin]      = getProp(varargin,'inpObj',[]);
  o2.output_no             = output_no;
  fname_actual=[fname,'.BCOP'];
  fn = fopen(fname_actual);
  if fn == -1
    fprintf(1,'%s : Trying to open %s .bcop\n',caller,fname);
    fname_actual=[fname,'.bcop'];
    fn = fopen(fname_actual);
    if fn == -1
      fprintf('%s: file bcop found!!\n',caller,fname);
      o=-1;o2=-1;
      return
    end
  end

  o2.title1 = getNextLine(fn,'criterion',...
                           'with','keyword','## ','operation','delete');
  o2.title2 = getNextLine(fn,'criterion',...
                         'with','keyword','## ','operation','delete');

  % ---------------- Parsing the line with npbc, element info-----------------
  o2.MeshInfo = getNextLine(fn,'criterion','equal','keyword','## ');
  tmp = regexprep(o2.MeshInfo,{'#','(',')','\,','*','='},{'','','','','',''});
  tmp = textscan(tmp,'%s %s %s %f %f %f %*s %f %*s');
  % think about how to realize in one-liner
  %  [o2.mshtyp{1} o2.mshtyp{2} ] =deal(tmp{1:2}{1});
  [o2.nn1,o2.nn2,o2.nn,o2.ne ] =deal(tmp{4:7});
  o2.mshtyp{1} = tmp{1}{1};
  o2.mshtyp{2} = tmp{2}{1};

  % ---------------- parsing the number of results    ------------------------
  tmp      = getNextLine(fn,'criterion','with','keyword',...
                 '## SPECIFIED-PRESSURE NODE RESULTS','operation','delete');
  tmp      = textscan(tmp,'%f ');
  o2.ktprn = tmp{1};  % expected no. time steps
  if output_no ~= 0
    output_no   = min(o2.ktprn,output_no);
  else
    output_no = o2.ktprn;
  end

  % ---------------- parsing expected results    ----------------------------
  tmp             = getNextLine(fn,'criterion','with','keyword','##   --');
  tmp_table       = textscan(fn,'##  %f %f',o2.ktprn);
  [o2.itt,o2.tt ] = deal(tmp_table{:});

  
  %% ---jumping results when started point is not the first output TO190308----
  if output_from>1
     
     fprintf(1,'Jumping and starting to read from %d th output\n which is %d th time step, actual time %d\n',output_from,o2.itt(output_from),o2.tt(output_from));
     if ispc 
         % this has been found to use out of memories 
         tic
         textscan(fn,'%s', output_from*(o2.npbc+5));  %300s s for ilja case and
         %the location is wrong
         %textscan(fn,'%[^\n]', output_from*(o2.nn+5));  %
         toc
         % below is too slow
         %textscan(fn,'', output_from*(o2.nn+5));
         % this is slower but would not use out of memories
         %textscan(fn,'%s',1,'headerLines' , output_from*(o2.nn+5)-1);
     else  % extract from middle
         fprintf(1,'creat temp nod file bcop_')
         %https://stackoverflow.com/questions/83329/how-can-i-extract-a-predetermined-range-of-lines-from-a-text-file-on-unix
         start_output_line_number= o2.ktprn + output_from*(o2.bcop+5)+12;
         end_output_line_number=o2.ktprn + (output_from+output_no)*(o2.npbc+5)+12;
         exit_line_number=end_output_line_number+1;
         %sed -n '16224,16482p;16483q' filename > newfile
         %command_string=['sed -n ''',fprintf('%d',start_output_line_number), ',',fprintf('%d',end_output_line_number),'p,',fprintf('%d',end_output_line_number),'q, ',fname_actual];
         tic
         command_string=sprintf('sed -n ''%d,%dp;%dq'' %s > bcop_  ',start_output_line_number,end_output_line_number,exit_line_number,fname_actual);
         system(command_string);
         toc
         fclose(fn);
           fn                       = fopen('bcop_');
     end
  elseif output_from<0  % output from the last few
      % !tail -n 50000 PART6.nod > nod__
      getNextLine(fn,'criterion','with','keyword','##   Node    Defined in');
      [~,o2.npbc] = getBlock(fn,'keyword','##');
      tic
      command_string=sprintf('tail -n %d   %s > bcop_ ', abs(output_from)*(o2.npbc+5)+10,fname_actual   );
      fprintf(1,'creat temp nod file bcop_ by %s\n', command_string);
      system(command_string);
      toc
         fclose(fn);
           fn                       = fopen('bcop_');      
           output_no=abs(output_from);
  end
  
  
  
  % ---------------- Parsing simulation results -----------------------------
  fprintf(1,'%s is parsing the %g of %g outputs\n', caller,output_no,o2.ktprn);
  i=1;
  for n=abs(output_from): (abs(output_from)+output_no)
    fprintf('.'); if rem(n,50)==0; fprintf('%d\n',n); end
    tmp       = getNextLine(fn,'criterion','with','keyword','## TIME STEP');
    if tmp  ~= -1  % check if simulation is incomplete
      tmp = regexprep(tmp,{'## TIME STEP','Duration:','sec','Time:'}...
                    ,{'','','',''});
      tmp = textscan(tmp,'%f %f %f');
      %fprintf(1, tmp);
      [ o(i).itout,o(i).durn,o(i).tout] = deal(tmp{:});

      getNextLine(fn,'criterion','with'...
                    ,'keyword','##   Node');
		    
      % get o.npbc as it is not disclosed in *.npbc
      if n==output_from 
        [tmp,o2.npbc] = getBlock(fn,'keyword','#');
        tmp = textscan(tmp,'%f %s %s %f %f %f %f %f',o2.npbc);
      else
        tmp = textscan(fn ,'%f %s %s %f %f %f %f %f',o2.npbc);
      end

      [o(i).i,o(i).ibc,o(i).bcdstr,o(i).qpl,o(i).uucut,...
                      o(i).qpu,o(i).pvec,o(i).pbc]= deal(tmp{:});
      i=i+1;
    else
      fprintf(1,['WARNING FROM %s: Simulation is not completed\n %g'...
             ' out of %g outputs extracted\n'],caller,n,o2.ktprn);
      return
    end % if condition
  end  % n loops
  fprintf('%s: Parsed %g of %g outputs\n', caller,output_no,o2.ktprn);
