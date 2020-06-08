clear all
close all
% project name
name='PART1';

% read input files
%inp=i0('desaline');
%inp  = inpObj(  name);
inp=inpObj(name,'block_reading','yes');
inp.get_x_nod_mtx();
inp.get_y_nod_mtx();
inp.get_z_nod_mtx();

inp.get_dx_cell_mtx();
inp.get_dy_cell_mtx();
inp.get_dz_cell_mtx();
inp.get_vol();


inp.get_salt_curve_parameters();

nod  = readNOD( name);
ele  = readELE( name);
bcop = readBCOP(name);
bcof = readBCOF(name);

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
