function et=readBCO(fname,inp,nod)
%function [xyf,xyr,et1,aet1,avet1,et]=readbco(fname,p,nod)
       fn=fopen(fname);
       line=fgetl(fn);
       %et=struct;
       temp=fscanf(fn,'%*g %*g %*g %*g %g %g %g %g %g %g ', [6 inp.nsop]);  
       % NODE, X,Y,Z,XX,YY,HAREA,VAREA,FAREA,R
       xyf(4:6,:)=temp(3:5,:); 
       % xyf(1,source/sink node number) node sequence
       % xyf(2,source/sink node number) x position
       % xyf(3,source/sink node number) y position
       % xyf(4,source/sink node number) area of each node in xy panel
       % xyf(5,source/sink node number) area of node in yz panel (varea)
       % xyf(6,source/sink node number) area of node in xy panel (farea)
       xyr=temp([1:2,6],:);
       % xyr(1, source/sink node number) is xx
       % xyr(2, source/sink node number) is yy
       % xyr(3, source/sink node number) is R in cylindrical coordinate
       % how to vectorize it?
       % calculating evaporation rate
       % the disadvantage of this method is that the next node could 
       % also be affected 
       % by the node below.
       % so to some extent the result from .bcof is kind of useless
       % instead, the best way of getting the accumulative evaporation
       %rate is from et1
       %for i=1:f2(4)                          % time step increasement
       %tf1(3,i)=sum(bcof1(1,1:6,i)./xyf(4,1:6));
       %end
       %tf1(3,:)=tf1(3,:)*86400/(p.nnh);      
       % p.neh is the overall node on the surface
       
       % further read about the evaporation rate
       line=fgetl(fn);
       
       % the format of %g can be less than the numbers in the [  ]. 
       %in that case, the
       %data obtain will repeat using the pattern given by %g. 
       temp=fscanf(fn, '%g', [(inp.nn2+2) inp.ntmax]); 
%       % here using only one %g would be enough
%       % notice: temp here stores the evaporation rate at all time steps
%       %, which is
%       % important to obtain the precise
%       % result for the accumulative evaporation. however, et1 only
%       %stores the 
%       % evaporation rate at perticular snapshot
%       % this is due to too large array size.
%       
       et1=zeros(inp.nn2,length(nod));
       aet1=zeros(inp.nn2,length(nod));
       for i=1:length(nod)  % loop for each snapshot
          if i==1
              if nod(i).itout==0
                et1(:,i)=-temp(3:inp.nn2+2,nod(i+1).itout)*3600*24*1000;   
                %3600*24*1000 changes the unit from m/s to mm/day
                aet1(:,i)=-temp(3:inp.nn2+2,nod(i+1).itout)*inp.scalt*1000;   
                % unit (mm), 1000 is used to change the unit from m to mm
              elseif nod(i).itout==1
                et1(:,i)=-temp(3:inp.nn2+2,nod(i).itout)*3600*24*1000;   
                %3600*24*1000 changes the unit from m/s to mm/day
                aet1(:,i)=-temp(3:inp.nn2+2,nod(i).itout)*inp.scalt*1000;   
                % unit (mm), 1000 is used to change the unit from m to mm
              end
                  
          else
              et1(:,i)=-temp(3:inp.nn2+2,nod(i).itout)*3600*24*1000;  
              % unit mm/day
              aet1(:,i)=aet1(:,i-1)- ...
              sum( temp(3:inp.nn2+2,nod(i-1).itout+1:nod(i).itout)  ,2) *inp.scalt*1000;
          end
        et(i).steps     = nod(i).itout;
        et(i).t_elapsed = nod(i).tout;
        et(i).label     = {'et','aet'};
        et(i).terms{1}  = et1(:,i)' /3600/24/1000;
        et(i).terms{2}  = aet1(:,i)'/3600/24/1000;
       end
%       % avet1 -- the accumulated evaporation on the whole surface.
%       %algorithm= et*area/whole area
%       avet1=(xyf(4,1:p.nnh)*aet1(2:(p.neh+2),:))/sum(xyf(4,1:p.nnh));
%       % et1=temp(2:p.nnh+2,1:f2(8));  % delete the first line
%       % et1(2:(p.neh+2),:)=-et1(2:(f3(6)+2),:).*(3600*24*1000); 
%       %change m/s to mm/day
%       
%       % -- calculate the accumulative evaporation rate, then store it 
%       % in aet1, this
%       %   is used in the figure of accumulative 
%       %  evaporation rate
%       % aet1(1,:) % duration of the time snapshot
%       % aet1(2,:) % accumulative evaporation rate from the whole surface,
%       % (mm) remember
%       %    , this result is regardless of the area.
%       
%       
%       
%       %aet1(1,:)=et1(1,:);
%       %for i=1:p.neo   % time step loops
%       %   if i==1
%       %    aet1(2:(p.neh+2),i)=et1(2:(f3(6)+2),i)*et1(1,i);
%       % et1(1,:) is duration i
%       % (day)
%       %   else
%       % aet1(2:(p.neh+2),i)=aet1(2:(f3(6)+2),i-1)+et1(2:(f3(6)+2),i)*(et1(1,i)
%       %-et1(1,i-1));
%       %   end
%       %end
