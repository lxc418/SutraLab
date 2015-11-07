function o=relative_humidity(matric_potential, temperature_kelvin)
%function o=relative_humidity(matric_potential, temperature_kelvin)
   o=exp(matric_potential*9.8*0.018/8.314/temperature_kelvin);



