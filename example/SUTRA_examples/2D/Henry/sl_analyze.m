%% Pre-processing results

% Make x and y matrix (nodes)
x_matrix=reshape(nod(1).terms{xnod_idx},[inp.nn1,inp.nn2]);
y_matrix=reshape(nod(1).terms{ynod_idx},[inp.nn1,inp.nn2]);

% Make x and y matrix (elements)
xele_matrix=reshape(ele(1).terms{xele_idx},[inp.nn1-1,inp.nn2-1]);
yele_matrix=reshape(ele(1).terms{yele_idx},[inp.nn1-1,inp.nn2-1]);

% Make pressure and sarutration array at top
p_top=arrayfun(@(y) y.terms{p_idx}(inp.nn1),nod);
sw_top=arrayfun(@(y) y.terms{s_idx}(inp.nn1),nod);

% Make Concentration matrix
% c_matrix = reshape(nod(nt).terms{c_idx},[inp.nn1,inp.nn2]); % Basic function
c_matrix0 = reshape(nod(1).terms{c_idx},[inp.nn1,inp.nn2]); % Initial concentration
c_matrix50 = reshape(nod(3).terms{c_idx},[inp.nn1,inp.nn2]); % Timestep 1
c_matrix100 = reshape(nod(4).terms{c_idx},[inp.nn1,inp.nn2]); % Timestep 100, 20 years

% Make Saturation matrix
%s_matrix  = reshape(nod(nt).terms{s_idx},[inp.nn1,inp.nn2]); % Basic function
s_matrix0  = reshape(nod(1).terms{s_idx},[inp.nn1,inp.nn2]); % Intial Saturation
s_matrix50  = reshape(nod(3).terms{s_idx},[inp.nn1,inp.nn2]); % Timestep 1
s_matrix100  = reshape(nod(4).terms{s_idx},[inp.nn1,inp.nn2]); % Timestep 100

% Make Velocity (x-direction) matrix (No initial velocity field)
%vx_matrix = reshape(ele(nt).terms{vx_idx}*24*3600,[inp.nn1-1,inp.nn2-1]); %Basic function (mm/d)
vx_matrix1 = reshape(ele(1).terms{vx_idx}*24*3600,[inp.nn1-1,inp.nn2-1]); % Timestep 1 (almost no velocity)
vx_matrix100 = reshape(ele(3).terms{vx_idx}*24*3600,[inp.nn1-1,inp.nn2-1]); % Timestep 100

% Make Velocity (y-direction) matrix (No initial velocity field)
%vy_matrix = reshape(ele(nt).terms{vy_idx}*24*3600,[inp.nn1-1,inp.nn2-1]); %Basic function (mm/d)
vy_matrix1 = reshape(ele(1).terms{vy_idx}*24*3600,[inp.nn1-1,inp.nn2-1]); % Timestep 1 (almost no velocity)
vy_matrix100 = reshape(ele(3).terms{vy_idx}*24*3600,[inp.nn1-1,inp.nn2-1]); % Timestep 100

%% Plot Concentration contours and velocity fields of Timestep 1
figure
suptitle('Timestep 1, 0.2 year')
ax1=subplot(3,1,1) ;      % add first plot in 3 x 1 grid
contourf(x_matrix,y_matrix,c_matrix0);
colormap(ax1,jet)
xlabel('Distance x (m)')
ylabel('Depth (m)')
a=colorbar;
a.Label.String ='Concentration (-)';

ax2=subplot(3,1,2);       % add second plot in 3 x 1 grid
contourf(xele_matrix,yele_matrix,vx_matrix1);    
colormap(ax2,parula)
xlabel('Distance x (m)')
ylabel('Depth (m)')
b=colorbar;
b.Label.String ='X-velocity (mm/d)';

ax3=subplot (3,1,3);     % add third plot in 3 x 1 grid
contourf(xele_matrix,yele_matrix,vy_matrix1); 
colormap(ax3,parula)
xlabel('Distance x (m)')
ylabel('Depth (m)')
c=colorbar;
c.Label.String ='Y-velocity (mm/d)';

hold on
%% Plot Concentration contours and velocity fields of Timestep 100, 20 years
figure
suptitle('Timestep 100, 20 years')
ax1=subplot(3,1,1) ;      % add first plot in 3 x 1 grid
contourf(x_matrix,y_matrix,c_matrix100);
colormap(ax1,jet)
xlabel('Distance x (m)')
ylabel('Depth (m)')
a=colorbar;
a.Label.String ='Concentration (-)';

ax2=subplot(3,1,2);       % add second plot in 3 x 1 grid
contourf(xele_matrix,yele_matrix,vx_matrix100);    
colormap(ax2,parula)
xlabel('Distance x (m)')
ylabel('Depth (m)')
b=colorbar;
b.Label.String ='X-velocity (mm/d)';

ax3=subplot (3,1,3);     % add third plot in 3 x 1 grid
contourf(xele_matrix,yele_matrix,vy_matrix100); 
colormap(ax3,parula)
xlabel('Distance x (m)')
ylabel('Depth (m)')
c=colorbar;
c.Label.String ='Y-velocity (mm/d)';

hold on
%% Plot concentration contours 
% % Timestep 1, 0.2 year
% figure
% contourf(x_matrix,y_matrix,c_matrix1);
% colormap(jet)
% a=colorbar;
% a.Label.String ='Concentration (-)';
% title('Concentration (-), Timestep 1')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% hold on 
% Timestep 100, 20 years
% figure
% contourf(x_matrix,y_matrix,c_matrix100);
% colormap(jet)
% a=colorbar;
% a.Label.String ='Concentration (-)';
% title('Concentration (-), Timestep 100')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% hold on 
% Timestep 1 and 100 together
figure
ax1=subplot(2,1,1) ;      % add first plot in 2 x 1 grid
contourf(x_matrix,y_matrix,c_matrix0);
colormap(ax1,jet);
title('Concentration (-), Timestep 1');
xlabel('Distance x (m)')
ylabel('Depth (m)')
a=colorbar;
a.Label.String ='Concentration (-)';

ax2=subplot(2,1,2);       % add second plot in 2 x 1 grid
contourf(x_matrix,y_matrix,c_matrix100);
colormap(ax2,jet);
title('Concentration (-), Timestep 100');
xlabel('Distance x (m)')
ylabel('Depth (m)')
b=colorbar;
b.Label.String ='Concentration (-)';
hold on
%% Plot concentration contours with flow field (white arrows) + save figure
% %Timestep 100
% figure
% contourf(x_matrix,y_matrix,c_matrix100);
% pbaspect([2 1 1])
% colormap(jet)
% a=colorbar;
% a.Label.String ='Concentration (-)';
% title('Concentration (-) and flow field, Timestep 100')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% hold on;
% quiver(xele_matrix,yele_matrix,vx_matrix100,vy_matrix100, 'color',[1 1 1],'AutoScaleFactor',3)
% print(gcf,'Island2D_Concentration_Contours_and_Flow_Field_Timestep_100.png','-dpng','-r300');
% hold on

figure
ax1=subplot(2,1,1) ;      % add first plot in 2 x 1 grid
contourf(x_matrix,y_matrix,c_matrix0);
colormap(ax1,jet);
title('Concentration (-) and flow field, Timestep 1');
xlabel('Distance x (m)')
ylabel('Depth (m)')
a=colorbar;
a.Label.String ='Concentration (-)';
hold on
quiver(xele_matrix,yele_matrix,vx_matrix1,vy_matrix1, 'color',[1 1 1],'AutoScaleFactor',0.5)

ax2=subplot(2,1,2);       % add second plot in 2 x 1 grid
contourf(x_matrix,y_matrix,c_matrix100);
colormap(ax2,jet);
title('Concentration (-) and flow field, Timestep 100');
xlabel('Distance x (m)')
ylabel('Depth (m)')
b=colorbar;
b.Label.String ='Concentration (-)';
hold on
quiver(xele_matrix,yele_matrix,vx_matrix100,vy_matrix100, 'color',[1 1 1],'AutoScaleFactor',3)
print(gcf,'Island2D_Concentration_Contours_and_Flow_Field.png','-dpng','-r300');


%% Plot velocity contours in x-direction separately
%Timestep 1, 0.2 year -> Velocities are almost zero at this time step
% figure
% contourf(xele_matrix,yele_matrix,vx_matrix1);      
% title('X-velocity (mm/d) Timestep 1')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='X-velocity (mm/d)';
% hold on 

% %Timestep 100, 20 years
% figure
% contourf(xele_matrix,yele_matrix,vx_matrix100);      
% title('X-velocity (mm/d) Timestep 1');
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='X-velocity (mm/d)';
% hold on

% Timestep 1 and 100 together
% figure
% ax1=subplot(2,1,1);     % add first plot in 2 x 1 grid
% contourf(xele_matrix,yele_matrix,vx_matrix1); 
% colormap(ax1,parula);
% title('X-velocity (mm/d), Timestep 1')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='X-velocity (mm/d)';
% 
% ax2=subplot(2,1,2);       % add second plot in 2 x 1 grid
% contourf(xele_matrix,yele_matrix,vx_matrix100);
% colormap(ax2,parula);
% title('X-velocity (mm/d), Timestep 100')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% b=colorbar;
% b.Label.String ='X-velocity (mm/d)';
% hold on

%% Plot velocity contours in y-direction separately
%Timestep 1, 0.2 year -> Velocities are almost zero at this time step
% figure
% contourf(xele_matrix,yele_matrix,vy_matrix1);      
% title('Y-velocity (mm/d) Timestep 1')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='Y-velocity (mm/d)';
% hold on 

% %Timestep 100, 20 years
% figure
% contourf(xele_matrix,yele_matrix,vy_matrix100);      
% title('Y-velocity (mm/d) Timestep 100')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='Y-velocity (mm/d)';
% hold on
% % Timestep 1 and 100 together
% figure
% ax1=subplot(2,1,1);     % add first plot in 2 x 1 grid
% contourf(xele_matrix,yele_matrix,vy_matrix1); 
% colormap(ax1,parula);
% title('Y-velocity (mm/d), Timestep 1')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='Y-velocity (mm/d)';
% 
% ax2=subplot(2,1,2);       % add second plot in 2 x 1 grid
% contourf(xele_matrix,yele_matrix,vy_matrix100);
% colormap(ax2,parula);
% title('Y-velocity (mm/d), Timestep 100')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% b=colorbar;
% b.Label.String ='Y-velocity (mm/d)';
% hold on
%% Plot velocity contours x and y together for timestep 100
figure
ax1=subplot(2,1,1);     % add first plot in 2 x 1 grid
contourf(xele_matrix,yele_matrix,vx_matrix100); 
colormap(ax1,parula);
title('X-velocity (mm/d), Timestep 100')
xlabel('Distance x (m)')
ylabel('Depth (m)')
a=colorbar;
a.Label.String ='X-velocity (mm/d)';

ax2=subplot(2,1,2);       % add second plot in 2 x 1 grid
contourf(xele_matrix,yele_matrix,vy_matrix100);
colormap(ax2,parula);
title('Y-velocity (mm/d), Timestep 100')
xlabel('Distance x (m)')
ylabel('Depth (m)')
b=colorbar;
b.Label.String ='Y-velocity (mm/d)';
hold on
%% Saturation (full size)
% % Timestep 1, 0.2 year
% figure
% contourf(x_matrix,y_matrix,s_matrix1);
% title('Saturation (-) Timestep 1')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='Saturation (-)';
% hold on
% % Timestep 100, 20 years
% figure
% contourf(x_matrix,y_matrix,s_matrix100);
% title('Saturation (-) Timestep 100')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='Saturation (-)';
% hold on
% Timestep 1 and 100 together
figure
ax1=subplot(2,1,1);     % add first plot in 2 x 1 grid
contourf(x_matrix,y_matrix,s_matrix0); 
colormap(ax1,parula);
title('Saturation (-) Timestep 1')
xlabel('Distance x (m)')
ylabel('Depth (m)')
a=colorbar;
a.Label.String ='Saturation (-)';

ax2=subplot(2,1,2);       % add second plot in 2 x 1 grid
contourf(x_matrix,y_matrix,s_matrix100);
colormap(ax2,parula);
title('Saturation (-) Timestep 100')
xlabel('Distance x (m)')
ylabel('Depth (m)')
b=colorbar;
b.Label.String ='Saturation (-)';
hold on
%% Saturation (zoomed at top)
% % Timestep 1, 0.2 year
% figure
% contourf(x_matrix(1:6,15:35),y_matrix(1:6,15:35),s_matrix1(1:6,15:35));
% title('Saturation (-) Timestep 1')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='Saturation (-)';
% hold on
% % Timestep 100, 20 years
% figure
% contourf(x_matrix(1:6,15:35),y_matrix(1:6,15:35),s_matrix100(1:6,15:35));
% title('Saturation (-) Timestep 100')
% xlabel('Distance x (m)')
% ylabel('Depth (m)')
% a=colorbar;
% a.Label.String ='Saturation (-)';
% hold on
% Timestep 1 and 100 together
figure
ax1=subplot(2,1,1);     % add first plot in 2 x 1 grid
contourf(x_matrix(1:6,15:35),y_matrix(1:6,15:35),s_matrix0(1:6,15:35));
colormap(ax1,parula);
title('Zoomed Saturation (-) Timestep 1')
xlabel('Distance x (m)')
ylabel('Depth (m)')
a=colorbar;
a.Label.String ='Saturation (-)';

ax2=subplot(2,1,2);       % add second plot in 2 x 1 grid
contourf(x_matrix(1:6,15:35),y_matrix(1:6,15:35),s_matrix100(1:6,15:35));
colormap(ax2,parula);
title('Zoomed Saturation (-) Timestep 100')
xlabel('Distance x (m)')
ylabel('Depth (m)')
b=colorbar;
b.Label.String ='Saturation (-)';
hold on
print(gcf,'Island2D_Zoomed_Saturation.png','-dpng','-r300');
