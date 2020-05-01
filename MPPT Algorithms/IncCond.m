function D = IncCond(V,I)

D_initial = 0.05;  %Initial value for D output
D_max = 1;   %Maximum value for D
D_min = 0;   %Minimum value for D
deltaD = 0.005; %Increment value used to increase/decrease the duty cycle D
  
persistent Vold Pold Dold M Iold;

dataType = 'double';

if isempty(Vold)
    Vold=0;
    Pold=0;
    Iold=0;
    Dold=D_initial;
    M=1;
end
P= V*I;
dV= V - Vold;
dP= P - Pold;
dI= I - Iold;
M=abs(dP);

if M < 0.005
    D=Dold;
else
    if dV == 0
        if dI == 0
            D=Dold;
        elseif dI>0
            D=Dold - (M*deltaD);
        else 
            D=Dold + (M*deltaD);
        end    
    else
        if dI/dV == -I/V
            D=Dold;
        elseif dI/dV>-I/V    
           D=Dold - (M*deltaD);
        else
           D=Dold + (M*deltaD);  
        end  
    end    
end

% Forced filtering
if D >= 1 | D<= 0
    D=Dold;
end

Dold=D;
Vold=V;
Pold=P;
Iold=I;
