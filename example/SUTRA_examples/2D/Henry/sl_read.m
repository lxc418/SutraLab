clear all
close all
% project name

% read input files
fil = readFIL;
inp  = inpObj( fil.basename);
nod  = readNOD( fil.basename);
ele  = readELE(fil.basename);
%bcop = readBCOP(name);
%bcof = readBCOF(name);

% index for p c and s
xnod_idx  = strcmp(nod(1).label,'X');
ynod_idx  = strcmp(nod(1).label,'Y');
znod_idx  = strcmp(nod(1).label,'Z');
p_idx  = strcmp(nod(1).label,'Pressure');
c_idx  = strcmp(nod(1).label,'Concentration');
s_idx  = strcmp(nod(1).label,'Saturation');
%sm_idx = strcmp(nod(1).label,'SM');


xele_idx = strcmp(ele(1).label,'X origin');
yele_idx = strcmp(ele(1).label,'Y origin');
%zele_idx = strcmp(ele(1).label,'Z origin');

vx_idx = strcmp(ele(1).label,'X velocity');
vy_idx = strcmp(ele(1).label,'Y velocity');
%vz_idx = strcmp(ele(1).label,'Z velocity');
