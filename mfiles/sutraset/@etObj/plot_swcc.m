function o=plot_swcc(o,varargin)
    [psim,  varargin] = getProp(varargin,'psim',-[0.1:0.1:1,2:1:10,20:10:100,200:100:1000,2000:1000:50000]);
    [type,  varargin] = getProp(varargin,'type',[]);
    [nreg,  varargin] = getProp(varargin,'nreg',[]);

    figure;
    if nreg==1
        tmp=SWCC_Fayer1995WRR(psim,-1/o.aa1,o.vn1,-o.phy0,o.swres1);
        hh=semilogy(tmp,-psim,'ro','displayname','soil water retention curve');hold on;
    elseif nreg==2
        tmp=SWCC_Fayer1995WRR(psim,-1/o.aa2,o.vn2,-o.phy0,o.swres2);
        hh=semilogy(tmp,-psim,'ro','displayname','soil water retention curve');hold on;
    end
    set(gca,'FontSize',12,'FontWeight','bold','linewidth',2)
    xlabel('Vol. water content(-)','fontweight','bold','fontsize',20)
    ylabel('-Matric potential (m)','fontweight','bold','fontsize',20)
    grid on
    legend show
end % function

