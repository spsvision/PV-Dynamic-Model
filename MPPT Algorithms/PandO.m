function D = PandO(Vpv,Ipv)

% incremental duty cycle change
delta_D = 0.005;

% grabs workspace variables or initializes them below
persistent Dprev Pprev Vprev

if isempty(Dprev)
    Dprev = 0.01;
    Vprev = 0;
    Pprev = 0;
end

% Calculate measured array power
Ppv = Vpv*Ipv;

% Increase or decrease duty cycle based on conditions
if (Ppv-Pprev) ~= 0
    if (Ppv-Pprev) > 0
        if (Vpv-Vprev) > 0
            D = Dprev - delta_D;
        else
            D = Dprev + delta_D;
        end
    else
        if (Vpv-Vprev) > 0
            D = Dprev + delta_D;
        else
            D = Dprev - delta_D;
        end        
    end
else
    D = Dprev;
end

% Forced filtering
if D >= 1 | D<= 0
    D=Dold;
end

% Update internal values
Dprev = D;
Vprev = Vpv;
Pprev = Ppv;
