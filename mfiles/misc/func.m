%% function to calculate the water vapor density
% function dvv(t)
% dvv=2.29e-5*( (t+273.15)/273.15)^1.75;
%  return;
% end
classdef func
  methods (Static)
    % using temperature to calculate water vapor diffusivity (m2/s)
    function y = dv(tk)
        y=2.29e-5*(tk/273.15).^1.75;
    end
    
    % (S)aturated water (V)apor density (rho) at EM(5)0 channel (C) [rhovs]
    function y = rhovs(tk)
        y = 1e-3*exp(19.819-4976./tk);
    end
    % the derivative of (S)aturated (V)apor density
    function y=drhovs(tk)
       y=4.976./tk.^2.*exp(19.819-4976./tk);
    end
    
    % (R)elative (H)umidi(T)y
    function y=rht(psi,tk)
        y=exp(-psi*9.81*0.018/8.314./tk);
    end
        
    % (S)aturated water (V)apor (P)ressure 
    function y= svp(t)
        y = 611*exp(17.27*(t-273.15)./(t-35.85));
    end
    
    % (L)atent (H)eat for (V)aporization
    function y=lhv(t)
        y = 2500250-2365*(t-273.15);
    end
    % (S)urface (R)esistance from (V)an (D)er (G)rivend 1994
    function y=rs1994(sw,swres,por)
    % y=rs1994(sw,swres,por)
    % unit (s/m)
        y=10*exp(35.63*por*(swres-sw));
    end
    % (S)urface (R)esistance from Camillo et al. [1986]
    function y=rs1986(sw,por)
      y=-805+4140*por.*(1-sw);
    end
    % (S)urface (R)esistance from Daamen et al. [1996]
    function y=rs1996(sw,por)
      y=3e10*(por.*(1-sw)).^16.6;
    end
    % (S)urface (R)esistance from Sun et al. [1984]
    function y=rs1984(sw)
        y=3.5*(sw).^(-2.3)+33.5;
    end
    
    % function of newton raphson
    function y1=iterpsi(sw,psi,psib,lam,sr,psi0)
        y1=(psi/psib).^(-lam).*(1-sr*log(psi0./psi)/log(psi0))+...
            sr*log(psi0./psi)/log(psi0)-sw;
    end
    
    
    % the derivative of iterpsi. see page 99(8) for reference
    function y1=dswdpsi(psi,psib,lam,sr,psi0)
        y1=-(1-sr*log(psi0/psi)/log(psi0))*lam*psib^lam*psi^(-lam-1)+...
            psib^lam*psi^(-lam-1)*sr/log(psi0)-sr/psi/log(psi0);
    end
    
    
    % newton-raphson method to calculate the psic corresponding to 
    %the given saturation.
    function y1=nrmpsi(sw,psib,lam,sr,psi0,lim)
        
    % pretreatment for the results
        if sw>=1
            y1=psib;
            return    
        elseif sw<=0
            y1=psi0;    
            return
        end
    % start iteration        
        x=psib;
        for i=1:1000
        y=func.iterpsi(sw,x,psib,lam,sr,psi0);
        dx=-y/func.dswdpsi(x,psib,lam,sr,psi0);
        if abs(dx)<lim
            y1=x;
           return
        end
                  x=x+dx;
        end
    end
    
    
    
    
    % air viscosity
    function y1=visa(t)
        y1=18.27e-6*(291.5+120)/(t+120)*(t/291.5)^1.5;
    end
    
    % relative conductivity through edl due to vapor
    function y1=kvrvapor(del,tau,por,psi0,psip,l,psi)
        y1=del*tau*por*log(psi0)/l./log(psi+psip);
    end % func kvrvapor
    
    % relative conductivity through edl due to vapor, the effect of vapor 
    % through EDL itself is also considered.
    function y1=kvrvapor2(del,tau,por,psi0,psip,l,psi)
        y1=1./(1./(del*tau*por*log(psi0)/l./log(psi+psip))+1);
    end % func kvrvapor
    
    
    
    
    % (w)eighting (f)unction of (v)apor 
    
%     function y1=wfv(sw)
%         y1=(1-sw);
%     end %wfv
%    
%     % relative k induced by (f)ree water with a (a)pproximation with c3 as inter
%     % mediate solution
%     function y1=kvrfap(lam,psib,del,c3,psi)
%         y1=1./ (1+lam*psib/(1+lam)/del./psi.*c3);
%     end % kvrfree
%     
%     % c3temp is a temporary file for kvrfap
%     function y1=c3(por,psib,lam,nv,zeta,psi)
%        y1=(1./(por*( psi/psib ).^(-lam*(1+nv))  )-...
%      1./(por*  ( psi/psib ).^(-lam*(1+nv))  ).^0.5 ) ...
%      *zeta/(2*psib);
%     end %c3

  % relative k induced by (f)ree water using hypogeometric =kvrfap+c3
    function y1=kvrf(lam,psib,del,por,nv,zeta,psi)

    y1= hypergeom([1,lam],lam+1,- zeta/2./psi /del.*...
        (1./(por*  ( psi/psib ).^(-lam*(1+nv))  )-1./ ...
       ((por*  ( psi/psib ).^(-lam*(1+nv))  ).^0.5)) );
    end %kvrf

  % relative k induced by (f)ree water with a (s)implified =kvrfap+c3
    function y1=kvrfs(lam,psib,del,por,nv,zeta,psi)
    y1=1./ (1+lam/(1+lam)/del*zeta/2./psi.*...
     (1./(por*( psi/psib ).^(-lam*(1+nv)))...
     -1./(por*(psi/psib ).^(-lam*(1+nv))  ).^0.5 ) ...
     );
    end %kvrfs
  
  % (t)otal relative k function assembleing subroutine kvrfa,wfv and kvrvapor
    function y1=kvrt(lam,psib,del,por,nv,zeta,tau,psi0,psip,l,swres,psi)
       y1=func.kvrf(lam,psib,del,por,nv,zeta,psi)+...
           (1-func.fbc(psib,lam,psi0,swres,psi)).*...
           func.kvrvapor(del,tau,por,psi0,psip,l,psi);
       
    end % kvrt
 
    
  % (t)otal relative k function assembleing subroutine kvrfa,wfv and kvrvapor
  % (s)implified solution
    function y1=kvrts(lam,psib,del,por,nv,zeta,tau,psi0,psip,l,swres,psi)
       y1=func.kvrfs(lam,psib,del,por,nv,zeta,psi)+...
           (1-func.fbc(psib,lam,psi0,swres,psi)).*...
           func.kvrvapor(del,tau,por,psi0,psip,l,psi);
    end % kvrts

    
    
  % (t)otal relative k function assembleing subroutine kvrfa,wfv and kvrvapor
  % (s)implified solution
    function y1=kvrtsf(lam,psib,del,por,nv,zeta,tau,psi0,psip,l,psi)
       y1=func.kvrfs(lam,psib,del,por,nv,zeta,psi).*...
           (1-func.kvrvapor(del,tau,por,psi0,psip,l,psi))+...
           func.kvrvapor(del,tau,por,psi0,psip,l,psi);
    end % kvrts
    
  % (t)otal relative k function assembleing subroutine kvrfa,wfv and kvrvapor
  % (s)implified solution
    function y1=kvrtsf2(lam,psib,del,por,nv,zeta,tau,psi0,psip,l,psi)
       y1=func.kvrfs(lam,psib,del,por,nv,zeta,psi).*...
           (1-func.kvrvapor2(del,tau,por,psi0,psip,l,psi))+...
           func.kvrvapor2(del,tau,por,psi0,psip,l,psi);
    end % kvrts  
    
    
    
  % fayer and brooks and corey water retention function
    function y1=fbc(psib,lam,psi0,swres,psi)
        y1=((psi/psib).^(-lam)).*(1- swres* log( psi0./psi  )/log(psi0) )+...
    swres* log( psi0./psi  )/log(psi0);
    end % fbc

  % newton raphson method to calculate psi
    function y1=nrwrc(sw,psib,lam,sr,psi0,lim,dep)
    % start iteration        
        x=psib;
        for i=1:1000
        y=func.iterfunc(sw,x,psib,lam,sr,psi0,dep);
        
        dx=-y*dep/ (fbc(psib,lam,psi0,sr,psi+dep)-fbc(psib,lam,psi0,sr,psi+dep)     )    ;
        if abs(dx)<lim
            y1=x;
           return
        end
            x=x+dx;
        end
    end % nrwrc 
    
    
    % the original function used in newton raphson
    function y1=iterfunc(sw,psi,psib,lam,sr,psi0,dep)
        y1=(intfayer(psib,lam,psi0,sr,psi+dep)...
            -intfayer(psib,lam,psi0,sr,psi))/dep-sw;
    end % interfunc
    
    % the integration of fayer function
    function y1=intfayer(psib,lam,psi0,sr,psi)
        se=(psi/psib).^(-lam);
        y1=-sr*psi.*se/log(psi0)/(lam-1)^2  ...
           -psi.*se/(lam-1)                 ...
           +psi.*se*sr.*log(psi0./psi)/log(psi0)/(lam-1)...
           +psi*sr.*(1+log(psi0./psi))/log(psi0);
    end %intfayer
    
    
  end % methods
end  % end classdef
