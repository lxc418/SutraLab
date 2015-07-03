% Read 'inp' file of SUTRA automatically
clear all;
fclose('all');
tic; % Start stopwatch timer

dirName=pwd; % Get current path
inpfiles=dir(fullfile(dirName,'*.inp')); % List the *.inp file
inpfiles={inpfiles.name}; % .inp file name
inpFile=char(inpfiles); % Convert cell to string for fopen

nodfiles=dir(fullfile(dirName,'*.nod')); % List the *.nod file
nodfiles={nodfiles.name}; 
nodFile=char(nodfiles); 

elefiles=dir(fullfile(dirName,'*.ele')); % List the *.nod file
elefiles={elefiles.name}; 
eleFile=char(elefiles); 

bcoffiles=dir(fullfile(dirName,'*.bcof')); % List the *.bcof file
bcoffiles={bcoffiles.name};
bcofFile=char(bcoffiles); 

bcopfiles=dir(fullfile(dirName,'*.bcop')); % List the *.bcop file
bcopfiles={bcopfiles.name};
bcopFile=char(bcopfiles);

ETFile='ET.DAT'; % ET.DAT with model setup
SEEPFile='SEEPAGE.DAT'; % SEEPAGE position

tide=struct;
[tide]=SutraLab.readETinp(ETFile);
fprintf(1,'Tidal parameters reading finished\n');

inp=struct; % Create struct file of .inp
[inp,f1,f2,f3,f4,f5]=SutraLab.readinp(inpFile);  % Function that reads *.inp file

% Before reading .nod & .ele files, it is necessary to pre-determine
% whether the files are complete, namely the numerical simulation was
% finished rathen than interruptted due to non-convengence, error, etc
nrow=SutraLab.linecount(nodFile); % Number of rows in *.nod file
if nrow==12+inp.nno+(5+inp.nn)*inp.nno % If *.nod file is complete
   outnod=inp.nno;  
else % If *.nod file is incomplete
   outnod=(nrow+1-12-inp.nno-8)/(5+inp.nn);
end % if

nrow=SutraLab.linecount(eleFile); % Number of rows in *.ele file
if nrow==12+inp.neo+(5+inp.ne)*inp.neo % If *.ele file is complete
   outele=inp.neo;  
else % If *.ele file is incomplete
   outele=(nrow+1-12-inp.neo-8)/(5+inp.ne);
end % if
fprintf(1,'Actual number of output in .NOD & .ELE files determined\n');
% End of the procedure for determining the completeness of .nod & .ele
% files

a=struct;
ta=zeros(2,inp.nno);
a1=zeros(5,inp.nn,outnod);
if inp.nno~=1
   [a ta a1]=SutraLab.readnod(nodFile,inp,tide,outnod); % Function that reads *.nod file
   fprintf(1,'NOD file reading finished\n');
end

b=struct;
b1=zeros(4,inp.ne,outele);
if inp.neo~=0
    [b b1]=SutraLab.readele(eleFile,inp,outele); % Function that reads *.ele file
    fprintf(1,'ELE file reading finished\n');
end

seep=zeros(3,1,outele);
[seep]=SutraLab.readseep(SEEPFile,outele,f4);
fprintf(1,'SEEPAGE file reading finished\n');

bcof=struct;
bcof1=zeros(3,inp.nnh,inp.nbcof);
if inp.nbcof~=0
   [bcof,bcof1]=SutraLab.readbcof(bcofFile,inp);
   fprintf(1,'BCOF file reading finished\n');
end

bcop=struct;
bcop1=zeros(3,inp.nnh,inp.nbcop);
if inp.nbcop~=0
   [bcop,bcop1]=SutraLab.readbcop(bcopFile,inp);
   fprintf(1,'BCOP file reading finished\n');
end

toc; % Corresponding to tic
