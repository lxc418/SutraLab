classdef inpObj
  properties
    % the following list are associated with property defination
    % http://stackoverflow.com/questions/7192048/can-i-assign-types-to-class-properties-in-matlab
    % http://undocumentedmatlab.com/blog/setting-class-property-types
    
    % now only key data are stored in inpObj, other non-relevant data will all be 
    % wiped out 

    % if one wish to convert from class to truct due to reasons like jasn file 
    %   one can use a=struct(inpObj)

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


    % ---------------  DATASET 2B variable declaration--------------------
    %   matlab stats that, string array should be declared as cells
    %    mshtyp   = char(2,10)   
    %   http://stackoverflow.com/questions/7100841/create-an-array-of-strings

    mshtyp@cell=repmat({''},2,1)     % mesh type
    nn1  % -- number of node in the first direction
    nn2  % -- number of node in the second direction
    nn3  % -- number of node in the third direction
    %   DATASET 3
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

    % ---------------  DATASET 8C variable declaration--------------------
    lcolpr

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



    %    dtst@cell=repmat({''},22,1)
    %    dtst{1}@cell=repmat({''},2,1)   % how to do this
    %    dtst{2}@cell=repmat({''},2,1)
    %    dtst1@cell=repmat({''},2,1)
        %dtst2@char
    %    dtst2@cell=repmat({''},2,1)
    %    dtst3@char
    %    dtst4@char
    %    dtst5@char
    %    dtst6@cell=repmat({''},3,1)
    %    dtst7@cell=repmat({''},3,1)
    %    dtst8@cell=repmat({''},4,1)
    %    dtst9@char
    %    dtst10@char
    %    dtst11@char
    %    dtst12@char
    %    dtst13@char
    %    dtst14@char
    %    dtst15@char
    %    dtst16@char
    e=char(14)   %  this is working now but the 14 means have 14 strings
    %    f=char(2,4)   %  this is working now but the 14 means have 14 strings
    g=cell(2,4)   %  this is working now but the 14 means have 14 strings
    %    h{1}=repmat({''},2,1)
    %    h{2}=repmat({''},2,1)
    %            'dtst1'   ,{'title1';'title2'},...
    nnv
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
%*********************** Function readinp **************************
    function o=inpObj(varargin)
      % inpObj constructor
      o.varargin        = varargin;
      [fname, varargin] = getNext(varargin,'char','');
      [read,  varargin] = getProp(varargin,'operation',[]);

      %     o.nnv=varargin;
      %     fprintf(1,varargin);
      %      o.dataset1=varargin{1};
      %[time,       varargin] = getProp(varargin,{'t','totim'},[]);
      %[userLabels, varargin] = getNext(varargin,{'cell','char'},{});
      %
      %[userPeriods,varargin] = getNext(varargin,'double',[]);
      %[userTstps,  varargin] = getNext(varargin,'double',[]);
      %[userLays,   varargin] = getNext(varargin,'double',[]);
      %[userRows,   varargin] = getNext(varargin,'double',[]);
      %[userCols,   ~       ] = getNext(varargin,'double',[]);
      
      % ---------------       DATASET 1    -------------------------
      fn=fopen(fname);
      o.inp.dataset1a=getNextLine(fn,'#');
      o.inp.dataset1b=getNextLine(fn,'#');
      % ---------------       DATASET 2A   -------------------------
      o.inp.dataset2a=getNextLine(fn,'#');
      % ---------------       DATASET 2B   -------------------------
      o.inp.dataset2b=getNextLine(fn,'#');
      % remove single quote
      strprc      = regexprep(o.inp.dataset2b,'''','');
      tmp         = textscan(strprc,'%s %s %s %f %f');
      o.mshtyp(1) = tmp{1};
      o.mshtyp(2) = tmp{2};
      o.nn1       = tmp{4};
      o.nn2       = tmp{5};
      % ---------------       DATASET 3    -------------------------
      o.inp.dataset3 = getNextLine(fn,'#');
      str            = textscan(o.inp.dataset3,'%f %f %f %f %f %f %f');
      o.nn           = str{1};
      o.ne           = str{2};
      o.npbc         = str{3};
      o.nubc         = str{4};
      o.nsop         = str{5};
      o.nsou         = str{6};
      o.nobs         = str{7};
      
      % ---------------       DATASET 4    -------------------------
      o.inp.dataset4=getNextLine(fn,'#');
      
      
      % ---------------       DATASET 5    -------------------------
      o.inp.dataset5 = getNextLine(fn,'#');
      
      
      % ---------------       DATASET 6    -------------------------
      o.inp.dataset6 = getNextLine(fn,'#');
      o.inp.dataset6 = getNextLine(fn,'#');
      o.inp.dataset6 = getNextLine(fn,'#');
      
      % ---------------       DATASET 7A   -------------------------
      o.inp.dataset7a = getNextLine(fn,'#');
      
      % ---------------       DATASET 7B   -------------------------
      o.inp.dataset7b = getNextLine(fn,'#');
      
      % ---------------       DATASET 7C   -------------------------
      o.inp.dataset7c = getNextLine(fn,'#');
      
      % ---------------       DATASET 8A   -------------------------
      o.inp.dataset8a = getNextLine(fn,'#');
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
      o.inp.dataset8b = getNextLine(fn,'#');
      strprc          = regexprep(o.inp.dataset8b,'''','');
      str             = textscan(strprc,'%f %s %s %s ');
      ncolpr=str{1};
      % ---------------       DATASET 8C   -------------------------
      o.inp.dataset8c = getNextLine(fn,'#');
      strprc          = regexprep(o.inp.dataset8c,'''','');
      str             = textscan(strprc,'%f %s %s %s ');
      lcolpr=str{1};

      % ---------------       DATASET 8D   -------------------------
      o.inp.dataset8d = getNextLine(fn,'#');
      strprc          = regexprep(o.inp.dataset8d,'''','');
      str             = textscan(strprc,'%f %f %f %f %s');
      o.nbcfpr        = str{1};
      o.nbcspr        = str{2};
      o.nbcppr        = str{3};
      o.nbcupr        = str{4};
      o.cinact        = str{5}{1};
      
      % ---------------       DATASET 9    -------------------------
      o.inp.dataset9 = getNextLine(fn,'#');
      
      % ---------------       DATASET 10   -------------------------
      o.inp.dataset10 = getNextLine(fn,'#');
      
      % ---------------       DATASET 11   -------------------------
      o.inp.dataset11 = getNextLine(fn,'#');
      
      % ---------------       DATASET 12   -------------------------
      o.inp.dataset12 = getNextLine(fn,'#');
      
      % ---------------       DATASET 13   -------------------------
      o.inp.dataset13 = getNextLine(fn,'#');

      
      %            for i=1:10
      %                line=fgetl(fn);
      %            end
      %            f2=fscanf(fn,'%*s %*s %*s %*s %g %g %g %g %g %g %g %g %g',[1 9]); % Dataset 6B
      %            itmax=f2(2);  % total numner of time steps
      %            line=fgetl(fn); % reand the line of Dataset 6B again to proceed to the next line
      %           
      %            for i=1:9
      %                line=fgetl(fn);
      %            end
      %            f3=fscanf(fn,'%f %*s %*s %*s %*s %*s',[1 1]);  % Dataset 8B
      %            line=fgetl(fn); % reand the line of Dataset 8B again to proceed to the next line
      %            if mod(itmax,f3(1))==0  % Calculate the number of output in .NOD file
      %                if(f3(1)<0)
      %                    if abs(f3(1))==1
      %                    o.nno=(itmax-mod(itmax,abs(f3(1))))/abs(f3(1)); % Number of output in .NOD file
      %                    else
      %                    o.nno=(itmax-mod(itmax,abs(f3(1))))/abs(f3(1))+1; % Number of output in .NOD file
      %                    end
      %                else
      %                    if f3(1)==1
      %                    o.nno=(itmax-mod(itmax,f3(1)))/f3(1)+1; % Number of output in .NOD file
      %                    else
      %                    o.nno=(itmax-mod(itmax,f3(1)))/f3(1)+2; %
      %                    end
      %                end % if
      %            else
      %                if(f3(1)<0)
      %                    o.nno=(itmax-mod(itmax,abs(f3(1))))/abs(f3(1))+2; % Number of output in .NOD file
      %                else
      %                    o.nno=(itmax-mod(itmax,f3(1)))/f3(1)+3; % Number of output in .NOD file
      %                end % if
      %            end % if
      %            f4=fscanf(fn,'%f %*s %*s %*s %*s',[1 1]);  % Dataset 8C
      %            line=fgetl(fn); % Reand the line of Dataset 8C again to proceed to the next line
      %            if mod(itmax,f4(1))==0  % Calculate the number of output in .NOD file
      %                o.neo=(itmax-mod(itmax,f4(1)))/f4(1)+1; % Number of output in .ELE file
      %            else
      %                o.neo=(itmax-mod(itmax,f4(1)))/f4(1)+2; % Number of output in .ELE file
      %            end % if
      %            
      %            %line2=fgetl(fn);
      %            line4=SutraLab.readnext(fn,'#') ;
      %            f5=cell2mat(textscan(line4,'%f %f %f %f %*s',[1 4]));  % Dataset 8C
      %            if mod(itmax,f5(1))==0  % Calculate the number of output in .BCOF file
      %              if f5(1)==1 % a conditioner to resolve nonconsistency when nbcfpr==1 
      %	       o.nbcof=(itmax-mod(itmax,f5(1)))/f5(1)+0; % Number of output in .BCOF file
      %              else
      %	       o.nbcof=(itmax-mod(itmax,f5(1)))/f5(1)+1; % Number of output in .BCOF file
      %	      end
      %            else
      %                o.nbcof=(itmax-mod(itmax,f5(1)))/f5(1)+2; % Number of output in .BCOF file
      %            end % if
      %            
      %            if mod(itmax,f5(3))==0  % Calculate the number of output in .BCOP file
      %	      if f5(3)==1
      %                o.nbcop=(itmax-mod(itmax,f5(3)))/f5(3)+0; % Number of output in .BCOP file
      %	      else
      %                o.nbcop=(itmax-mod(itmax,f5(3)))/f5(3)+1; % Number of output in .BCOP file
      %              end
      %            else
      %                o.nbcop=(itmax-mod(itmax,f5(3)))/f5(3)+2; % Number of output in .BCOP file
      %            end % if
      %                        
      %            fclose(fn);
      end % Function readinp
      %****************************** END ********************************





%
%       %*********************** Function readETdat ************************
%       function o=linecount(fname)
%
%           fn=fopen(fname);
%           nrow=0;
%           tline=fgetl(fn);
%           while ischar(tline)
%               tline=fgetl(fn);
%               nrow=nrow+1;
%           end % while
%           fclose(fn);
%       end % Function linecount
%       %****************************** END ********************************

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
   end  % end methods
   methods(Static)
       
       
       
       %*********************** Function readinp **************************
       function [inp,f1,f2,f3,f4,f5]=readinp(fname)
          fn=fopen(fname);
       
            for i=1:5
                line=fgetl(fn);
            end
            f1=fscanf(fn,'%*s %*s %*s %g %g',[1 2]); % Dataset 2B
            inp.nnv=f1(1);  % Number of nodes along x-direction
            inp.nnh=f1(2);  % Number of nodes along y-direction
            inp.nev=f1(1)-1;   % Number of elements along x-direction
            inp.neh=f1(2)-1;   % Number of elements along y-direction
            inp.nn=f1(1)*f1(2); % Number of nodes
            inp.ne=(f1(1)-1)*(f1(2)-1); % Number of elements
            line=fgetl(fn); % Reand the line of Dataset 2B again to proceed to the next line
            
            for i=1:10
                line=fgetl(fn);
            end
            f2=fscanf(fn,'%*s %*s %*s %*s %g %g %g %g %g %g %g %g %g',[1 9]); % Dataset 6B
            itmax=f2(2);  % Total numner of time steps
            line=fgetl(fn); % Reand the line of Dataset 6B again to proceed to the next line
           
            for i=1:9
                line=fgetl(fn);
            end
            f3=fscanf(fn,'%f %*s %*s %*s %*s %*s',[1 1]);  % Dataset 8B
            line=fgetl(fn); % Reand the line of Dataset 8B again to proceed to the next line
            if mod(itmax,f3(1))==0  % Calculate the number of output in .NOD file
                if(f3(1)<0)
                    if abs(f3(1))==1
                    inp.nno=(itmax-mod(itmax,abs(f3(1))))/abs(f3(1)); % Number of output in .NOD file
                    else
                    inp.nno=(itmax-mod(itmax,abs(f3(1))))/abs(f3(1))+1; % Number of output in .NOD file
                    end
                else
                    if f3(1)==1
                    inp.nno=(itmax-mod(itmax,f3(1)))/f3(1)+1; % Number of output in .NOD file
                    else
                    inp.nno=(itmax-mod(itmax,f3(1)))/f3(1)+2; %
                    end
                end % if
            else
                if(f3(1)<0)
                    inp.nno=(itmax-mod(itmax,abs(f3(1))))/abs(f3(1))+2; % Number of output in .NOD file
                else
                    inp.nno=(itmax-mod(itmax,f3(1)))/f3(1)+3; % Number of output in .NOD file
                end % if
            end % if
            f4=fscanf(fn,'%f %*s %*s %*s %*s',[1 1]);  % Dataset 8C
            line=fgetl(fn); % Reand the line of Dataset 8C again to proceed to the next line
            if mod(itmax,f4(1))==0  % Calculate the number of output in .NOD file
                inp.neo=(itmax-mod(itmax,f4(1)))/f4(1)+1; % Number of output in .ELE file
            else
                inp.neo=(itmax-mod(itmax,f4(1)))/f4(1)+2; % Number of output in .ELE file
            end % if
            
            %line2=fgetl(fn);
            line4=SutraLab.readnext(fn,'#') ;
            f5=cell2mat(textscan(line4,'%f %f %f %f %*s',[1 4]));  % Dataset 8C
            if mod(itmax,f5(1))==0  % Calculate the number of output in .BCOF file
              if f5(1)==1 % a conditioner to resolve nonconsistency when nbcfpr==1 
	       inp.nbcof=(itmax-mod(itmax,f5(1)))/f5(1)+0; % Number of output in .BCOF file
              else
	       inp.nbcof=(itmax-mod(itmax,f5(1)))/f5(1)+1; % Number of output in .BCOF file
	      end
            else
                inp.nbcof=(itmax-mod(itmax,f5(1)))/f5(1)+2; % Number of output in .BCOF file
            end % if
            
            if mod(itmax,f5(3))==0  % Calculate the number of output in .BCOP file
	      if f5(3)==1
                inp.nbcop=(itmax-mod(itmax,f5(3)))/f5(3)+0; % Number of output in .BCOP file
	      else
                inp.nbcop=(itmax-mod(itmax,f5(3)))/f5(3)+1; % Number of output in .BCOP file
              end
            else
                inp.nbcop=(itmax-mod(itmax,f5(3)))/f5(3)+2; % Number of output in .BCOP file
            end % if
                        
            fclose(fn);
       end % Function readinp
       %****************************** END ********************************
       
       
       %*********************** Function readnod **************************
       function [a ta a1]=readnod(fname,inp,tide,outnod)
            fn=fopen(fname);
            
            for i=1:12 % Reading the first 12 rows' heading
               line=fgetl(fn);
            end
               temp=fscanf(fn,'%*s %g %g %*s %*g %*s %*g %*s %*g',[2 inp.nno]); % Time steps (1st row) and Time (sec) (2nd row)
               if inp.nno==inp.neo
                 ta(1:2,:)=temp(1:2,2:inp.nno);
                 ta(2,:)=ta(2,:)/24/3600; % Change time from seconds to day
               else
                 ta(1:2,:)=temp(1:2,3:inp.nno);
                 ta(2,:)=ta(2,:)/24/3600; % Change time from seconds to day
               end % if
               line=fgetl(fn); % Read the line again to proceed to the next line
            
            for j=1:outnod
              for i=1:5  % Read the first five rows of each out
                line=fgetl(fn);
              end % i
           
            if inp.nno==inp.neo
              if j==1  % Jump over the first round of output
                for m=1:inp.nn
                   line=fgetl(fn);
                end
              else
                  a(j-1).label={'x','y','p','c','s'};
                  a1(:,:,j-1)=fscanf(fn,'%g %g %g %g %g',[5 inp.nn]);
                  line=fgetl(fn);   % If the last column is not captured, it requires to use the previous line
                  for k=1:5
                    a(j-1).terms{k}=a1(k,:,j-1);
                  end % for
              a(j-1).TsNumber=ta(1,j-1);  % Time steps
		      a(j-1).RealTDays=ta(2,j-1); % Time (day)
              a(j-1).TDlevel=tide.msl+tide.tasp*sin(2*pi*ta(2,j-1)*86400/tide.tpsp)+ ...
                                       tide.tane*sin(2*pi*ta(2,j-1)*86400/tide.tpne);  % Calculate tidal level
              end % if
            else
              if j<=2  % Jump over the first round of output
                for m=1:inp.nn
                   line=fgetl(fn);
                end
              else
                  a(j-2).label={'x','y','p','c','s'};
                  a1(:,:,j-2)=fscanf(fn,'%g %g %g %g %g',[5 inp.nn]);
                  line=fgetl(fn);   % If the last column is not captured, it requires to use the previous line
                  for k=1:5
                    a(j-2).terms{k}=a1(k,:,j-2);
                  end % for
              a(j-2).TsNumber=ta(1,j-2);  % Time steps
		      a(j-2).RealTDays=ta(2,j-2); % Time (day)
              a(j-2).TDlevel=tide.msl+tide.tasp*sin(2*pi*ta(2,j-2)*86400/tide.tpsp)+ ...
                                       tide.tane*sin(2*pi*ta(2,j-2)*86400/tide.tpne);  % Calculate tidal level
              end % if
            end %if
            end % j
            fclose(fn);
	   end % Funtion readnod
       %****************************** END ********************************
       
       
       %*********************** Function readele **************************
       function [b b1]=readele(fname,inp,outele)
           fn=fopen(fname);
           for i=1:12 % Reading the first 12 rows' heading
              line=fgetl(fn);
           end
              temp=fscanf(fn,'%*s %g %g %*s %*g %*s %*g %*s %*g',[2 inp.neo]); % Time steps (1st row) and Time (sec) (2nd row)
              line=fgetl(fn); % Read the line again to proceed to the next line
          
           for j=1:outele
              for i=1:5  % Read the first five rows of each out 
                line=fgetl(fn);
              end % i
         
              if j==1  % Jump over the first round of output
                for m=1:inp.ne
                   line=fgetl(fn);
                end
              else
                  b(j-1).label={'xe','ye','vx','vy'};
                  b1(:,:,j-1)=fscanf(fn,'%g %g %g %g',[4 inp.ne]);
                  line=fgetl(fn);   % If the last column is not captured, it requires to use the previous line
                  for k=1:4
                    b(j-1).terms{k}=b1(k,:,j-1);
                  end % for
              end % if
            end % j
            fclose(fn);     
       end % Function readele
       %****************************** END ********************************
       
       
	   %*********************** Function readseep *************************
       function [seep]=readseep(fname,outele,f4)
          fn=fopen(fname);
          line=fgetl(fn); % Jump over the first time step's output
          for j=1:outele-1
            for i=1:f4(1)-1
              line=fgetl(fn);
            end
              seep(:,:,j)=fscanf(fn,'%g %*g %g %g',[3 1]);
              line=fgetl(fn);
          end % for
          fclose(fn);
       end % Function readseep
       %****************************** END ********************************
	   
	   
       %*********************** Function readbcof *************************
       function [bcof,bcof1]=readbcof(fname,inp)
           fn=fopen(fname);
           for i=1:12 % Reading the first 12 rows' heading
              line=fgetl(fn);
           end
              temp=fscanf(fn,'%*s %g %g',[2 inp.nbcof]);
              line=fgetl(fn);
              
           for j=1:100 % Should be inp.nbcof
               for i=1:7
                  line=fgetl(fn);
               end
               
               if j==1  % Jump over the first round of output
                 for m=1:inp.nnh
                   line=fgetl(fn);
                 end
               else
                 bcof(j-1).label={'FluidSource','Conc','Rconc'};
                 bcof1(:,:,j-1)=fscanf(fn,'%*g %*s %*s %g %g %g',[3 inp.nnh]);
                 line=fgetl(fn);
                 for k=1:3
                   bcof(j-1).terms{k}=bcof1(k,:,j-1);
                 end
               end % if
           end % for
           fclose(fn);
       end % Function readbcof
       %****************************** END ********************************
       
       
       %*********************** Function readbcop *************************
       function [bcop,bcop1]=readbcop(fname,inp)
           fn=fopen(fname);
           for i=1:12 % Reading the first 12 rows' heading
              line=fgetl(fn);
           end
              temp=fscanf(fn,'%*s %g %g',[2 inp.nbcop]);
              line=fgetl(fn);
              
           for j=1:100 % Should be inp.nbcop
               for i=1:7
                  line=fgetl(fn);
               end
               
               if j==1  % Jump over the first round of output
                 for m=1:inp.nnh
                   line=fgetl(fn);
                 end
               else
                 bcop(j-1).label={'RSFluid','SoluteC','RSSolute'};
                 bcop1(:,:,j-1)=fscanf(fn,'%*g %*s %*s %g %g %g %*g %*g',[3 inp.nnh]);
                 line=fgetl(fn);
                 for k=1:3
                   bcop(j-1).terms{k}=bcop1(k,:,j-1);
                 end
               end % if
           end % for
           fclose(fn);
       end % Function readbcop
       %****************************** END ********************************
       

       
       
       
        function line=readnext(fn,keywords)
        % line=readnext(fn,keywords)
	% read next line that is not started from '#'
	% fn  -- file handle
	% keywords -- should be hatch
             line=fgetl(fn);
             while  line(1)=='#'
               line=fgetl(fn);
             end
	
       end

       function nns=nnns(o), 
         % it is working the same time as others, which is not a procedural way.
	 % everytime when o.a is changing, nnv is changing.
         nns.nns=o.a+7; 
       end % function
       
   end % methods (static)
end % classdef
