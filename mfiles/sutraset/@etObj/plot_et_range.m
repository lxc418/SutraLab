function opt=plot_et_range(o,varargin)
%function opt=plot_et_range(o)
% this script aims to evaluate the evaporation range based on the selected parameters in ET.INP
% such script is to find out that when potential evaporation could become a negative value
% if 
    [nreg,  varargin] = getProp(varargin,'nreg',-1);

    c=ConstantObj();
    [~,max_adr]=min(abs(o.phy0+c.psim_log_range));
    psim=c.psim_log_range(1:max_adr);
    sw=o.get_saturation('psim',psim,'nreg',nreg);
    et=(saturated_vapor_density(o.tmi+c.kelvin)*exp(psim*c.g*c.mol_weight_water/c.R/(o.tmi+c.kelvin))...
            -saturated_vapor_density(o.tma+c.kelvin)*o.rh    )/o.ravt/c.rhow_pure_water...
	    *c.ms2mmday;

    figure;
    subplot(2,1,1)
    plot(sw,et)
    grid on
    subplot(2,1,2)
    semilogx(-psim*9800,et)
    grid on


end % function
