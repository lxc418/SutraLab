clear all
close all
% project name
name='PART6_fine_mesh';

% read input files
%inp=i0('desaline');
inp  = inpObj(  name,'block_reading','yes');
inp.get_x_nod_mtx; % this creates a inp.x_nod_mtx, which is x coordinates in matrix form
inp.get_y_nod_mtx;
inp.get_dx_cell_mtx; %this creates variable inp.x_cell_mtx, which is the length of each cell
inp.get_dy_cell_mtx; %this creates variable inp.y_cell_mtx, which is the height of each cell

%dx=0.2;
dx=5;
dy=-0.2;
x_ay=0:dx:200;
y_ay=0:dy:-5.2;
nx=length(x_ay);
ny=length(y_ay);

nex=length(x_ay)-1;
ney=length(y_ay)-1;

[x_nod_mtx,y_nod_mtx]=meshgrid(x_ay,y_ay);

keynodes            = zeros(size(x_nod_mtx,1),size(x_nod_mtx,2)+1);
keynodes(:,2:end-1) = (x_nod_mtx(:,1:end-1)+x_nod_mtx(:,2:end))/2;
keynodes(:,1)       = x_nod_mtx(:,1);
keynodes(:,end)     = x_nod_mtx(:,end);
dx_cell_mtx       = diff(keynodes,1,2); % check inbuilding function diff

keynodes            = zeros(size(y_nod_mtx,1)+1,size(y_nod_mtx,2));
keynodes(2:end-1,:) = (y_nod_mtx(1:end-1,:)+y_nod_mtx(2:end,:))/2;
keynodes(1,:)       = y_nod_mtx(1,:);
keynodes(end,:)     = y_nod_mtx(end,:);
dy_cell_mtx=diff(keynodes,1,1); % check inbuilding function diff


nn=nx*ny;
ne=(nx-1)*(ny-1);

sequence='yxz';

%dataset 14
ii=(1:nn)';
nreg=zeros(nn,1)+2;
x=x_nod_mtx(:);
y=y_nod_mtx(:);
z=zeros(nn,1)+1.0;
por=zeros(nn,1)+2.4;



%%%   DATASET 14
% string is found to be slow when array reach 10000
fprintf('Writting dataset 14')
tic
scalx=1.;
scaly=1.;
scalz=1.;
porfac=1.;



n_string_block=ceil(nn/10000);
dataset14_str=cell(n_string_block,1);

dataset14_str{1}=sprintf('## DATASET 14: Nodewise DATA\n');
dataset14_str{1}=[dataset14_str{1},sprintf('##                                    [SCALX]         [SCALY]         [SCALZ]         [PORFAC]\n')];
dataset14_str{1}=[dataset14_str{1},sprintf('''NODE''\t\t\t\t%+e\t%+e\t%+e\t%+e\n',scalx,scaly,scalz,porfac)];
dataset14_str{1}=[dataset14_str{1},sprintf('##\t[II]\t\t[NREG(II)]\t[X(II)]\t\t[Y(II)]\t\t[Z(II)]\t\t[POR(II)]\n')];
j=1;
for i =1:nn
    if mod(i,100)==0
      fprintf('''')
    end
    if mod(i,10000)==0
      j=j+1;
      fprintf('%d of %d \n',i,nn)
    end
    %if mod(i,10000)==0
    %end
    %dataset14_st=[dataset14_st,num2str(ii(i),'%i')]
    temp=horzcat(ii(i),nreg(i),x(i),y(i),z(i),por(i));
    dataset14_str{j} = [dataset14_str{j},sprintf('\t%d\t\t%d\t%+e\t%+e\t%+e\t%+e\n', temp)];
end
fprintf('done dataset 14\n')
toc

fid = fopen('dataset14.inp','wt');
for i=1:n_string_block
    fprintf(fid, dataset14_str{i});
end
fclose(fid);
fprintf('done writting dataset 14\n')


%%% DATASET 15
fprintf('Writting dataset 15')
tic
l=(1:ne)';
lreg=zeros(ne,1)+2;
pmax=zeros(ne,1)+1.16e-11;
pmin=zeros(ne,1)+1.16e-11;
angle1=zeros(ne,1);
almax=zeros(ne,1)+0.1;
almin=zeros(ne,1)+0.1;
atmax=zeros(ne,1)+0.01;
atmin=zeros(ne,1)+0.01;
pmaxfa=1.;
pminfa=1.;
ang1fa=1.;
almaxf=2.;
alminf=2.;
atmaxf=2.;
atminf=2.;


ne_string_block=ceil(ne/10000);
dataset15_str=cell(ne_string_block,1);

dataset15_str{1}='##\n';
dataset15_str{1}=[dataset15_str{1},'## DATASET 15 ELEMENT WISE INPUT\n'];
dataset15_str{1}=[dataset15_str{1},'##                      [PMAXFA]        [PMINFA]        [ANG1FA]        [ALMAXF]        [ALMINF]        [ATMAXF]        [ATMINF]\n'];
dataset15_str{1}=[dataset15_str{1},sprintf('''ELEMENT''\t\t%+e\t%+e\t%+e\t%+e\t%+e\t%+e\t%+e\n',[pmaxfa,pminfa,ang1fa,almaxf,alminf,atmaxf,atminf])];
%dataset15_str{1}=sprintf('##\t[L]\t\t[NREG(L)]\t[PMAX(L)]\t[PMIN(L)]\t[ANGLE1(L)]\t[ALMAX(L)]\t[ALMIN(L)]\t[ATMAX(L)]\t[ATMIN(L)]\n');
dataset15_str{1}=[dataset15_str{1},sprintf('##\t[L]\t\t[NREG(L)]\t[PMAX(L)]\t[PMIN(L)]\t[ANGLE1(L)]\t[ALMAX(L)]\t[ALMIN(L)]\t[ATMAX(L)]\t[ATMIN(L)]\n')];
j=1;
for i=1:ne
    if mod(i,100)==0
      fprintf('''')
    end
    if mod(i,10000)==0
      j=j+1;
      fprintf('%d of %d \n',i,ne)
    end
    temp=[l(i),lreg(i),pmax(i),pmin(i),angle1(i),almax(i),almin(i),atmax(i),atmin(i)];
    dataset15_str{j} = [dataset15_str{j},sprintf('\t%d\t%d\t%+e\t%+e\t%+e\t%+e\t%+e\t%+e\t%+e\n', temp)];
end
fprintf('done dataset 15\n')
toc


fid = fopen('dataset15.txt','wt');
for i=1:ne_string_block
    fprintf(fid, dataset15_str{i});
end
fclose(fid);
fprintf('done writting dataset 15\n')


% dataset 22
% only apply for y
tic
node_index_mtx=reshape(ii,ny,nx);  %note node_index_mtx(52)=52
ne_mtx=reshape(l,ney,nex);
idx=1;
for j=1:nex
    for i=1:ney
        iin1(idx)=node_index_mtx(i,j);
        iin2(idx)=node_index_mtx(i+1,j);
        iin3(idx)=node_index_mtx(i+1,j+1);
        iin4(idx)=node_index_mtx(i,j+1);
        idx=idx+1;
    end
end

dataset22_str=cell(ne_string_block,1);
dataset22_str{1}= sprintf('##  DATASET 22:  Element Incidence Data\n');
dataset22_str{1}=[dataset22_str{1},sprintf('##    [LL]      [IIN(1)]        [IIN(2)]        [IIN(3)]        [IIN(4)]\n')];
dataset22_str{1}=[dataset22_str{1},sprintf('''INCIDENCE''\n')];
j=1;
for i=1:ne
    if mod(i,100)==0
      fprintf('''')
    end
    if mod(i,10000)==0
      j=j+1;
      fprintf('%d of %d \n',i,ne)
    end
    temp=[l(i),iin1(i),iin2(i),iin3(i),iin4(i)];
    dataset22_str{j} = [dataset22_str{j},sprintf('\t%d\t%d\t%d\t%d\t%d\n', temp)];
end
fprintf('done dataset 22\n')

fid = fopen('dataset22.inp','wt');

for i=1:ne_string_block
    fprintf(fid, dataset22_str{i});
end
fclose(fid);
fprintf('done writting dataset 22\n')
toc

% dataset 17

fprintf('preparing for  dataset 17\n')
left_cross_section_old_m2=  abs(inp.dy_cell_mtx(:,1))* inp.z(1);
inflow_flux_old_kgPsPm2= inp.qinc(1:104)'./left_cross_section_old_m2(2:105);  % because the top is not included

y_left_boundary_old_m=inp.y_nod_mtx(2:end,1);
y_left_boundary_new_m= y_nod_mtx(2:end,1);

node_index_ds17_new=node_index_mtx(2:end,1);

salinity_ds17=zeros(size(node_index_ds17_new))+0.0357;

inflow_flux_new_kgPsPm2=csaps(y_left_boundary_old_m,inflow_flux_old_kgPsPm2,1,y_left_boundary_new_m);
left_cross_section_new_m2=abs(dy_cell_mtx(:,1))*z(1);
inflow_rate_new_kgPs=inflow_flux_new_kgPsPm2.*left_cross_section_new_m2(2:end);

figure
plot(inflow_flux_old_kgPsPm2,y_left_boundary_old_m,'rv');hold on
plot(inflow_flux_new_kgPsPm2,y_left_boundary_new_m,'go');hold on
xlabel('inflow_flux (kg/s/m2)')
ylabel('elevation')
print(gcf,['flow_dataset17.png'],'-dpng','-r300');

left_cross_section_new_m2 =   dx_cell_mtx(:,1);

dataset17_str='';
dataset17_str=[dataset17_str,'##\n'];
dataset17_str=[dataset17_str,'##  DATASET 16:  (NOT USED)\n'];
dataset17_str=[dataset17_str,'##  DATASET 17:  Data for Fluid Source and Sinks\n'];
dataset17_str=[dataset17_str,'##  [IQCP]               [QINC]               [UINC]\n'];

for i =1:length(node_index_ds17_new);
    dataset17_str=[dataset17_str,sprintf('\t%d\t%+e\t%+e\n',[node_index_ds17_new(i),inflow_rate_new_kgPs(i),salinity_ds17(i)])];
end

%%% dataset 17 top evaporation boundary

node_index_top_evp_ds17=-node_index_mtx(1,:) ;  % negative symbole is added
surface_area_top_evp_ds17=dx_cell_mtx(1,:)*z(1);
dy_top_evp_ds17=-dy_cell_mtx(1,:);    % a negative symbol is added to make the depth as a positive number


for i =1:length(node_index_top_evp_ds17);
    dataset17_str=[dataset17_str,sprintf('\t%d\t%+e\t%+e\n',[node_index_top_evp_ds17(i),surface_area_top_evp_ds17(i),dy_top_evp_ds17(i)])];
end



dataset17_str=[dataset17_str,'00000000000000000000000000000000000000000000000000\n'];

fid = fopen('dataset17.txt','wt');
fprintf(fid, dataset17_str);
fclose(fid);

nsop=length(node_index_ds17_new)+length(node_index_top_evp_ds17);
fprintf('done writting dataset 17\n')



%  ---------------dataset 19
fprintf('preparing for  dataset 19\n')

y_right_boundary_old_m= inp.y(inp.ipbc);

pressure_right_boundary_old_pa=inp.pbc;

y_right_boundary_new_m=y_nod_mtx(:,end);
right_node_index_new_ds19=node_index_mtx(:,end);

conc_right_boundary_new_pa=zeros(size(y_right_boundary_new_m))+0.0001;

pressure_right_boundary_new_pa=csaps(y_right_boundary_old_m, pressure_right_boundary_old_pa,1 ,y_right_boundary_new_m);

figure
plot(pressure_right_boundary_old_pa,y_right_boundary_old_m, 'rv');hold on
plot(pressure_right_boundary_new_pa,y_right_boundary_new_m,'go');hold on
xlabel('pressure (pa)')
ylabel('elevation (m)')
print(gcf,['pressure_dataset 19.png'],'-dpng','-r300');

dataset19_str='';
dataset19_str=[dataset19_str,'##\n'];
dataset19_str=[dataset19_str,'##  DATASET 19:  Data for Specified Pressure Nodes\n'];
dataset19_str=[dataset19_str,'##  [IPBC]                [PBC]                [UBC]\n'];

for i =1:length(right_node_index_new_ds19);
    dataset19_str=[dataset19_str,sprintf('\t%d\t%+e\t%+e\n',[right_node_index_new_ds19(i),pressure_right_boundary_new_pa(i),conc_right_boundary_new_pa(i)])];
end
dataset19_str=[dataset19_str,'00000000000000000000000000000000000000000000000000\n'];


fid = fopen('dataset19.txt','wt');
fprintf(fid, dataset19_str);
fclose(fid);

npbc=length(right_node_index_new_ds19);
fprintf('done writting dataset 19\n')



ics=readICS(name,'inpObj',inp);


ics_pressure_pa_mtx=reshape(ics.pressure,[inp.nn1,inp.nn2]);
ics_concentration_mtx=reshape(ics.concentration,[inp.nn1,inp.nn2]);


ics_pressure_pa_new_mtx=griddata(inp.x_nod_mtx,inp.y_nod_mtx,ics_pressure_pa_mtx,x_nod_mtx,y_nod_mtx);
ics_concentration_new_mtx=griddata(inp.x_nod_mtx,inp.y_nod_mtx,ics_concentration_mtx,x_nod_mtx,y_nod_mtx);

figure
subplot(2,1,1)
contourf(inp.x_nod_mtx,inp.y_nod_mtx,ics_concentration_mtx)

subplot(2,1,2)
contourf(x_nod_mtx,y_nod_mtx,ics_concentration_new_mtx)

print(gcf,['pressure_initial.png'],'-dpng','-r300');

figure
subplot(2,1,1)
contourf(inp.x_nod_mtx,inp.y_nod_mtx,ics_pressure_pa_mtx)

subplot(2,1,2)
contourf(x_nod_mtx,y_nod_mtx,ics_pressure_pa_new_mtx)

print(gcf,['concentration_initial.png'],'-dpng','-r300');






