
fid = fopen('dataset.ics','wt');

fprintf(fid, '%+e\n',0);
fprintf(fid, '''NONUNIFORM''\n');
fprintf(fid,'\t%+E\t%+E\t%+E\t%+E\n',ics_pressure_pa_new_mtx(:));
fprintf(fid, '\n');
fprintf(fid, '''NONUNIFORM''\n');
fprintf(fid,'\t%+E\t%+E\t%+E\t%+E\n',ics_concentration_new_mtx(:));
fprintf(fid, '\n');

fclose(fid);
