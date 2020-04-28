%% Pre-processing results
start_time=2;
last_time=7;    % To see last time step
inp.nn1=105;                % Number of rows (.INP was too large to load)
inp.nn2=4001;               % Number of columns (.INP was too large to load)
inp.qinc=0.05;              % Thickness of surface cells 
sec=3600;
day=24;
conc_limit=0.0175;          % Concentration where XL and Vf are based upon
printtime=(2920*1800)/sec;
% Make x and y matrix (nodes)
x_matrix=reshape(nod(1).terms{xnod_idx},[inp.nn1,inp.nn2]);
y_matrix=reshape(nod(1).terms{ynod_idx},[inp.nn1,inp.nn2]);

% Make x and y matrix (elements)
% xele_matrix=reshape(ele(1).terms{xele_idx},[inp.nn1-1,inp.nn2-1]);
% yele_matrix=reshape(ele(1).terms{yele_idx},[inp.nn1-1,inp.nn2-1]);

% Make pressure and sarutration array at top
p_top=arrayfun(@(y) y.terms{p_idx}(inp.nn1),nod);
sw_top=arrayfun(@(y) y.terms{s_idx}(inp.nn1),nod);

% Make Pressure matrix
% p_matrix = reshape(nod(nt).terms{p_idx},[inp.nn1,inp.nn2]); % Basic function
p_matrix_start = reshape(nod(start_time).terms{p_idx},[inp.nn1,inp.nn2]); % Initial pressure
p_matrix_end = reshape(nod(last_time).terms{p_idx},[inp.nn1,inp.nn2]); % Last Timestep

% Make Concentration matrix
% c_matrix = reshape(nod(nt).terms{c_idx},[inp.nn1,inp.nn2]); % Basic function
c_matrix_start = reshape(nod(start_time).terms{c_idx},[inp.nn1,inp.nn2]); % Initial concentration
c_matrix_end = reshape(nod(last_time).terms{c_idx},[inp.nn1,inp.nn2]); % Last Timestep

% Make Saturation matrix
%s_matrix  = reshape(nod(nt).terms{s_idx},[inp.nn1,inp.nn2]); % Basic function
s_matrix_start  = reshape(nod(start_time).terms{s_idx},[inp.nn1,inp.nn2]); % Intial Saturation
s_matrix_end  = reshape(nod(last_time).terms{s_idx},[inp.nn1,inp.nn2]); % Last Timestep

% Create Area (Only for homogeneous cell field and where depth of cells is 1m)
Area=zeros(inp.nn1,inp.nn2);
Area=Area+(inp.qinc*inp.qinc);
Area(1,:)=(inp.qinc/2)*inp.qinc;
Area(inp.nn1,:)=(inp.qinc/2)*inp.qinc;
Area(:,1)=(inp.qinc/2)*inp.qinc;
Area(:,inp.nn2)=(inp.qinc/2)*inp.qinc;
Area(1,1)=(inp.qinc/2)*(inp.qinc/2);Area(inp.nn1,1)=(inp.qinc/2)*(inp.qinc/2);Area(1,inp.nn2)=(inp.qinc/2)*(inp.qinc/2);Area(inp.nn1,inp.nn2)=(inp.qinc/2)*(inp.qinc/2);


%% Get Information

% Get saturation 
for j=last_time
    s_mtx=reshape(nod(j).terms{s_idx},[inp.nn1,inp.nn2])';
    saturation_end=s_mtx(:,1); 
end
s_mtx=reshape(nod(1).terms{s_idx},[inp.nn1,inp.nn2])';
saturation_start=s_mtx(:,1); 
% Get evaporation
for j=last_time
    evaporation_end=bcof(j).qin(inp.nn1:(inp.nn1+inp.nn2-1))/inp.qinc*-day*sec;       
end
evaporation_start=bcof(1).qin(inp.nn1:(inp.nn1+inp.nn2-1))/inp.qinc*-day*sec;
% Get salinity
for j=last_time
    c_mtx=reshape(nod(j).terms{c_idx},[inp.nn1,inp.nn2])';
    salinity_end=c_mtx(:,1)*1000;     
end
c_mtx=reshape(nod(1).terms{c_idx},[inp.nn1,inp.nn2])';
salinity_start=c_mtx(:,1)*1000;
tab=table(saturation_start,saturation_end,evaporation_start,evaporation_end,salinity_start,salinity_end);
na=['Surface_sat_evp_sal.txt'];
writetable(tab,na,'Delimiter',' '); 

%Calculate Vf (Volume of freshwater with concentration smaller than 17.5 ppt)
c=reshape(nod(last_time).terms{c_idx},[inp.nn1,inp.nn2]);
Vf=0;
for j=1:inp.nn1
    for i=1:inp.nn2
        if c(j,i)<conc_limit
            Vf=Area(j,i)+Vf;
        end
    end
end
for j=1:length(bcop)
    for k=1:inp.nn2
        if c(1,k)<conc_limit
            fresh_top(k)=x_matrix(1,k);
        else
            fresh_top(k)=x_matrix(1,inp.nn2);
        end
        if c(inp.nn1,k)<conc_limit
            fresh_bottom(k)=x_matrix(inp.nn1,k);
        else
            fresh_bottom(k)=x_matrix(1,inp.nn2);
        end
    end
    fresh_extent_top(j)=x_matrix(1,inp.nn2)-min(fresh_top);
    fresh_extent_bottom(j)=x_matrix(1,inp.nn2)-min(fresh_bottom);
    time(j)=bcop(j).tout/3600/24/365;
end
fresh_extent_top=fresh_extent_top.';
fresh_extent_bottom=fresh_extent_bottom.';
time=time.';
tab2=table(time,fresh_extent_top,fresh_extent_bottom);
na=['info.txt'];
writetable(tab2,na,'Delimiter',' ');

%% Watertable
parameter=(1-0.24)*2600*1*10^-47*1000^20;
for k=1:length(nod)
    c=reshape(nod(k).terms{c_idx},[inp.nn1,inp.nn2]);
    mass=parameter.*c.^20.*Area;
    salt(k)=sum(sum(mass));
end
for l=1:length(salt)-1
    solid_salt_efflux(l)=salt(l+1)-salt(l);
end
for i=length(bcof);  
    left_ef=0;
    left_in=0;
    riv_ef=0;
    riv_in=0;
    evap_efflux=sum(bcof(i).qin(105:4105));
    for j=1:inp.nn1-1
        if bcof(i).qin(j)<0
            left_ef=left_ef+bcof(i).qin(j);
        else
            left_in=left_in+bcof(i).qin(j);
        end
        if bcop(i).qpl(j)<0
            riv_ef=riv_ef+bcop(i).qpl(j);
        else
            riv_in=riv_in+bcop(i).qpl(j);
        end
    end
end
Evaporation_w_efflux=evap_efflux*-day*sec;
Left_w_efflux=left_ef*-day*sec;
Left_w_influx=left_in*day*sec;
River_w_efflux=riv_ef*-day*sec;
River_w_influx=riv_in*day*sec;
Total_w_influx=Left_w_influx+River_w_influx;
Total_w_efflux=Evaporation_w_efflux+Left_w_efflux+River_w_efflux;

p_Evaporation_w_efflux=((Evaporation_w_efflux)/Total_w_efflux)*100;
p_Left_w_efflux=((Left_w_efflux)/Total_w_efflux)*100;
p_Left_w_influx=((Left_w_influx)/Total_w_influx)*100;
p_River_w_efflux=((River_w_efflux)/Total_w_efflux)*100;
p_River_w_influx=((River_w_influx)/Total_w_influx)*100;
clear left_ef left_in riv_ef riv_in

for i=length(bcof);  
    left_ef=0;
    left_in=0;
    riv_ef=0;
    riv_in=0;
    evap_efflux=sum(bcof(i).qu(105:4105));
    for j=1:inp.nn1-1
        if bcof(i).qu(j)<0
            left_ef=left_ef+bcof(i).qu(j);
        else
            left_in=left_in+bcof(i).qu(j);
        end
        if bcop(i).qpu(j)<0
            riv_ef=riv_ef+bcop(i).qpu(j);
        else
            riv_in=riv_in+bcop(i).qpu(j);
        end
    end
end

Evaporation_s_efflux=evap_efflux*-day*sec;
Left_s_efflux=left_ef*-day*sec;
Left_s_influx=left_in*day*sec;
River_s_efflux=riv_ef*-day*sec;
River_s_influx=riv_in*day*sec;
salt_precipitation=solid_salt_efflux(1,last_time)/(printtime/day);
Total_s_influx=Left_s_influx+River_s_influx;
Total_s_efflux=Evaporation_s_efflux+Left_s_efflux+River_s_efflux+salt_precipitation;

p_Evaporation_s_efflux=((Evaporation_s_efflux)/Total_s_efflux)*100;
p_Left_s_efflux=((Left_s_efflux)/Total_s_efflux)*100;
p_Left_s_influx=((Left_s_influx)/Total_s_influx)*100;
p_River_s_efflux=((River_s_efflux)/Total_s_efflux)*100;
p_River_s_influx=((River_s_influx)/Total_s_influx)*100;
p_salt_prec_efflux=((salt_precipitation)/Total_s_efflux)*100;

clear left_ef left_in riv_ef riv_in
%Make table
Waterbalance = {'River';'Left boundary';'Evaporation';'Salt precipitation';'Total'};
Water_Influx = [River_w_influx;Left_w_influx;0;0;Total_w_influx];
Water_Efflux = [River_w_efflux;Left_w_efflux;Evaporation_w_efflux;0;Total_w_efflux];  
Salt_Influx = [River_s_influx;Left_s_influx;0;0;Total_s_influx];
Salt_Efflux = [River_s_efflux;Left_s_efflux;Evaporation_s_efflux;salt_precipitation;Total_s_efflux];
T_waterbalance = table(Waterbalance,Water_Influx,Water_Efflux,Salt_Influx,Salt_Efflux); 
T_waterbalance;
na=['waterbalance_K10_PART6_ET4_10year.txt'];
writetable(T_waterbalance,na,'Delimiter',' ');  
%Make table-Percentage
Waterbalance = {'River';'Left boundary';'Evaporation';'salt precipitation'};
Water_Influx = [p_River_w_influx;p_Left_w_influx;0;0];
Water_Efflux = [p_River_w_efflux;p_Left_w_efflux;p_Evaporation_w_efflux;0];  
Salt_Influx = [p_River_s_influx;p_Left_s_influx;0;0];
Salt_Efflux = [p_River_s_efflux;p_Left_s_efflux;p_Evaporation_s_efflux;p_salt_prec_efflux];
T_waterbalance = table(Waterbalance,Water_Influx,Water_Efflux,Salt_Influx,Salt_Efflux); 
T_waterbalance;
na=['Percentage_K10_PART6_ET4_10year.txt'];
writetable(T_waterbalance,na,'Delimiter',' '); 

%% Plot concentrations
% Concentration start
figure
ax2=subplot('Position',[0.1 0.5 0.8 0.3]);
contourf(x_matrix,y_matrix,log10(c_matrix_start),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',[0 1 2 3 4 5],'xlim',[0 200],'FontSize',10)
xlabel('x (m)')
ylabel('z (m)')
caxis([-4 -0.58]);
colormap(ax2,jet);
print(gcf,['Concentration_start.png'],'-dpng','-r300');

% Concentration end
figure
ax2=subplot('Position',[0.1 0.5 0.8 0.3]);
contourf(x_matrix,y_matrix,log10(c_matrix_end),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',[0 1 2 3 4 5],'xlim',[0 200],'FontSize',10)
xlabel('x (m)')
ylabel('z (m)')
caxis([-4 -0.58]);
colormap(ax2,jet);
print(gcf,['Concentration_end.png'],'-dpng','-r300');

% Start and end
figure
ax3=subplot('Position',[0.05 0.88 0.4 0.1]);
x=x_matrix(1,:);
y3=salinity_start;
plot(x,y3,'k','LineWidth',1.5);
ylabel(ax3,'Salinity (ppt)','Fontsize',8)
set(gca,'ylim',[0 300],'YTick',[100 200 300],'xlim',[0 200],'XTick',[],'FontSize',5)
hold on
ax1=subplot('Position',[0.05 0.78 0.4 0.1]);
x=x_matrix(1,:);
y1=saturation_start;
y2=evaporation_start;
yyaxis left
plot(x,y1,'LineWidth',1);
ylabel('Saturation','FontSize',5)
set(gca,'ylim',[0.0 1],'YTick',[0.5 1],'xlim',[0 200],'XTick',[],'FontSize',5)
yyaxis right
plot(x,y2,'LineWidth',1);
ylabel('Evp (mm / day)','FontSize',5)
set(gca,'ylim',[0.0 4],'xlim',[0 200],'XTick',[],'FontSize',5)
hold on

ax2=subplot('Position',[0.05 0.63 0.4 0.15]);
contourf(x_matrix,y_matrix,log10(c_matrix_start),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',[0 1 2 3 4 5],'xlim',[0 200],'FontSize',5)
xlabel('x (m)')
ylabel('z (m)')
caxis([-4 -0.58]);
colormap(ax2,jet);
hold on
ax3=subplot('Position',[0.55 0.88 0.4 0.1]);
x=x_matrix(1,:);
y3=salinity_end;
plot(x,y3,'k','LineWidth',1);
ylabel(ax3,'Salinity (ppt)','Fontsize',5)
set(gca,'ylim',[0 300],'YTick',[100 200 300],'xlim',[0 200],'XTick',[],'FontSize',5)
hold on
ax1=subplot('Position',[0.55 0.78 0.4 0.1]);
x=x_matrix(1,:);
y1=saturation_end;
y2=evaporation_end;
yyaxis left
plot(x,y1,'LineWidth',1);
ylabel('Saturation','FontSize',5)
set(gca,'ylim',[0.0 1],'YTick',[0.5 1.0],'xlim',[0 200],'XTick',[],'FontSize',5)
yyaxis right
plot(x,y2,'LineWidth',1);
ylabel('Evp (mm / day)','FontSize',5)
set(gca,'ylim',[0.0 4],'xlim',[0 200],'XTick',[],'FontSize',5)
hold on
ax2=subplot('Position',[0.55 0.63 0.4 0.15]);
contourf(x_matrix,y_matrix,log10(c_matrix_end),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',[0 1 2 3 4 5],'xlim',[0 200],'FontSize',5)
xlabel('x (m)')
ylabel('z (m)')
caxis([-4 -0.58]);
colormap(ax2,jet);
hold on
print(gcf,['start_end.png'],'-dpng','-r300');



