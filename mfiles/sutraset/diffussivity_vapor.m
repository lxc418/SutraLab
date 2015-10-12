function o=diffussivity_vapor(temp_kelvin)
   % using temperature to calculate water vapor diffusivity (m2/s)
   % input temp_kelvin (kelvin)
   % y = dv(tk) 
   % tk -- temperature in kelvin
   o=2.29e-5*(temp_kelvin/273.15).^1.75;



