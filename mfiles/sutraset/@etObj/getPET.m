
function o=getPET(o)
    %function o=getPET(o)
    % get the potential evaporation rate (m/s) and store it to 
        % o.pot_evap_rate
    o.pot_evap_rate=(saturated_vapor_density(o.tmi+273.15)-...
        saturated_vapor_density(o.tma+273.15)*o.rh    )/o.ravt/1000;


 
