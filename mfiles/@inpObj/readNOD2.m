%*********************** Function readnod **************************
function [a ta a1]=readNOD2(fname,inp,outnod)
     fn=fopen(fname);
     
     for i=1:12 % Reading the first 12 rows' heading
        line=fgetl(fn);
     end
        temp=fscanf(fn,'%*s %g %g %*s %*g %*s %*g %*s %*g',[2 inp.nno]); % Time steps (1st row) and Time (sec) (2nd row)
        if inp.nno==inp.neo
          ta(1:2,:)=temp(1:2,2:inp.nno);
          ta(2,:)=ta(2,:)/24/3600; % Change time from seconds to day
        else
          ta(1:2,:)=temp(1:2,3:inp.nno);
          ta(2,:)=ta(2,:)/24/3600; % Change time from seconds to day
        end % if
        line=fgetl(fn); % Read the line again to proceed to the next line
     
     for j=1:outnod
       for i=1:5  % Read the first five rows of each out
         line=fgetl(fn);
       end % i
    
     if inp.nno==inp.neo
       if j==1  % Jump over the first round of output
         for m=1:inp.nn
            line=fgetl(fn);
         end
       else
           a(j-1).label={'x','y','p','c','s'};
           temp=fscanf(fn,'%f %g %g %g %g %g %g %g %g',[9 inp.nn]);
           a1(:,:,j-1)=temp;
           line=fgetl(fn);   % If the last column is not captured, it requires to use the previous line
           for k=1:5
             a(j-1).terms{k}=a1(k,:,j-1);
           end % for
       a(j-1).TsNumber=ta(1,j-1);  % Time steps
 	      a(j-1).RealTDays=ta(2,j-1); % Time (day)
       end % if
     else
       if j<=2  % Jump over the first round of output
         for m=1:inp.nn
            line=fgetl(fn);
         end
       else
           a(j-2).label={'x','y','p','c','s'};
           a1(:,:,j-2)=fscanf(fn,'%f %g %g %g %g %g %g %g %g',[9 inp.nn]);
           line=fgetl(fn);   % If the last column is not captured, it requires to use the previous line
           for k=1:5
             a(j-2).terms{k}=a1(k,:,j-2);
           end % for
       a(j-2).TsNumber=ta(1,j-2);  % Time steps
 	      a(j-2).RealTDays=ta(2,j-2); % Time (day)
       end % if
     end %if
     end % j
     fclose(fn);
    end % Funtion readnod
%****************************** END ********************************

