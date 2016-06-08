
function opt=get_minimum_evap(o)
    c=ConstantObj();
    opt=(saturated_vapor_density(o.tmi+c.kelvin)*exp(-o.phy0*c.g*c.mol_weight_water/c.R/(o.tmi+c.kelvin))...
            -saturated_vapor_density(o.tma+c.kelvin)*o.rh    )/o.ravt/c.rhow_pure_water...
	    ;


 
