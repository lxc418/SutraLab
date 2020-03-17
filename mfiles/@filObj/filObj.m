classdef filObj <handle
    % TO200317 i decided not using k1,k2, fname(13) and ftstr, the variables used in SUTRA, 
    % because it makes very difficult to construct the data structures e.g., fname(0)='aa.smy'
    % 
    % K0  'SMY'  40  'project.smy'   # optional; defaults to          *  | SUTRA_MAIN...29700 
    % K1  'INP'  50  'project.inp'   # required                       *  | SUTRA_MAIN...28400 
    % K2  'ICS'  55  'project.ics'   # required                       *  | SUTRA_MAIN...28600
    % K3  'LST'  60  'project.lst'   # required                       *  | SUTRA_MAIN...28700
    % K4  'RST'  66  'project.rst'   # optional                       *  | SUTRA_MAIN...28800
    % K5  'NOD'  70  'project.nod'   # optional                       *  | SUTRA_MAIN...28900
    % K6  'ELE'  80  'project.ele'   # optional                       *  | SUTRA_MAIN...29000
    % K7  'OBS'  90  'project.obs'   # optional                       *  | SUTRA_MAIN...29100
    % K8  'OBC'  90  'project.obc'   # optional                       *  | SUTRA_MAIN...29200
    % K9  'BCS'      'project.bcs'   # optional
    % K10 'BCOF' 95  'project.bcof'  # optional                       *  | SUTRA_MAIN...29300
    % K11 'BCOP' 96  'project.bcop'  # optional                       *  | SUTRA_MAIN...29400
    % K12 'BCOS' 97  'project.bcos'  # optional                       *  | SUTRA_MAIN...29500
    % K13 'BCOU' 98  'project.bcou'  # optional                       *  | SUTRA_MAIN...29600
  properties
    % the following list are associated with property defination
    % http://stackoverflow.com/questions/7192048/can-i-assign-types-to-class-properties-in-matlab
    % http://undocumentedmatlab.com/blog/setting-class-property-types
    % block_reading 
    % now only key data are stored in vapinpObj, other non-relevant data will all be 
    % wiped out 
    nnv

    uname = 'SUTRA.FIL'
    % if one wish to convert from class to truct due to reasons like jasn file 
    %   one can use a=struct(vapinpObj)
    %        ML=0 FOR P AND U, ML=1 FOR P ONLY, AND ML=2 FOR U ONLY.         SUTRA........27900
    %fname={'';'';'';'';'';'';'';'';'';'';'';'';''};
    %fname={'SMY';'INP';'ICS';'LST';'RST';'NOD';'ELE';'OBS';'OBC';'BCS';'BCOF';'BCOS';'BCOP';'BCOU'};
    % varagin stores all the input parameters
    varargin cell;
    

    % NOTICE TO DEVELOPERS:
    %   please make sure that all decleared varables here are in accordance with 
    %    Original SUTRA code for the convinence of 1. better understanding of the 
    %    original code (input are in indat1 and indat2) and 2. make code consistent
    %   A comment can be made after the name declaration 
    %   k(1)=-1 means that inp file is not going to be printed
    transpose
    mtx_transpose

    sw_read_from_file
    % ---------------  DATASET 1 variable declaration--------------------
    %k0=-1
    %k1=-1   %this is the original file
    %k2=-1
    %k3=-1
    %k4=-1
    %k5=-1
    %k6=-1
    %k7=-1
    %k8=-1
    %k9=-1
    %k10=-1
    %k11=-1
    %k12=-1 % k=zeros(13,1)-1   this method can not call 'k(0)' which 


    %term  = struct('fname','','fid',-1);
    %terms = struct('inp',term);  % this does not work
    terms=struct('smy',   struct('fname','','fid',-1),...
                 'inp',   struct('fname','','fid',-1),...
                 'ics',   struct('fname','','fid',-1),...
                 'lst',   struct('fname','','fid',-1),...
                 'rst',   struct('fname','','fid',-1),...
                 'nod',   struct('fname','','fid',-1),...
                 'ele',   struct('fname','','fid',-1),...
                 'obs',   struct('fname','','fid',-1),...
                 'obc',   struct('fname','','fid',-1),...
                 'bcs',   struct('fname','','fid',-1),...
                 'bcop',   struct('fname','','fid',-1),...
                 'bcou',   struct('fname','','fid',-1)...
        );
    

    ftstr
    %ftstr={'SMY','INP','ICS','LST','RST','NOD','ELE','OBS','OBC','BCS','BCOF','BCOS','BCOP','BCOU'};   % this is original but can not start from zero
    %ftstr={'SMY';'INP';'ICS';'LST';'RST';'NOD';'ELE';'OBS';'OBC';'BCS';'BCOF';'BCOS';'BCOP';'BCOU'};

    %iunit=(   )
    
  end
  
  
  properties (Access=protected)
  c ,d
  end

  properties (Dependent=true,Access=public)
    %terms = struct('smy',term,'inp',term);
  % these values are only called when input are changed
  %   a, b, c ,d, e,
  %nns
  end

  methods    % seems that all functions in methods needs to be called.

    %function value = get.terms(o)
    %   value=o.terms;
    %end


    function o=filObj(varargin)
        %% a string storing the caller functions
        caller = dbstack('-completenames'); caller = caller.name;
        o2.varargin       = varargin;
      
        [inp,  varargin]      = getProp(varargin,'inpObj',[]);
        [o.sw_read_from_file,  varargin] = getProp(varargin,'read_from_file','yes');
        o.ftstr= fieldnames(o.terms)
      
        if strcmpi(o.sw_read_from_file,'yes')
          fn=fopen(o.uname);

          
          temp = getNextLine(fn,'criterion','without','keyword','#');
          
          while temp~=-1
              temp = regexprep(temp,'''','');
              tmp=textscan(temp,'%s  %f  %s'); 
              %fprintf('%s\n',tmp{1});
              id = strcmp(o.ftstr,lower(tmp{1}));
              property_name= o.ftstr{id};
              o.terms.(property_name).fname=tmp{3}{1};
              o.terms.(property_name).fid=tmp{2};
              temp = getNextLine(fn,'criterion','without','keyword','#');
          end  % while
        
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
