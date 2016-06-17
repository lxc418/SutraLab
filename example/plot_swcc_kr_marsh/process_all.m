clear all
a=swccObj('marsh_swcc_parameters.dat');
a.psim=-[0:0.01:5,5:0.1:10,11:1:50,51:10:100,200:10:1000,1000:100:10000,11000:1000:50000]';
a.calc_swcc('type','fayer1995');
a.calc_relativek('type','mualem1976','tortuosity',0.5);

h=figure;
set(h,'defaultlinelinewidth',2)
subplot(1,2,1)
a.plot_swcc('type','fayer1995');
title('(a)', 'HorizontalAlignment', 'left','fontsize',24)
%savefig(h,'swcc_all.fig')

set(h,'defaultlinelinewidth',2)
subplot(1,2,2)
a.plot_relativek('type','mualem1976');
title('(b)', 'HorizontalAlignment', 'left','fontsize',24)
%title('(b)','position',[1 1])
savefig(h,'Relative_permeability_swcc_marsh.fig')

