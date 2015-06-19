fclose('all');
tic;
lw=3; % Line width
cz=9; % Size of marker
fz=15; % Fontsize
fl=12; % Label fontsize

fs=3; % Sampling frequency
qt=100; % A number between 0-100, wiht largr value generating high-quality video and large file size

xboun=[0,0,60,70,80,80,0]; % For plotting the domain boundary
yboun=[0,8,5,2.5,2.5,0,0];

xfil=[0,80,80,70,60,0]; % For filling the interpolated area outsie the domain
yfil=[8,8,2.5,2.5,5,8];

sx=linspace(0,80,500);  % For griddata of .nod data
sy=linspace(0,8,200);
[X,Y]=meshgrid(sx,sy);

sxe=linspace(0,80,50);  % For griddata of .ele data
sye=linspace(0,8,15);
[XE,YE]=meshgrid(sxe,sye);

h=figure;
set(gcf,'units','normalized','position',[0.05 0.35 0.9 0.35]); %  % Left,bottom,width,height
mov=VideoWriter('Marsh_ETR.avi');
mov.FrameRate=fs;
mov.Quality=qt;
open(mov);

for i=1:100; % Should be inp.nno
 
 td=a(i).TDlevel;
 if td<=5 % Calculate the intersection between marsh platform and tidal water
    xinter=80-4*td; 
 else
    xinter=160-20*td; 
 end % if
 
 conc=a1(:,:,i); % Data in .nod file at ith output
 vel=b1(:,:,i); % Data in .ele file at ith output
  
 x=conc(1,:);y=conc(2,:);p=conc(3,:);c=conc(4,:);s=conc(5,:); % Data of conc
 xe=vel(1,:);ye=vel(2,:);vx=vel(3,:);vy=vel(4,:); % Data of vel
 
 P=griddata(x,y,p,X,Y);  % Interpolate p,c,s using griddata
 C=griddata(x,y,c,X,Y);
 S=griddata(x,y,s,X,Y);
 
 VX=griddata(xe,ye,vx,XE,YE); % Interpolate vx,vy using griddata
 VY=griddata(xe,ye,vy,XE,YE);

 [cc,hc]=contourf(sx,sy,C); hold on % Plot concentration distribution
 colormap jet; box off;
 set(hc,'edgecolor','none'); % Line off
 colorbar;
 caxis([0.036 0.099]); % Set the data min & max of concentration colormap
 [cp,hp]=contour(sx,sy,P,[0 0]); hold on % Plot the watertabl e
 set(hp,'linecolor','w','linewidth',lw); box off;
 
 quiver(sxe,sye,VX,VY,'color','white','linewidth',1);hold on % Plot the flow field
   
 plot(xboun,yboun,'k-','linewidth',lw); hold on % Plot the boundary of domain
 fill(xfil,yfil,'w','linestyle','none'); hold on % Fill the interpolated area outside the domain
 plot([xinter 80],[td td],'k-','linewidth',lw); hold off % Plot the tidal level
 
 set(gca,'fontname','times new roman','fontsize',fl);
 xlabel('\it x \rm (m)','fontname','times new roman','fontsize',fz);
 ylabel('\it z \rm (m)','fontname','times new roman','fontsize',fz);
 
 time=strcat('Time: ', num2str(a(i).RealTDays),' Days');
 text(68,7.65,time,'fontname','times new roman','fontsize',fz); % Show simulation time (Days)
 
 writeVideo(mov,getframe(h));
 
end % For

close(mov);
saveas(h,'a','fig');
toc;
