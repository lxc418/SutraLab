clear all
a=swccObj('carsel1988_parameters.dat');
a.psim=-[0:0.01:5,5:0.1:10,11:1:50,51:10:100,200:10:1000,1000:100:10000,11000:1000:50000]';
a.calc_swcc('type','fayer1995');
a.calc_relativek('type','mualem1976');

h=figure;
set(h,'defaultlinelinewidth',2)
subplot(1,2,1)
a.plot_swcc('type','fayer1995');
subplot(1,2,2)
a.plot_relativek('type','fayer1995');
