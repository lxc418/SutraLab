function o=plot_swcc(o,varargin)
%      [fname, varargin] = getNext(varargin,'char','');
      [type,  varargin] = getProp(varargin,'type',[]);

    for n=1:o.no_session
        hh=semilogy(o.por(n)*o.sw_fayer1995wrr{n},-o.psim,o.line_type{n},'displayname',o.soil_type{n});hold on
    end
    
    xlabel('Vol. water content(-)','fontweight','bold','fontsize',20)
    ylabel('-Matric potential (m)','fontweight','bold','fontsize',20)
    grid on

    legend ('location','northeast','Fontname','times','fontsize',20)
    set(gca,'FontSize',20,'FontWeight','bold','linewidth',2)
end % function
