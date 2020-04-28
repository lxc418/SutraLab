%% Pre-processing results
clear a
load myCustomColormap.mat;
map=myCustomColormap;
set(groot,'defaultLineLineWidth',2.0)

xnod_idx  = strcmp(nod(1).label,'X');
ynod_idx  = strcmp(nod(1).label,'Y');
z_nod_idx  = strcmp(nod(1).label,'Z');
p_nod_idx  = strcmp(nod(1).label,'Pressure');
c_nod_idx  = strcmp(nod(1).label,'Concentration');
s_nod_idx  = strcmp(nod(1).label,'Saturation');
sm_nod_idx = strcmp(nod(1).label,'SM');


xele_idx = strcmp(ele(1).label,'X origin');
yele_idx = strcmp(ele(1).label,'Y origin');
z_ele_idx = strcmp(ele(1).label,'Z origin');

vx_ele_idx = strcmp(ele(1).label,'X velocity');
vy_ele_idx = strcmp(ele(1).label,'Y velocity');
vz_ele_idx = strcmp(ele(1).label,'Z velocity');
%inp.nn1=4001;
%inp.nn2=105;
%inp.qinc=0.05;
evp_node_index_in_bcof=inp.nn1:inp.nsop;

% Make x and y matrix (nodes)
x_nod_mtx1=reshape(nod(1).terms{xnod_idx},[inp.nn1,inp.nn2])';
x_nod_mtx=x_nod_mtx1.';
y_nod_mtx1=reshape(nod(1).terms{ynod_idx},[inp.nn1,inp.nn2])';
y_nod_mtx=y_nod_mtx1.';
x_ele_mtx1=reshape(ele(1).terms{xele_idx},[inp.nn1-1,inp.nn2-1])';
x_ele_mtx=rot90(x_ele_mtx1,1);
%x_ele_mtx=x_ele_mtx.';
yele_mtx1=reshape(ele(1).terms{yele_idx},[inp.nn1-1,inp.nn2-1])';
yele_mtx=yele_mtx1.';

et_x_ay=nod(1).terms{xnod_idx}(bcof(1).i(evp_node_index_in_bcof));
et_y_ay=nod(1).terms{ynod_idx}(bcof(1).i(evp_node_index_in_bcof));

et_x_ay=x_nod_mtx(1,:);
et_y_ay=y_nod_mtx(1,:);

parameter=(1-0.24)*2600*(1*10^-47)*(1000^20);
vol=0.05*0.025*1;
color1=[0.8500, 0.3250, 0.0980];
color2=[0.4660, 0.6740, 0.1880];
color3=[0.343, 0.757, 0.9282];
startx = [0.025,0.025,0.025,0.025,0.025,199.975,199.975,199.975,199.975,199.975,199.975];
starty = [-0.2,-1.2,-2.2,-3.2,-4.2,-0.2,-1.2,-2.2,-3.2,-4.2,-5];

startx_idx=zeros(1,length(startx));
starty_idx=zeros(1,length(starty));
for i =1:5
  [~,starty_idx(i)]=  min(abs(yele_mtx(:,1) -starty(i))) ;
end

for i =6:length(starty)
  [~,starty_idx(i)]=  min(abs(yele_mtx(:,end) -starty(i))) ;
end

%[~,startx_idx(i)]=  min(abs([x_ele_mtx(1,:),x_ele_mtx(end,:)]-startx(i))) ;
startx_in_ele=[x_ele_mtx(starty_idx(1:5),1);x_ele_mtx(starty_idx(6:end),end)]';
starty_in_ele=[yele_mtx(starty_idx(1:5),1);yele_mtx(starty_idx(6:end),end)]';


%start_ay=[startx;starty]'
%[~, index] = ismember( start_ay, [x_ele_mtx(:) x_ele_mtx(:)], 'rows' );
%[~, index] = ismember( start_ay, [x_ele_mtx(:) x_ele_mtx(:)], 'rows' );



%% now we analyze the problem

a.iv=12;
a.ivy=2;
a.fs=26;
a.fontsize=26;
a.axislinewidth=3;

%a.left =  0.08;
a.left =  0.15;
a.bot  =  0.7;
a.width= 0.68;
a.width2=0.68;
a.height= 0.2;
a.h_interval=0.2;
a.lw=3;
%
%
%n=8000;

fs = 5; % sampling frequency
% Creating the movie : quality = 100%, no compression is used and the
% timing is adjusted to the sampling frequency of the time interval
qt=100;
%A number from 0 through 100. Higher quality numbers result in higher video quality and larger file sizes
fig=figure;
%set(gcf,'Units','normalized', 'WindowStyle','docked','OuterPosition',[0 0 1 1]);  % maximize the plotting figure
set(gcf,'Units','normalized' ,'OuterPosition',[0 0 1 1]);  % maximize the plotting figure
%mov =  VideoWriter('linux.avi');% avifile('pvc1.avi','quality',qt,'compression','indeo5','fps',fs);
%mov.FrameRate = 5;mov.Quality=qt;
%open(mov);



fprintf('Now Drawing graph\n')
%
%for n=length(nod)-2:1:length(nod)-2
%for n=length(nod):1:length(nod)  % this is the way to draw the very last result
%for n=length(nod):1:length(nod)  % this is the way to draw the very last result  % verstrange that bcof and bcop does not fully output the last snapshot

%%
  s_mtx1=reshape(nod(n).terms{s_nod_idx},[inp.nn1,inp.nn2])';
  s_mtx=s_mtx1.';
  c_mtx1=reshape(nod(n).terms{c_nod_idx},[inp.nn1,inp.nn2])';
  c_mtx=c_mtx1.';
  p_mtx1=reshape(nod(n).terms{p_nod_idx},[inp.nn1,inp.nn2])';
  p_mtx=p_mtx1.';
  vx_mtx1=reshape(ele(n).terms{vx_ele_idx},[inp.nn1-1,inp.nn2-1])';
  vx_mtx=vx_mtx1.';
  vy_mtx1=reshape(ele(n).terms{vy_ele_idx},[inp.nn1-1,inp.nn2-1])';
  vy_mtx=vy_mtx1.';
  % mask matrix for water table
  p_mtx_watertable_mask=zeros(size(p_mtx))+1;
  p_mtx_watertable_mask(p_mtx<0)=0;
  % http://stackoverflow.com/questions/15716898/matlab-find-row-indice-of-first-occurrence-for-each-column-of-matrix-without-u
  [~,idx] = max(p_mtx_watertable_mask(:,sum(p_mtx_watertable_mask)>0));
  %http://stackoverflow.com/questions/32941314/matlab-get-data-from-a-matrix-with-data-row-and-column-indeces-stored-in-arrays/32941538#32941538
  p_mtx_watertable_mask = sub2ind(size(p_mtx_watertable_mask),idx,[1:size(p_mtx,2)]);
  watertable_ay=p_mtx(p_mtx_watertable_mask)/9800+y_nod_mtx(p_mtx_watertable_mask);
 
  n_fig=0;
 
    %% concentration over x 
  subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width2,a.height])
  yyaxis left
  plot(et_x_ay,c_mtx(1,:)*1000,'color',color1,'linewidth',a.lw); 
  get(gca,'xtick');
  set(gca,'fontsize',a.fontsize,'TickDir','out','xlim',[0 200],'XTick',[],'ylim',[0 300],'YTick',[150 300],'fontweight','normal');
  xlabel('');
  ylabel({'Salinity' '(ppt)'},'FontSize',a.fs)
  set(gca,'ycolor', color1, 'Units', 'Normalized','linewidth',a.axislinewidth,'layer','Top');
  ax1 = gca;
  set(ax1,'XTickLabel','')
  yyaxis right
  ssalt=parameter.*((c_mtx(1,:)).^20).*vol;
  sthick=ssalt./2600./inp.dx_cell_mtx(1,:).*100;
  plot(et_x_ay,sthick,'k','LineWidth',a.lw);
  get(gca,'xtick');
  set(gca,'fontsize',a.fontsize,'TickDir','out','xlim',[0 200],'XTick',[],'ylim',[0 20],'YTick',[10 20]);
  xlabel('');
  ylh=ylabel({'Salt crust' '(cm)'},'FontSize',a.fs);
  ylh.Position(1) = ylh.Position(1) + 5;

  set(gca,'ycolor', 'k', 'Units', 'Normalized','linewidth',a.axislinewidth,'layer','Top');

  tit=title(sprintf('%.1f years',bcop(n).tout/3600/24/365));
  set(tit,'position',get(tit,'position')+[0 30.4 0]);
  ax1.XRuler.Axle.LineWidth = a.axislinewidth;
  ax1.YRuler.Axle.LineWidth = a.axislinewidth;
  %ax1.YAxis.LineWidth = 5;

  n_fig=n_fig+1;
  %% sat over x axis 
  subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width2,a.height])
  et_mmday=-bcof(n).qin(evp_node_index_in_bcof)./inp.qinc(evp_node_index_in_bcof)'*3600*24;
  yyaxis left
  plot(et_x_ay,s_mtx(1,:),'color', color3,'linewidth',a.lw); 
  get(gca,'xtick');
  set(gca,'fontsize',a.fontsize,'TickDir','out','xlim',[0 200],'XTick',[],'ylim',[0.0 0.8],'YTick',[0.4 0.8]);
  xlabel('');
  %ylh=ylabel({'Saturation\ \ (-)'},'FontSize',a.fs)
  ylh=ylabel({'Saturation' '(-)'},'FontSize',a.fs);
  %xlh = xlabel('x label');
  ylh.Position(1) = ylh.Position(1) - abs(ylh.Position(1) * 0.1);
  set(gca,'ycolor',color3,'Units', 'Normalized','linewidth',a.axislinewidth,'layer','Top');
  ax1 = gca;
  ax1.XRuler.Axle.LineWidth = a.axislinewidth;
  ax1.YRuler.Axle.LineWidth = a.axislinewidth;
  set(ax1,'XTickLabel','')
  yyaxis right
  plot(et_x_ay,et_mmday,'color',color2,'LineWidth',a.lw);
  get(gca,'xtick');
  set(gca,'fontsize',a.fontsize,'TickDir','out','xlim',[0 200],'XTick',[],'ylim',[0.0 4],'YTicklabel',str2mat('0.0', '2.0','4.0'));
  xlabel('');
  ylabel({'E_{act}' '(mm/d)'},'FontSize',a.fs)
  set(gca,'ycolor', color2, 'Units', 'Normalized','linewidth',a.axislinewidth,'layer','Top');
  
  n_fig=n_fig+1;
%   %%  plot saturation over time

  fprintf('drawing concentration\n')

  %% plot concentration contour
  ax4=subplot('position',[a.left,0.20,a.width,a.height+0.1]);
  if  sum(sum(c_mtx<0)) >0
    tmp=find(c_mtx<0);
    fprintf('negative concentration exists, so far %d  points! the first point at x,y (%d,%d) \n',  sum(sum(c_mtx<0)),x_nod_mtx(tmp(1)),y_nod_mtx(tmp(1)))
  end
  contourf ( x_nod_mtx,y_nod_mtx,real(log10(c_mtx)),'LevelStep',0.05,'LineStyle','None');hold on
 
  caxis([-4 -0.58]);
  colormap(ax4,map);
  c=colorbar('position', [0.5 0.1 0.4 0.02],'orientation','horizontal','TickDirection','out');
  c.Ticks = [-4 -3 -1.45 -1 -0.58];
  c.TickLabels={'0','1','35','100','260'};
  c.Label.String ='Concentration (ppt)';
  set(gca,'fontsize',a.fs,'TickDir','out','ylim',[-5.2 0.0],'linewidth',2,...
     'YTick',[-5.2 -4.2 -3.2 -2.2 -1.2 -0.2],'YTicklabel',str2mat('0.0','1.0','2.0','3.0','4.0','5.0'),'xlim',[0 200],'XTick',[0 20 40 60 80 100 120 140 160 180 200],'XTicklabel',[200 180 160 140 120 100 80 60 40 20 0]);
  xlabel('');
  ax1 = gca;
  ax1.XRuler.Axle.LineWidth = a.axislinewidth;
  ax1.YRuler.Axle.LineWidth = a.axislinewidth;
  hold on
  %B1=streamline(x_ele_mtx,yele_mtx,vx_mtx,vy_mtx,startx,starty,[2 40000]);
  B1=streamline(x_ele_mtx,yele_mtx,vx_mtx,vy_mtx,startx_in_ele,starty_in_ele,[2 40000]);
  % becareful that the start point needs to be in the x_ele_mtx and yele_mtx.
  %B1=streamline(x_ele_mtx,yele_mtx,vx_mtx,vy_mtx,x_ele_mtx(end-5:end,1),yele_mtx(end-5:end,1),[2 40000]);
  %set(B1,'Color','white','LineWidth',0.6)
  set(B1,'Color','white','LineWidth',2)

  n_fig=n_fig+1;
  
  F = getframe(gcf); % save the current figure
%  writeVideo(mov,F);% add it as the next frame of the movie
%end
%close(mov);
saveas(fig,'result.fig')  ;
%print(fig,['result_publish.png'],'-dpng','-r300');
print(fig,['result_publish.png'],'-dpng','-r600');
