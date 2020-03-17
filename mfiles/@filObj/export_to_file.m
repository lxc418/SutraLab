function o=export_to_file(o,varargin)
      %   inp.export_to_file('file_name','abc');   %output to file abc.inp
      %   inp.export_to_file();  % output to file named [o.fname,'.inp']
      % 
      % 
    
    %function o=get_dy_cell_mtx(o)
    % this subfunction gets the delta y, when meshtype is 2D and regular
    
    %[o.fname,  varargin] = getProp(varargin,'file_name',o.fname);
    
    fid = fopen(o.uname,'wt');
 
    
    fprintf('Writting to file %s\n', o.uname);

    for i = 1:length(o.ftstr)
    %fprintf('Writting to file %s\n', o.uname);
        property_name=o.ftstr{i};
        if o.terms.(property_name).fid~=-1
            fprintf(fid, '%s\t%d\t''%s''\n',upper(property_name),o.terms.(property_name).fid,o.terms.(property_name).fname);
        end
    end
    
    
    fclose(fid);
end % function_export to file
