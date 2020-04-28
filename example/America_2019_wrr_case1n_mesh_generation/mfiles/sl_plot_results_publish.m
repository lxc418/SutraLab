
SIZE=12;
startx = [0.025,0.025,0.025,0.025,0.025,199.975,199.975,199.975,199.975,199.975,199.975];
starty = [-0.2,-1.2,-2.2,-3.2,-4.2,-0.2,-1.2,-2.2,-3.2,-4.2,-5];


%%PART C  from basecase_figure;
figure
%x=X(1,:);
x=x_matrix(1,:);
ax3=subplot('Position',[0.15 0.7 0.68 0.2]);
%y1=C_sal;
%y2=C_thick;
y3=salinity_end;
yyaxis left
plot(x,y3,'color',color1,'LineWidth',1); 
ylabel({'Salinity' '(ppt)'},'FontSize',SIZE)
set(gca,'ycolor',color1,'ylim',[0 300],'YTick',[150 300],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
yyaxis right
plot(x,y2,'k','LineWidth',1);
ylabel({'Salt crust' '(cm)'},'FontSize',SIZE)
set(gca,'ycolor','k','ylim',[0 20],'YTick',[10 20],'xlim',[0 200],'XTick',[],'TickDir','out','FontSize',SIZE)
hold on
ax1=subplot('Position',[0.15 0.5 0.68 0.2]);
%y3=C_sat;
%y4=C_evp;
y4=evaporation_end;
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
contourf(x_matrix,y_matrix,log10(c_matrix_end),'LevelStep',0.005,'LineStyle','None');hold on
set(gca,'TickDir','out','ylim',[-5.2 0.0],'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',str2mat('0.0','1.0','2.0','3.0','4.0','5.0'),...
    'xlim',[0 200],'XTick',[0 20 40 60 80 100 120 140 160 180 200],'XTicklabel',[200 180 160 140 120 100 80 60 40 20 0],'FontSize',SIZE)
xlabel('x (m)')
ylabel({'z (m)'})
caxis([-4 -0.58]);
colormap(ax2,map);
hold on
%C1=streamline(xv,yv,VXC,VYC,startx,starty,[2 40000]);
C1=streamline(x_ele_mtx,y_ele_mtx,VXC,VYC,startx,starty,[2 40000]);
set(C1,'Color','white','LineWidth',0.6)
hold on
CD1=stream2(xv,yv,VXC,VYC,startx,starty,[2 40000]);
hold on
print(gcf,['Basecase_C.png'],'-dpng','-r300');
