function D = CurrentSweep(Vpv,Iload)

% incremental duty cycle change
delta_d = 0.0005;
delta_t=1/100000;
% grabs workspace variables or initializes them below
persistent Dprev Vprev Iprev

if isempty(Dprev)
    Dprev = 0.01;
    Vprev = 0;
    Iprev = 0;
end

dVpv = (Vpv-Vprev)/delta_t;
dIload = (Iload - Iprev)/delta_t;

% Increase or decrease duty cycle based on conditions
% Increase or decrease duty cycle based on conditions
if abs(dVpv)<3300
    D = Dprev;
else
    if sign(dIload) && sign(dVpv)
        D=Dprev+delta_d; 
    else
        D=Dprev-delta_d; 
    end    
end
% Update internal values
Dprev = D;
Vprev = Vpv;
Iprev = Iload;
