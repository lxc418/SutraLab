classdef etObj
  properties
    % the following list are associated with property defination
    % http://stackoverflow.com/questions/7192048/can-i-assign-types-to-class-properties-in-matlab
    % http://undocumentedmatlab.com/blog/setting-class-property-types
    
    % now only key data are stored in inpObj, other non-relevant data will all be 
    % wiped out 

    % if one wish to convert from class to truct due to reasons like jasn file 
    %   one can use a=struct(etObj)

    % varagin stores all the input parameters
    varargin@cell;
    
    %   inp should later be removed now it is here for storing all strings extracted
    %     from the file
    et

    % NOTICE TO DEVELOPERS:
    %   please make sure that all decleared varables here are in accordance with 
    %    Original SUTRA code for the convinence of 1. better understanding of the 
    %    original code (input are in indat1 and indat2) and 2. make code consistent
    %   A comment can be made after the name declaration 


    % ---------------  DATASET 2B variable declaration--------------------
    %   matlab stats that, string array should be declared as cells
    %    mshtyp   = char(2,10)   
    %   http://stackoverflow.com/questions/7100841/create-an-array-of-strings

    % mshtyp@cell=repmat({''},2,1)     % mesh type
	
	% ---------- DATASET 13C: CONTROLLING PARAMETERS ----------
    met  % -- switch of evaporation
    mar  % -- aerodynamic resistance
    msr  % -- surface resistance
	msc  % -- salt resistance
	mht  % -- heat balance
	mvt  % -- vapour transport
	mft  % -- film transport
	mrk  % -- relative hydraulic conductivity
	
    % ---------- DATASET 1: TIDE FLUCTUATION IN USUBS ----------
    tasp  % -- spring tidal amplitude (m)
	tane  % -- neap tidal amplitude (m)
    tpsp  % -- tidal period of spring tide (s)
    tpne  % -- tidal period of neap tide (s) 
	tm    % -- mean tidal level (m) 
	rhost % -- the density of tide water
	sc    % -- salinity of seawater 
	
    % ---------- DATASET 1: EVAPORATION INPUT ----------
    qet   % -- potential evaporation rate (m/s)
    uet   % -- solute density taken by evaporation (kg/kg)
    pet   % -- pore-water pressure threshold (pa), below which evaporation will take place
	uvm   % -- solubility (kg/kg)
    night % -- if=1 evaporation is switched off during night time, if=0 it is always on
	ite   % -- temporarily not used, it was designed for the number of time call for BCTIME
	
    % ---------- DATASET 13E: EVAPORATION PARAMETERS ----------
    tma  % -- atmospheric temperature on the top of the column (Celsius)
	tmi  % -- initial soil temperature (Celsius)
	alf  % -- albedo (i)
	rs   % -- short wave incoming radiation (mj/m2/day)
	rh   % -- relative humidity 0<rh<1
	ap   % -- UNKNOWN
	bp   % -- UNKNOWN
	u2   % -- daily mean wind speed at 2m above ground (km/day)
	tsd  % -- temperature of the side of the column
	scf  % -- scaling factor between the top surface and side surface of the 1D column

	% ---------- DATASET 13I: SOIL CHARACTERISTIC PARAMETERS ----------
	swres1  % -- residual saturation
	aa1     % -- van Genuchten alpha (1/m)
	vn1     % -- van Genuchten N
	swres2  % -- residual saturation
	aa2     % -- van Genuchten alpha (1/m)
	vn2     % -- van Genuchten N
    swres3  % -- residual saturation
	lam3
	phyb3   % -- (m)
	swres4  % -- residual saturation
	lam4
	phyb4   % -- (m)
	phy0    % -- (m)
	ecto    % -- eccentricity and tortuosity, the default value is 0.5

	% ---------- DATASET 13F: AERODYNAMIC RESISTANCE TERM ----------
	ravt   % -- aerodynamic resistance at the soil surface (s/m)
	ravs   % -- aerodynamic resistance at the side of the column (s/m)
	swrat  % -- parameters to switch on (1) or off (0) the temperature change on the surface
	
	% ---------- DATASET 13L: PARAMETERS FOR SURFACE RESISTANCE ----------
	tal   % -- thickness of air layer (m)
	ec    % -- eccentricity of the active pore
	etr   % -- residual evaporation rate
	psip  % -- must be positive
	cors  % -- correction coefficient, set as 1
	
	
	% ---------- DATASET 12H: PARAMETERS FOR SALT RESISTANCE ----------
	ar  % -- fitting parameter
	br  % -- fitting parameter
	
  end
  
  
  %properties (Access=protected)
  %c ,d
  %end

  %properties (Dependent=true)
  % these values are only called when input are changed
  %   a, b, c ,d, e,
  %nns
  %end

  methods    % seems that all functions in methods needs to be called
    function o=etObj(varargin)
      % etObj constructor
      caller=dbstack('-completenames'); caller=caller.name;
      o.varargin        = varargin;
      [fname, varargin] = getNext(varargin,'char','');
      [read,  varargin] = getProp(varargin,'operation',[]);
      fn=fopen([fname,'.INP']);
	  
      if fn==-1 
        fprintf(1,'%s: Trying to open %s .inp\n',caller,fname);
        fn=fopen([fname,'.inp']);
        if fn==-1
          fprintf('%s: file nod found!!\n',caller,fname);
          return
        end
      end
	  
	  % ---------------       DATASET 13C    -------------------------
      o.et.dataset13c= getNextLine(fn,'criterion','without','keyword','#');
      str            = textscan(o.et.dataset13c,'%f %f %f %f %f %f %f %f');
	  o.met          = str{1};
      o.mar          = str{2};
      o.msr          = str{3};
	  o.msc          = str{4};
	  o.mht          = str{5};
	  o.mvt          = str{6};
	  o.mft          = str{7};
	  o.mrk          = str{8};
	  
      % ---------------       DATASET 1a   -------------------------
      o.et.dataset1a= getNextLine(fn,'criterion','without','keyword','#');
	  str           = textscan(o.et.dataset1a,'%f %f %f %f %f %f %f');
	  o.tasp        = str{1};
	  o.tane        = str{2};
      o.tpsp        = str{3};
      o.tpne        = str{4};
	  o.tm          = str{5};
	  o.rhost       = str{6};
	  o.sc          = str{7};
	  
	  % ---------------       DATASET 1b   -------------------------
      o.et.dataset1b= getNextLine(fn,'criterion','without','keyword','#');
	  str           = textscan(o.et.dataset1b,'%f %f %f %f %f %f');
	  o.qet         = str{1};
	  o.uet         = str{2};
      o.pet         = str{3};
      o.uvm         = str{4};
	  o.night       = str{5};
	  o.ite         = str{6};
	  
	  % ---------------       DATASET 13E   -------------------------
      o.et.dataset13e= getNextLine(fn,'criterion','without','keyword','#');
	  str           = textscan(o.et.dataset13e,'%f %f %f %f %f %f %f %f %f %f');
	  o.tma         = str{1};
	  o.tmi         = str{2};
      o.alf         = str{3};
      o.rs          = str{4};
	  o.rh          = str{5};
	  o.ap          = str{6};
	  o.bp          = str{7};
	  o.u2          = str{8};
	  o.tsd         = str{9};
	  o.scf         = str{10};
	  
	  % ---------------       DATASET 13I   -------------------------
      o.et.dataset13i= getNextLine(fn,'criterion','without','keyword','#');
	  str           = textscan(o.et.dataset13i,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f');
	  o.swres1      = str{1};
	  o.aa1         = str{2};
      o.vn1         = str{3};
      o.swres2      = str{4};
	  o.aa2         = str{5};
	  o.vn2         = str{6};
	  o.swres3      = str{7};
	  o.lam3        = str{8};
	  o.phyb3       = str{9};
	  o.swres4      = str{10};
	  o.lam4        = str{11};
	  o.phyb4       = str{12};
	  o.phy0        = str{13};
	  o.ecto        = str{14};
	  
	  % ---------------       DATASET 13F   -------------------------
      o.et.dataset13f= getNextLine(fn,'criterion','without','keyword','#');
	  str           = textscan(o.et.dataset13f,'%f %f %f');
	  o.ravt        = str{1};
	  o.ravs        = str{2};
      o.swrat       = str{3};
	  
	  % ---------------       DATASET 13L   -------------------------
      o.et.dataset13l= getNextLine(fn,'criterion','without','keyword','#');
	  str           = textscan(o.et.dataset13l,'%f %f %f %f %f');
	  o.tal         = str{1};
	  o.ec          = str{2};
      o.etr         = str{3};
	  o.psip        = str{4};
      o.cors        = str{5};
	  
      % ---------------       DATASET 12H   -------------------------
      o.et.dataset12h= getNextLine(fn,'criterion','without','keyword','#');
	  str           = textscan(o.et.dataset12h,'%f %f');
	  o.ar          = str{1};
	  o.br          = str{2};

      end % Function constructor

%       function nnv=get.nnv(o)
         % it is working the same time as others, which is not a procedural way.
	 % everytime when o.a is changing, nnv is changing.
%        nnv=o.a+1; 
%       end
%  a endless loop
%       function nns=get.nns(b), 
%         % it is working the same time as others, which is not a procedural way.
%	 % everytime when o.a is changing, nnv is changing.
%         nns=b; 
%       end
%       function nnv=set.nnv(x), nnv=1; end
%       function o=set.nns(o,10), o.nns=10; end
   end  % end methods


 %  methods(Static)
 %    function nns = nnns(o),
       % it is working the same time as others, which is not a procedural way.
       % everytime when o.a is changing, nnv is changing.
 %      nns.nns = o.a+7;
 %    end % function
 %  end % methods (static)
end % classdef
