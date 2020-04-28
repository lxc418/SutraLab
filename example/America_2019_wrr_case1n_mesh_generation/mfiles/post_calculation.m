%% caclulate lenth area
cell_area_m2=abs(inp.dx_cell_mtx.*inp.dy_cell_mtx);
c_fresh_saline_intersection=0.0175;
lens_mask_mtx=(c_mtx<0.0175);
lens_area_m2=sum(cell_area_m2(lens_mask_mtx));




str0=sprintf('working directiory is          : %s \n',pwd);
fprintf('%s',str0);
str1=sprintf('lens area is                               : %d m2\n',lens_area_m2);

fprintf('%s',str1);



c_bottom=c_mtx(end,:);
dx_cell_bottom=inp.dx_cell_mtx(end,:);

mask_xb=(c_bottom<c_fresh_saline_intersection);
length_lens_bottom_xb_m=sum(dx_cell_bottom(mask_xb));



str2=sprintf('the length of the bottom of the lens is    : %d m\n',length_lens_bottom_xb_m);
fprintf('%s',str2);


c_top=c_mtx(1,:);
dx_cell_top=inp.dx_cell_mtx(1,:);

mask_xl_top=(c_top<c_fresh_saline_intersection);
length_lens_top_xl_m=sum(dx_cell_top(mask_xl_top));



str3=sprintf('the length of the top of the lens is       : %d m\n',length_lens_top_xl_m);

fprintf('%s',str3);


recharge_from_river_m3Pday= sum(bcop(end).qpl(bcop(end).qpl>0))/C.rhow_pure_water*C.secPday;

str4=sprintf('the total freshwater recharge inflow is    : %d m3/day\n',recharge_from_river_m3Pday);
fprintf('%s',str4);



bcop_mask_discharge_to_river=bcop(end).qpl<0;

density_discharge_kgPkg=  C.rhow_pure_water+ inp.drwdu*   bcop(end).uucut(bcop_mask_discharge_to_river);


discharge_to_river_m3Pday= sum(bcop(end).qpl( bcop_mask_discharge_to_river  )./density_discharge_kgPkg)*C.secPday;

str5=sprintf('the total saltwater discharge outflow is   : %d m3/day\n',discharge_to_river_m3Pday);

fprintf('%s',str5);


bcof_mask_saltwater_inflow_idx=strcmp(bcof(end).ibc,'INP');
c_seawater=0.035;



c_saltwater_inflow=bcof(end).uucut(bcof_mask_saltwater_inflow_idx);


density_seawater_inflow_kgPm3=C.rhow_pure_water+ inp.drwdu*c_saltwater_inflow   ;

total_saltwater_inflow_qs_m3Pday=sum(bcof(end).qin(bcof_mask_saltwater_inflow_idx)./density_seawater_inflow_kgPm3)*C.secPday   ;    


str6=sprintf('the total saltwater inflow is              : %d m3/day\n',total_saltwater_inflow_qs_m3Pday);
fprintf('%s',str6);

bcof_mask_evaporation_outflow_idx=strcmp(bcof(end).ibc,'BCTIME');

total_evaporation_outflow_m3Pday=sum(bcof(end).qin(bcof_mask_evaporation_outflow_idx))/C.rhow_pure_water*C.secPday   ;

str7=sprintf('the total evaporation outflow is           : %d m3/day\n',total_evaporation_outflow_m3Pday);
fprintf('%s',str7);

total_water_mass_error_m3Pday=total_evaporation_outflow_m3Pday+total_saltwater_inflow_qs_m3Pday+discharge_to_river_m3Pday+recharge_from_river_m3Pday;

relative_water_mass_error=total_water_mass_error_m3Pday/( total_saltwater_inflow_qs_m3Pday+recharge_from_river_m3Pday  );

str8=sprintf('water mass balance error is                : %d m3/day\n',total_water_mass_error_m3Pday);
fprintf('%s',str8);
str9=sprintf('relative mass balance error is             : %d \n',relative_water_mass_error);
fprintf('%s',str9);




f=fopen('simulation_summary.txt','w');

fprintf(f,'%s',str0);
fprintf(f,'%s',str1);
fprintf(f,'%s',str2);
fprintf(f,'%s',str3);
fprintf(f,'%s',str4);
fprintf(f,'%s',str5);
fprintf(f,'%s',str6);
fprintf(f,'%s',str7);
fprintf(f,'%s',str8);
fprintf(f,'%s',str9);
fclose(f);




