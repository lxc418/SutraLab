function o=saturated_vapor_density(temp_kelvin)
    % function y = rhovs(tk)
    % (S)aturated water (V)apor density (rho) at EM(5)0 channel (C) [rhovs]
    % tk -- temperature in kelvin
    o = 1e-3*exp(19.819-4976./temp_kelvin);
	


