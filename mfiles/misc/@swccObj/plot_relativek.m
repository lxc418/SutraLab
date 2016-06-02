function o=plot_relativek(o,varargin)
%      [fname, varargin] = getNext(varargin,'char','');
      [type,  varargin] = getProp(varargin,'type',[]);

    for n=1:o.no_session
        hh=semilogy(o.por(n)*o.sw_fayer1995wrr{n},o.ksat(n)*o.kr_mualem1976wrr{n},o.line_type{n},'displayname',o.soil_type{n});hold on
    end
    set(gca,'FontSize',12,'FontWeight','bold','linewidth',2)
    xlabel('Vol. water content(-)','fontweight','bold','fontsize',20)
    ylabel('-Matric potential (m)','fontweight','bold','fontsize',20)
    grid on
    legend ('location','southeast')
end % function
