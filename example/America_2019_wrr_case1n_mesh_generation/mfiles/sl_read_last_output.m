clear all
close all
% project name
name='PART6';

C=ConstantObj;

function sl_read_from(a)
    if_mat_exist=exist([name,'.mat']);
    % read input files
    %inp=i0('desaline');
    if if_mat_exist==0 
        fprintf('no mat file exist\n')
        inp  = inpObj(  name,'block_reading','yes');
        nod  = readNOD( name,'outputfrom',a);
        ele  = readELE( name,'outputfrom',a);
        bcop = readBCOP(name,'outputfrom',a);
        bcof = readBCOF(name,'outputfrom',a);
        
        % index for p c and s
        xnod_idx  = strcmp(nod(1).label,'X');
        ynod_idx  = strcmp(nod(1).label,'Y');
        znod_idx  = strcmp(nod(1).label,'Z');
        p_idx  = strcmp(nod(1).label,'Pressure');
        c_idx  = strcmp(nod(1).label,'Concentration');
        s_idx  = strcmp(nod(1).label,'Saturation');
        %sm_idx = strcmp(nod(1).label,'SM');
        
        
        xele_idx = strcmp(ele(1).label,'X origin');
        yele_idx = strcmp(ele(1).label,'Y origin');
        %zele_idx = strcmp(ele(1).label,'Z origin');
        
        vx_idx = strcmp(ele(end).label,'X velocity');
        vy_idx = strcmp(ele(end).label,'Y velocity');
        %vz_idx = strcmp(ele(1).label,'Z velocity');
        fprintf('save to mat\n')
        save(name,'-v7.3');
    else
        fprintf('mat file exist\n');
        load([name,'.mat']);
    end
end
