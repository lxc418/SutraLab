function o=export_to_file(o,varargin)
      %   inp.export_to_file('file_name','abc');   %output to file abc.inp
      %   inp.export_to_file();  % output to file named [o.fname,'.inp']
      % 
      % 
    
    %function o=get_dy_cell_mtx(o)
    % this subfunction gets the delta y, when meshtype is 2D and regular
    
    [o.fname,  varargin] = getProp(varargin,'file_name',o.fname);
    
    filename=[o.fname,'.ics'];
    fid = fopen(filename,'wt');
 
    
    
    fprintf(fid,'##  SUTRA ICS FILE\n');
    fprintf(fid,'##\n');
    fprintf(fid,'##  DATASET 1:  OUTPUT HEADING\n');
    fprintf(fid,'##    [TITLE1]\n');
    fprintf(fid,'##    [TITLE2]\n');
    
    
    fprintf(fid, '%\t+e\n',o.tics);
    fprintf(fid, '''NONUNIFORM''\n');
    fprintf(fid,'\t%+E\t%+E\t%+E\t%+E\n',o.pm1);
    fprintf(fid, '\n');
    fprintf(fid, '''NONUNIFORM''\n');
    fprintf(fid,'\t%+E\t%+E\t%+E\t%+E\n',o.um1);
    fprintf(fid, '\n');
    
    
    fclose(fid);
end % function_export to file
