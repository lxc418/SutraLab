
       %*********************** Function readETdat ************************
       function [tide]=readETinp(fname)
           fn=fopen(fname);
           for i=1:48
             line=fgetl(fn);
           end % i
           temp=fscanf(fn,'%g %g %g %g %g %*g %*g',[1 5]);
           line=fgetl(fn); % Reand the line again to proceed to the next line
           tide.tasp=temp(1,1);
           tide.tane=temp(1,2);
           tide.tpsp=temp(1,3);
           tide.tpne=temp(1,4);
           tide.msl=temp(1,5);
           fclose(fn);
       end % Function readETinp
       %****************************** END ********************************
