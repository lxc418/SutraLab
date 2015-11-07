clear

c=[0.001:0.001:0.3];


i=1;pf(i).chi1=0.003;pf(i).chi2=0.24;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];
i=2;pf(i).chi1=0.03 ;pf(i).chi2=0.6;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];
i=3;pf(i).chi1=0.3  ;pf(i).chi2=0.8;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];
i=4;pf(i).chi1=0.3  ;pf(i).chi2=0.7;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];
i=5;pf(i).chi1=0.3  ;pf(i).chi2=0.4;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];
i=6;pf(i).chi1=0.003  ;pf(i).chi2=0.3;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=7;pf(i).chi1=0.000003  ;pf(i).chi2=0.28;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=8;pf(i).chi1=0.000001  ;pf(i).chi2=0.27;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=9;pf(i).chi1=0.00000005  ;pf(i).chi2=0.24;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=10;pf(i).chi1=0.0000000005  ;pf(i).chi2=0.20;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];
i=11;pf(i).chi1=5e-15  ;pf(i).chi2=0.14;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=12;pf(i).chi1=5e-20;  ;pf(i).chi2=0.11;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=13;pf(i).chi1=2e-20;  ;pf(i).chi2=0.11;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=14;pf(i).chi1=2e-25;  ;pf(i).chi2=0.09;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];


i=14;pf(i).chi1=1e-47;  ;pf(i).chi2=0.05;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

i=15;pf(i).chi1=1e-46;  ;pf(i).chi2=0.05;
pf(i).adsp=adsorption_freundlich(c,pf(i).chi1,pf(i).chi2);
pf(i).str=['freundlich, chi1=',num2str(pf(i).chi1),', chi2=',num2str(pf(i).chi2)];

cs=0.265;

adsp_linear=2000*1000*(c-0.265);
adsp_linear(adsp_linear<0)=0.00001;

adsp_linear_2=100*1000*(c-0.265);
adsp_linear_2(adsp_linear_2<0)=0.00000;


i=1;pa(i).chi1=1;pa(i).chi2=0.24;
a(i).str=['langmuir, chi1=',num2str(pa(i).chi1),', chi2=',num2str(pa(i).chi2)];
pa(i).adsp=adsorption_langmuir(c,pa(i).chi1,pa(i).chi2);
i=2;pa(i).chi1=1;pa(i).chi2=2.24;
pa(i).str=['langmuir, chi1=',num2str(pa(i).chi1),', chi2=',num2str(pa(i).chi2)];
pa(i).adsp=adsorption_langmuir(c,pa(i).chi1,pa(i).chi2);

i=3;pa(i).chi1=10;pa(i).chi2=2.24e-2;
pa(i).str=['langmuir, chi1=',num2str(pa(i).chi1),', chi2=',num2str(pa(i).chi2)];
pa(i).adsp=adsorption_langmuir(c,pa(i).chi1,pa(i).chi2);

h=figure;
i=1;
plot(c,pa(i).adsp,'r-','linewidth',2,'displayname'...
    ,pa(i).str);hold on

i=2;
plot(c,pa(i).adsp,'g-','linewidth',2,'displayname'...
    ,pa(i).str);hold on

i=3;
plot(c,pa(i).adsp,'b-','linewidth',2,'displayname'...
    ,pa(i).str);hold on
    
plot(c,adsp_linear_2,'m:','linewidth',2,'displayname'...
    ,'linear500');hold on

i=3;
plot(c,pf(i).adsp,'b-.','linewidth',2,'displayname'...
    ,pf(i).str);hold on


i=11;
plot(c,pf(i).adsp,'r-.','linewidth',2,'displayname'...
    ,pf(i).str);hold on

i=12;
plot(c,pf(i).adsp,'k-.','linewidth',2,'displayname'...
    ,pf(i).str);hold on
i=13;
plot(c,pf(i).adsp,'m-.','linewidth',2,'displayname'...
    ,pf(i).str);hold on
    
i=14;
plot(c,pf(i).adsp,'c-.','linewidth',2,'displayname'...
    ,pf(i).str);hold on

i=15;
plot(c,pf(i).adsp,'y-.','linewidth',2,'displayname'...
    ,pf(i).str);hold on

legend('show','Location','northwest')

saveas(h,'solid500_equivalent.fig','fig');


print(h,'-djpeg','-r300','solid500_equivalent.jpg')

