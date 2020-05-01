% Run this file after the simulation is done
% Use this file to get an idea of desired passive parameter variables for
% inductance and capacitance

% Input voltage and current signals (need to change the output from the Simulink file to these values)
Vin=(out.PV.signals.values(:,1));
Iin=(out.PV.signals.values(:,3));

% Cap first ant last values for better analysis
Vin = Vin(2:end-1);
Iin = Iin(2:end-1);

% Variable initialization
delta_t = 1/100000;
ripple=0.05;
duty_cycle=1-0.000125;
L=zeros(size(Vin));
Cap=zeros(size(Vin));
R_load=zeros(size(Vin));

% Determine required inductance and capacitance
for i=1:size(Vin)
    L(i)=(Vin(i)*duty_cycle*delta_t)/((Iin(i))*ripple);
    Cap(i)=(duty_cycle*delta_t*(Iin(i))*(1-duty_cycle)^2)/(Vin(i)*ripple);
    Vout(i) = Vin(i)/duty_cycle;
    Iout(i)=Vin(i)*Iin(i)/Vout(i);
    R_load(i)=(Vout(i)/Iout(i));
end
R_load=R_load(1:end-1);

% Plot required inductance over voltage distbn
figure(1)
plot(Vin,L*1000);
title('Inductance over Voltage');
ylabel('Inductance [mH]');
xlabel('Voltage [V]');

% Plot required capacitance over voltage distbn
figure(2)
plot(Vin, Cap*1000000);
title('Capacitance over Voltage');
xlabel('Voltage [V]');
ylabel('Capacitance [\muF]');
fprintf('L>%1.16f mH    C>%.16f uF\n', max(L)*1000,max(Cap)*1000000);