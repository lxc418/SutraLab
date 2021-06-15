
function qv  = readQV(inp,ele)
%function qv = readQV(fname,inp,ele,nod,et)
%output  qv.se
%        qv.qvx
%        qv.qvy
%        qv.vapori_plane_z  
%        qv.se  

%function qv=readQV(fname,inp,ele,nod)
% notice that readQV still requires inp object, because the no of output
%   is dependent on inp object.
% this is not the case for readNOD
   fn   = fopen('QV.DAT');
   line = fgetl(fn);

   for i=1:length(ele) % why the first one is removed?
      temp  = {fgetl(fn)};
      qv(i).qvx = fscanf(fn, '%g   ', [inp.nn2-1,inp.nn1])';
      qv(i).qvy = fscanf(fn, '%g   ',[inp.nn2,inp.nn1-1])';
   end %loop

% %% -----------calculating the first vaporization plane location----------
% % ef(1,1:SWELE) is the time of the output (day)
% % ef(2:(p.nev+2),1:SWELE) is the position of the vaporization plane
% ef1=zeros(inp.nn2,length(ele));  % initialize the size of ef
% %ef1(1,:)=ta(2,:);   
% for i=1:length(ele) %p.neo   % loop of node on y direction 
%   for k=1:inp.nn2 %p.nnh   % loop of node on x direction
%     for j=1:inp.nn1 %p.nnv
% %        if a1(5,k*(p.nnv)-j+1,i)>=0.02 % 0.1 here is the corresponding residual liquid     
%         if nod(i).terms{s_nod_idx}(k*inp.nn1+1-j)>=0.02 % 0.1 here is the corresponding residual liquid     
%     % warning: this check is from the top of the column to the bottom
% %            ef1(k,i)=       %a1(2,k*(p.nnv)-j+1,i);
%              qv(i).vapori_plane_y(k)=nod(i).terms{y_nod_idx}(k*inp.nn1+1-j);
%             %a.vPlane= 
%         break
%         end %if
%     end % j=1:p.nnv
%   end % i=1;p.neo
% end % k=1:p.nnh
% 
% 
% 
% %% --------calculate the vaporization rate  --------
% % the vaporization rate is going to be located along with the existing 'a'
% % i.e., elementwize result
% % struct. this is because each cell/node will endup with a evaporation
% % or condensation rate. 
% 
% % however, at the very beginning, it is more staightforward to just construct
% % a matrix with p.nnh*p.nnv size to store all the values.
% 
% % the dimension of se matches with the real coordinates, that is, when row no 
% % increases, the elevation decreases.
% %qv.se=zeros(p.nnh,p.nnv);
% 
% 
% 
% for k=1:length(ele)
%     qv(k).se=zeros(inp.nn1,inp.nn2);
%     qv(k).steps     = nod(k).itout;
%     qv(k).t_elapsed = nod(k).tout;
%     for i=1:inp.nn2
% 	% the z location of each se
%     qv(k).se_z(:,i)  = ...
%             fliplr( ...
% 	    nod(k).terms{ y_nod_idx}...
% 	    ( inp.nn1*(i-1)+1 : inp.nn1*i) ...
% 	    );
% 	qv(k).se_x(:,i)  = ...
%             fliplr( ...
% 	    nod(k).terms{ x_nod_idx}...
% 	    ( inp.nn1*(i-1)+1 : inp.nn1*i) ...
% 	    );
%     end
%     for i=1:inp.nn2
%         if i==1
% 	    % qv(k).qvx(:,1)   let local evaporats, should be positive
%             qv(k).se(:,i)=qv(k).se(:,i)                           ...
% 	                  +qv(k).qvx(:,  i)*2 ./                  ...
% 			   (qv(k).se_x(:,i+1)-qv(k).se_x(:,i))    ...
%                           ;
%         elseif i==inp.nn2
% 	    % qv(k).qvx(:,i-1) lets local condensates, should be positive
%             qv(k).se(:,i)=qv(k).se(:,i)                           ...
% 	                  -qv(k).qvx(:,i-1)*2 ./                  ...
%                            (qv(k).se_x(:,i)-qv(k).se_x(:,i-1))    ...
% 	                  ;
%         else
% 	    % 
%             qv(k).se(:,i)=qv(k).se(:,i)                           ...
% 	                   -qv(k).qvx(:,i-1) ./                   ...
% 		             (qv(k).se_x(:,i)-qv(k).se_x(:,i-1))  ...
% 			   +qv(k).qvx(:,i)   ./                   ...
% 			     (qv(k).se_x(:,i+1)-qv(k).se_x(:,i))  ...
% 			   ;
%         end
%     end  %i from 1 to nnh
% 
%     % first for the vertical directions
%     for i =1:inp.nn1
%         if i==1
% 	    % Notice: evaporation rate has a unit of m/s, vaporization
% 	    %  and condensation has units of 1/s, se=e/dz
% 	    % et make local evaporation, se>0
% 	    % qv(k).qvy(i,:) is influx, making local evaporation,negative
%             qv(k).se(i,:)=qv(k).se(i,:)...
% 	                  +et(k).terms{strcmp(et(k).label,'et')} *2 ./ ...
% 	                   (  qv(k).se_z(i,:)-qv(k).se_z(i+1,:) )      ...
% 	                  -qv(k).qvy(i,:) *2 ./                        ...
% 			   (  qv(k).se_z(i,:)-qv(k).se_z(i+1,:) )      ...
% 			  ;
%         elseif i==inp.nn1
%             qv(k).se(i,:)= qv(k).se(i,:)                               ...
% 	                  +qv(k).qvy(i-1,:)*2 ./                       ...
% 			  ( qv(k).se_z(i-1,:)-qv(k).se_z(i,:) )        ...
% 			  ;
%         else
% 	    % qv(k).qvy(i-1,:) is going out, which results in eva, se>0
% 	    % -qv(k).qvy(i,:)  is getting in, which results in cond, se<0
%             qv(k).se(i,:)=qv(k).se(i,:)                                ...
% 	                  +qv(k).qvy(i-1,:) ./                         ...
% 			  ( qv(k).se_z(i-1,:)-qv(k).se_z(i  ,:) )      ...
% 			  -qv(k).qvy(i  ,:) ./                         ...
% 			  ( qv(k).se_z(i  ,:)-qv(k).se_z(i+1,:) )      ...
% 			  ;
%         end
%     end  % i loop 
% end % k loop


%% flip qv.se_z qv.qvx,qv.qvy,
for n = 1:length(qv)
   qv(n).qvx=flipud(qv(n).qvx);
   qv(n).qvy=flipud(qv(n).qvy);
%   qv(n).se=-flipud(qv(n).se);
end

fprintf(1,'First qv.dat reading finished\n');
end % function
