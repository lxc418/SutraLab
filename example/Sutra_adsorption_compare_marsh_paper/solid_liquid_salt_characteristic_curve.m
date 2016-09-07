clear

cs=0.231;
c=[0.001:0.001:cs,cs:0.0000001:cs+0.01,cs+0.02:0.001:0.3];

i=1;pf(i).chi1=2e-47;  ;pf(i).chi2=0.05;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
%pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];
pf(i).str=['C_s=2\times10^{13}C^{20},this study'];

% this is equivalent to select solid 500
i=2;pf(i).chi1=500;pf(i).chi2=1;
pf(i).adsp=adsorption_freundlich(max(0,c-0.265),pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

adsp_linear=2000*1000*(c-cs);
adsp_linear(adsp_linear<0)=0.00001;

adsp_linear_2=500*1000*(c-cs);
adsp_linear_2(adsp_linear_2<0)=0.00000;
adsp_linear_str=['C_s=0 when C<C_{sb};C_s=5\times10^5(C-C_{sb}) when C>=C_{sb} by Zhang et al. [2014]'];




h=figure;
i=1;
semilogy(c,pf(i).adsp,'k','linewidth',2,'displayname'...
    ,pf(i).str);hold on

semilogy(c,adsp_linear_2,'k-.','linewidth',2,'displayname'...
    ,adsp_linear_str);hold on
set(gca,'FontSize',15,'FontWeight','bold','linewidth',2)
ylabel('Mass fraction of solid salt (kg kg^{-1})','fontweight','bold','fontsize',30)
xlabel('Solute concentration (kg kg^{-1})','fontweight','bold','fontsize',30)

grid on
legend('show','Location','northwest')

saveas(h,'aasemilog.fig','fig');


