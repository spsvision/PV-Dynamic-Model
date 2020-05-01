function D = ConstVolt(Vpv)

% incremental duty cycle change
delta_d = 0.005;

% grabs workspace variables or initializes them below
persistent Dprev Vprev

if isempty(Dprev)
    Dprev = 0.01;
    Vprev = 0;
end
Voc = 36.7;
Vref = 0.76*Voc;

% Increase or decrease duty cycle based on conditions
if abs(Vref - Vpv)<44
    D = Dprev;
else
    if Vpv>Vref
        D = Dprev+delta_d;
    else
        D = Dprev - delta_d;
    end
end

% Update internal values
Dprev = D;
Vprev = Vpv;
