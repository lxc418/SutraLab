load myCustomColormap.mat;
map=myCustomColormap;
%Change the following files and number accoringly
D=basecase;
D2=basecasesatevpconc;
inp.nn1=105;
inp.nn2=4001;
z=416000;
startx = [0.025,0.025,0.025,0.025,0.025,199.975,199.975,199.975,199.975,199.975,199.975];
starty = [-0.2,-1.2,-2.2,-3.2,-4.2,-0.2,-1.2,-2.2,-3.2,-4.2,-5];
startx2 = [0.025,0.025,199.975,199.975,199.975,199.975,199.975];
starty2 = [-1.2,-3.2,-1.2,-2.2,-3.2,-4.2,-5];
SIZE=12;
%collect data
X=reshape(D(:,1),[inp.nn1,inp.nn2]);
Y=reshape(D(:,2),[inp.nn1,inp.nn2]);
xv=reshape(D(1:z,3),[inp.nn1-1,inp.nn2-1]);
yv=reshape(D(1:z,4),[inp.nn1-1,inp.nn2-1]);

CA=reshape(D(:,5),[inp.nn1,inp.nn2]);
VXA=reshape(D(1:z,6),[inp.nn1-1,inp.nn2-1]);
VYA=reshape(D(1:z,7),[inp.nn1-1,inp.nn2-1]);
SA=reshape(D(:,8),[inp.nn1,inp.nn2]);
A_sat=D2(:,2);
A_evp=D2(:,4);
A_sal=D2(:,6);
% 
CB=reshape(D(:,9),[inp.nn1,inp.nn2]);
VXB=reshape(D(1:z,10),[inp.nn1-1,inp.nn2-1]);
VYB=reshape(D(1:z,11),[inp.nn1-1,inp.nn2-1]);
SB=reshape(D(:,12),[inp.nn1,inp.nn2]);
B_sat=D2(:,8);
B_sal=D2(:,12);
B_evp=D2(:,10);

CC=reshape(D(:,13),[inp.nn1,inp.nn2]);
VXC=reshape(D(1:z,14),[inp.nn1-1,inp.nn2-1]);
VYC=reshape(D(1:z,15),[inp.nn1-1,inp.nn2-1]);
SC=reshape(D(:,16),[inp.nn1,inp.nn2]);
C_evp=D2(:,16);
C_sat=D2(:,14);
C_sal=D2(:,18);


%Salt thickness
parameter=(1-0.24)*2600*(1*10^-47)*(1000^20);
vol=0.05*0.025*1;
A_ssalt=parameter.*((A_sal/1000).^20).*vol;
A_thick=A_ssalt./2600./0.05.*100;
B_ssalt=parameter.*(B_sal/1000).^20.*vol;
B_thick=B_ssalt./2600./0.05.*100;
C_ssalt=parameter.*((C_sal/1000).^20).*vol;
C_thick=C_ssalt./2600./0.05.*100;
color1=[0.8500, 0.3250, 0.0980];
color2=[0.4660, 0.6740, 0.1880];

%%PART A
figure
x=X(1,:);
ax3=subplot('Position',[0.15 0.7 0.68 0.2]);
y1=A_sal;
y2=A_thick;
yyaxis left
plot(x,y1,'color',color1,'LineWidth',1); 
ylabel({'Salinity' '(ppt)'},'FontSize',SIZE)
set(gca,'ycolor',color1,'ylim',[0 100],'YTick',[50 100],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
yyaxis right
plot(x,y2,'k','LineWidth',1);
ylabel({'Salt crust' '(cm)'},'FontSize',SIZE)
set(gca,'ycolor','k','ylim',[0 1],'YTick',[0.5 1.0],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
hold on
ax1=subplot('Position',[0.15 0.5 0.68 0.2]);
y3=A_sat;
y4=A_evp;
yyaxis left
plot(x,y3,'LineWidth',1);
ylabel({'Saturation' '(-)'},'FontSize',SIZE)
set(gca,'ylim',[0.0 0.8],'YTick',[0.4 0.8],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
yyaxis right
plot(x,y4,'color',color2,'LineWidth',1);
ylabel({'E_{act}' '(mm/d)'},'FontSize',SIZE)
set(gca,'ycolor',color2,'ylim',[0.0 4],'YTicklabel',str2mat('0.0','2.0','4.0'),'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
hold on
ax2=subplot('Position',[0.15 0.2 0.68 0.3]);
contourf(X,Y,log10(CA),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'TickDir','out','ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',str2mat('0.0','1.0','2.0','3.0','4.0','5.0'),'xlim',[0 200],'XTick',[0 20 40 60 80 100 120 140 160 180 200],'XTicklabel',[200 180 160 140 120 100 80 60 40 20 0],'FontSize',SIZE)
xlabel('x (m)')
ylabel({'z (m)'})
caxis([-4 -0.58]);
colormap(ax2,map);
hold on
A1=streamline(xv,yv,VXA,VYA,startx,starty,[2 40000]);
set(A1,'Color','white','LineWidth',0.6)
hold on
AD1=stream2(xv,yv,VXA,VYA,startx,starty,[2 40000]);
hold on
%annotation('textbox',[.055 0.60 .5 .1],'String','4^c c','Fontsize',10,'Fontweight','bold','EdgeColor','none')
print(gcf,['Basecase_A.png'],'-dpng','-r300');

%%PART B
figure
x=X(1,:);
ax3=subplot('Position',[0.15 0.7 0.68 0.2]);
y1=B_sal;
y2=B_thick;
yyaxis left
plot(x,y1,'color',color1,'LineWidth',1); 
ylabel({'Salinity' '(ppt)'},'FontSize',SIZE)
set(gca,'ycolor',color1,'ylim',[0 300],'YTick',[150 300],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
yyaxis right
plot(x,y2,'k','LineWidth',1);
ylabel({'Salt crust' '(cm)'},'FontSize',SIZE)
set(gca,'ycolor','k','ylim',[0 70],'YTick',[35 70],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
hold on
ax1=subplot('Position',[0.15 0.5 0.68 0.2]);
y3=B_sat;
y4=B_evp;
yyaxis left
plot(x,y3,'LineWidth',1);
ylabel({'Saturation' '(-)'},'FontSize',SIZE)
set(gca,'ylim',[0.0 0.8],'YTick',[0.4 0.8],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
yyaxis right
plot(x,y4,'color',color2,'LineWidth',1);
ylabel({'E_{act}' '(mm/d)'},'FontSize',SIZE)
set(gca,'ycolor',color2,'ylim',[0.0 4],'YTicklabel',str2mat('0.0','2.0','4.0'),'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
hold on
ax2=subplot('Position',[0.15 0.2 0.68 0.3]);
contourf(X,Y,log10(CB),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'TickDir','out','ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',str2mat('0.0','1.0','2.0','3.0','4.0','5.0'),'xlim',[0 200],'XTick',[0 20 40 60 80 100 120 140 160 180 200],'XTicklabel',[200 180 160 140 120 100 80 60 40 20 0],'FontSize',SIZE)
xlabel('x (m)')
ylabel({'z (m)'})
caxis([-4 -0.58]);
colormap(ax2,map);
hold on
B1=streamline(xv,yv,VXB,VYB,startx,starty,[2 40000]);
set(B1,'Color','white','LineWidth',0.6)
hold on
BD1=stream2(xv,yv,VXB,VYB,startx,starty,[2 40000]);
hold on
print(gcf,['Basecase_B.png'],'-dpng','-r300');

%%PART C
figure
x=X(1,:);
ax3=subplot('Position',[0.15 0.7 0.68 0.2]);
y1=C_sal;
y2=C_thick;
yyaxis left
plot(x,y1,'color',color1,'LineWidth',1); 
ylabel({'Salinity' '(ppt)'},'FontSize',SIZE)
set(gca,'ycolor',color1,'ylim',[0 300],'YTick',[150 300],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
yyaxis right
plot(x,y2,'k','LineWidth',1);
ylabel({'Salt crust' '(cm)'},'FontSize',SIZE)
set(gca,'ycolor','k','ylim',[0 20],'YTick',[10 20],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
hold on
ax1=subplot('Position',[0.15 0.5 0.68 0.2]);
y3=C_sat;
y4=C_evp;
yyaxis left
plot(x,y3,'LineWidth',1);
ylabel({'Saturation' '(-)'},'FontSize',SIZE)
set(gca,'ylim',[0.0 0.8],'YTick',[0.4 0.8],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
yyaxis right
plot(x,y4,'color',color2,'LineWidth',1);
ylabel({'E_{act}' '(mm/d)'},'FontSize',SIZE)
set(gca,'ycolor',color2,'ylim',[0.0 4],'YTicklabel',str2mat('0.0','2.0','4.0'),'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
hold on
ax2=subplot('Position',[0.15 0.2 0.68 0.3]);
contourf(X,Y,log10(CC),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'TickDir','out','ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',str2mat('0.0','1.0','2.0','3.0','4.0','5.0'),'xlim',[0 200],'XTick',[0 20 40 60 80 100 120 140 160 180 200],'XTicklabel',[200 180 160 140 120 100 80 60 40 20 0],'FontSize',SIZE)
xlabel('x (m)')
ylabel({'z (m)'})
caxis([-4 -0.58]);
colormap(ax2,map);
hold on
C1=streamline(xv,yv,VXC,VYC,startx,starty,[2 40000]);
set(C1,'Color','white','LineWidth',0.6)
hold on
CD1=stream2(xv,yv,VXC,VYC,startx,starty,[2 40000]);
hold on
print(gcf,['Basecase_C.png'],'-dpng','-r300');

figure
ax2=subplot('Position',[0.13 0.4 0.77 0.3]);
contourf(X,Y,log10(CC),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'TickDir','out','ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',[0 1 2 3 4 5],'xlim',[0 200],'XTick',[0 20 40 60 80 100 120 140 160 180 200],'XTicklabel',[200 180 160 140 120 100 80 60 40 20 0],'FontSize',SIZE)
xlabel('x (m)')
ylabel('z (m)')
caxis([-4 -0.58]);
colormap(ax2,map);
c=colorbar('position', [0.13 0.17 0.77 0.02],'orientation','horizontal','TickDirection','out');
c.Ticks = [-4 -3 -1.45 -1 -0.58];
c.TickLabels={'0','1','35','100','260'};
c.FontSize=SIZE;
c.Label.String ='Concentration (ppt)';
print(gcf,['legend.png'],'-dpng','-r300');
%% TIMES
search_x=xv(1,:);
search_y=yv(:,1);


for i=1:11
    g_cell=AD1{1,i};
    for j=1:length(g_cell)
        [~,a]=min(abs(search_x-g_cell(j,1)));
        [~,b]=min(abs(search_y-g_cell(j,2)));
        distx(j)=a;
        disty(j)=b;
        search_U(j)=VXA(b,a);
        search_V(j)=VYA(b,a);
    end
    for k=1:length(distx)-1
        p(k+1)=search_x(distx(k+1))-search_x(distx(k));
        p(1)=search_x(distx(1));
        q(k+1)=search_y(disty(k+1))-search_y(disty(k));
        q(1)=search_y(disty(1));
    end
    for l=1:length(search_U)
        distance(l)=sqrt(p(l)^2+abs(q(l))^2);
        speed(l)=sqrt(search_U(l)^2+search_V(l)^2);
    end
    for m=1:length(distance)
        time(m)=distance(m)/speed(m);
    end
    TimeA(i)=sum(time)/3600/24/365;
    clear g_cell distx disty search_U search_V p q distance speed time k l m
end

for i=1:11
    g_cell=BD1{1,i};
    for j=1:length(g_cell)
        [~,a]=min(abs(search_x-g_cell(j,1)));
        [~,b]=min(abs(search_y-g_cell(j,2)));
        distx(j)=a;
        disty(j)=b;
        search_U(j)=VXB(b,a);
        search_V(j)=VYB(b,a);
    end
    for k=1:length(distx)-1
        p(k+1)=search_x(distx(k+1))-search_x(distx(k));
        p(1)=search_x(distx(1));
        q(k+1)=search_y(disty(k+1))-search_y(disty(k));
        q(1)=search_y(disty(1));
    end
    for l=1:length(search_U)
        distance(l)=sqrt(p(l)^2+abs(q(l))^2);
        speed(l)=sqrt(search_U(l)^2+search_V(l)^2);
    end
    for m=1:length(distance)
        time(m)=distance(m)/speed(m);
    end
    TimeB(i)=sum(time)/3600/24/365;
    clear g_cell distx disty search_U search_V p q distance speed time k l m
end
for i=1:11
    g_cell=CD1{1,i};
    for j=1:length(g_cell)
        [~,a]=min(abs(search_x-g_cell(j,1)));
        [~,b]=min(abs(search_y-g_cell(j,2)));
        distx(j)=a;
        disty(j)=b;
        search_U(j)=VXC(b,a);
        search_V(j)=VYC(b,a);
    end
    for k=1:length(distx)-1
        p(k+1)=search_x(distx(k+1))-search_x(distx(k));
        p(1)=search_x(distx(1));
        q(k+1)=search_y(disty(k+1))-search_y(disty(k));
        q(1)=search_y(disty(1));
    end
    for l=1:length(search_U)
        distance(l)=sqrt(p(l)^2+abs(q(l))^2);
        speed(l)=sqrt(search_U(l)^2+search_V(l)^2);
    end
    for m=1:length(distance)
        time(m)=distance(m)/speed(m);
    end
    TimeC(i)=sum(time)/3600/24/365;
    clear g_cell distx disty search_U search_V p q distance speed time k l m
end
