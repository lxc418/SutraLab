%% Pre-processing results
clear a
load myCustomColormap.mat;
map=myCustomColormap;
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
inp.nn1=4001;
inp.nn2=105;
inp.qinc=0.05;

% Make x and y matrix (nodes)
x_nod_mtx1=reshape(nod(1).terms{xnod_idx},[inp.nn2,inp.nn1])';
x_nod_mtx=x_nod_mtx1.';
y_nod_mtx1=reshape(nod(1).terms{ynod_idx},[inp.nn2,inp.nn1])';
y_nod_mtx=y_nod_mtx1.';
% x_ele_mtx=reshape(ele(1).terms{xele_idx},[inp.nn1-1,inp.nn2-1])';
% yele_mtx=reshape(ele(1).terms{yele_idx},[inp.nn1-1,inp.nn2-1])';

et_x_ay=nod(1).terms{xnod_idx}(bcof(1).i(105:4105));
et_y_ay=nod(1).terms{ynod_idx}(bcof(1).i(105:4105));

et_x_ay=x_nod_mtx(1,:);
et_y_ay=y_nod_mtx(1,:);

%% now we analyze the problem
a.iv=12;
a.ivy=2;
a.fs=15;

a.left =  0.08;
a.bot  =  0.80;
a.width= 0.853;
a.width2=0.823;
a.height= 0.15;
a.h_interval=0.15;
a.lw=2;
%
%
n=8000;

fs = 5; % sampling frequency
% Creating the movie : quality = 100%, no compression is used and the
% timing is adjusted to the sampling frequency of the time interval
qt=100;
%A number from 0 through 100. Higher quality numbers result in higher video quality and larger file sizes
a.fig=figure;
set(gcf,'Units','normalized', 'WindowStyle','docked','OuterPosition',[0 0 1 1]);  % maximize the plotting figure
mov =  VideoWriter('linux.avi');% avifile('pvc1.avi','quality',qt,'compression','indeo5','fps',fs);
mov.FrameRate = 5;mov.Quality=qt;
open(mov);

for n=1:1:length(nod)-1
%%
  s_mtx1=reshape(nod(n).terms{s_nod_idx},[inp.nn2,inp.nn1])';
  s_mtx=s_mtx1.';
  c_mtx1=reshape(nod(n).terms{c_nod_idx},[inp.nn2,inp.nn1])';
  c_mtx=c_mtx1.';
  p_mtx1=reshape(nod(n).terms{p_nod_idx},[inp.nn2,inp.nn1])';
  p_mtx=p_mtx1.';
%   vx_mtx=reshape(ele(n+1).terms{vx_ele_idx},[inp.nn1-1,inp.nn2-1])';
%   vy_mtx=reshape(ele(n+1).terms{vy_ele_idx},[inp.nn1-1,inp.nn2-1])';
  
  % mask matrix for water table
  p_mtx_watertable_mask=zeros(size(p_mtx))+1;
  p_mtx_watertable_mask(p_mtx<0)=0;
  % http://stackoverflow.com/questions/15716898/matlab-find-row-indice-of-first-occurrence-for-each-column-of-matrix-without-u
  [~,idx] = max(p_mtx_watertable_mask(:,sum(p_mtx_watertable_mask)>0));
  %http://stackoverflow.com/questions/32941314/matlab-get-data-from-a-matrix-with-data-row-and-column-indeces-stored-in-arrays/32941538#32941538
  p_mtx_watertable_mask = sub2ind(size(p_mtx_watertable_mask),idx,[1:size(p_mtx,2)]);
  watertable_ay=p_mtx(p_mtx_watertable_mask)/9800+y_nod_mtx(p_mtx_watertable_mask);
 
  n_fig=0;
  %% sat over x axis 
  subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width2,a.height])
  plot(et_x_ay,s_mtx(1,:),'k-','linewidth',a.lw)
  get(gca,'xtick');
  set(gca,'fontsize',15);
  xlabel('Time (day)','FontSize',a.fs);
  ylab=ylabel('Saturation','FontSize',a.fs);
  set(ylab, 'Units', 'Normalized', 'Position', [-0.06, 0.5, 0]);
  ax1 = gca;
  set(ax1,'XTickLabel','')
  axis([et_x_ay(1) et_x_ay(end) -0.1 1.1])
  title(sprintf('Simulation %f/%f  days',bcop(n).tout/3600/24,bcop(end).tout/3600/24))
  
  n_fig=n_fig+1;
  %%  plot saturation over time
  subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width,a.height])
  contourf ( x_nod_mtx,y_nod_mtx,s_mtx);hold on
%   quiver ( x_ele_mtx(1:a.iv:end,1:a.ivy:end),yele_mtx(1:a.iv:end,1:a.ivy:end)...
%         ,vx_mtx(1:a.iv:end,1:a.ivy:end),vy_mtx(1:a.iv:end,1:a.ivy:end)...
% 	,'w-','linewidth',a.lw);hold on
  %plot(et_x_ay,watertable_ay,'g-','linewidth',a.lw)
  %plot(et_x_ay,watertable_ay,'g-','linewidth',a.lw)
  colorbar
  set(gca,'fontsize',15);
  xlabel('','FontSize',a.fs);
  ylab=ylabel('Y (m)','FontSize',a.fs);
  set(ylab, 'Units', 'Normalized', 'Position', [-0.06, 0.5, 0]);
  %set(gca,'XTick',[])
    ax1 = gca;
    set(ax1,'XTickLabel','')
  %axis([et_x_ay(1) et_x_ay(end) 0.0 8.5])
  %axis([et_x_ay(1) et_x_ay(end) 4.5 5.3])
  
  n_fig=n_fig+1;
  %% concentration over x 
  subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width2,a.height])
  plot(et_x_ay,c_mtx(1,:),'k-','linewidth',a.lw)
  get(gca,'xtick');
  set(gca,'fontsize',15);
  xlabel('');
  ylab=ylabel('C (kg/kg)','FontSize',a.fs);
  set(ylab, 'Units', 'Normalized', 'Position', [-0.06, 0.5, 0]);
  ax1 = gca;
  set(ax1,'XTickLabel','')
  axis([et_x_ay(1) et_x_ay(end) -0.05 0.39])
  
  n_fig=n_fig+1;
  %% plot concentration contour
  ax4=subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width,a.height]);
  contourf ( x_nod_mtx,y_nod_mtx,(log10(c_mtx)),'LevelStep',0.05,'LineStyle','None');hold on
    caxis([-4 -0.58]);
    colormap(ax4,jet);
    c=colorbar;
    c.Ticks = [-4 -3 -1.45 -1 -0.58];
   c.TickLabels={'0','1','35','100','260'};
  %plot(et_x_ay,watertable_ay,'g-','linewidth',a.lw)
  set(gca,'fontsize',15);
  xlabel('');
  %set(gca,'XTick',[])
  ax1 = gca;
  set(ax1,'XTickLabel','')
  ylab=ylabel('C (ppt)','FontSize',a.fs);
  set(ylab, 'Units', 'Normalized', 'Position', [-0.06, 0.5, 0]);
  %axis([et_x_ay(1) et_x_ay(end) 0.0 8.5])
  %axis([et_x_ay(1) et_x_ay(end) 0.0 35])


  n_fig=n_fig+1;
  %% ET over TIME
  subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width2,a.height])
  et_mmday=-bcof(n).qin(105:4105)/inp.qinc'*3600*24;
  set(gca,'fontsize',15);
  set(gca,'XTick',[])
  plot(et_x_ay,et_mmday,'k-','linewidth',a.lw);hold off
  %xlabel('');
  ax1 = gca;
  set(ax1,'XTickLabel','')
  ylab=ylabel('Evp.(mm/day)','FontSize',a.fs);
  set(ylab, 'Units', 'Normalized', 'Position', [-0.06, 0.5, 0]);
  axis([et_x_ay(1) et_x_ay(end) -0.1 4.1])
  
  n_fig=n_fig+1;
  %% plot head over time
%   subplot('position',[a.left,a.bot-n_fig*a.h_interval,a.width2,a.height])
%   exchange_flux_mmday=bcop(n).qpl(105:4105)/inp.qinc'*3600*24;
%   plot(et_x_ay,exchange_flux_mmday,'k-','linewidth',a.lw)
%   set(gca,'fontsize',15);
%   xlabel('X (m)');
%   ylab=ylabel('flux (mm/day)','FontSize',a.fs);
%   set(ylab, 'Units', 'Normalized', 'Position', [-0.06, 0.5, 0]);
%   axis([et_x_ay(1) et_x_ay(end) -200 1050])
  
  F = getframe(gcf); % save the current figure
  writeVideo(mov,F);% add it as the next frame of the movie
end
close(mov);
saveas(a.fig,'result.fig')  ;
