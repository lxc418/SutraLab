
fid = fopen('dataset.inp','wt');

%% title
fprintf(fid,'SUTRA Model\n' );
fprintf(fid,'U.S. Geological Survey example parameter values\n' );

fprintf(fid,'##  DATASET 2:  Simulation Type and Mesh Structure\n' );
fprintf(fid,'''SUTRA VERSION 2.2 SOLUTE TRANSPORT''\n' );
fprintf(fid,'''2D REGULAR MESH''\t%d\t%d\n',[ny,nx] );
fprintf(fid,'##\n' );
fprintf(fid,'##  DATASET 3:  Simulation Control Numbers\n' );
fprintf(fid,'##    [NN]      [NE]    [NPBC]    [NUBC]    [NSOP]    [NSOU]    [NOBS]\n' );
fprintf(fid,'\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n',[nn,ne,npbc,0,nsop,0,0]);

fprintf(fid,'##\n');
fprintf(fid,'##  DATASET 4:  Simulation Mode Options\n');
fprintf(fid,'##   [CUNSAT]           [CSSFLO]            [CSSTRA]          [CREAD]  [ISTORE]\n');
fprintf(fid,'''UNSATURATED''      ''TRANSIENT FLOW''       ''TRANSIENT TRANSPORT''  ''COLD''    9999\n');
fprintf(fid,'##\n');
fprintf(fid,'##  DATASET 5:  Numerical Control Parameters\n');
fprintf(fid,'##         [UP]         [GNUP]         [GNUU]\n');
fprintf(fid,'             0.	        0.01             0.01\n');
fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'\n');


%% dataset 14
for i=1:n_string_block
    fprintf(fid, dataset14_str{i});
end
fprintf('done writting dataset 14\n')

%% dataset 15

for i=1:ne_string_block
    fprintf(fid, dataset15_str{i});
end
fprintf('done writting dataset 14\n')


%% dataset 17
fprintf(fid, dataset17_str);


%% dataset 19
fprintf(fid, dataset19_str);


%% dataset 22


for i=1:ne_string_block
    fprintf(fid, dataset22_str{i});
end
fclose(fid);
