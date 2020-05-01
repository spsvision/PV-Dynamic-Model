function [L,C,R_load] = passive_parameters(temp, ripple)
% Use this function to plot capacitance and inductance over duty cycle
% based on ripple and temperature. Displayed current and voltage values are
% for a set solar array configuration. Match appropriate values to the
% exact array of choice. This ultimately helps better size boost converter
% and PWM signal generator.
if temp > 10
    Vin = 64.41;
    Iin = 15.17;
elseif temp > 12
    Vin = 63.83;
    Iin = 15.19;        
elseif temp > 14
    Vin = 63.34;
    Iin = 15.17;        
elseif temp > 16
    Vin = 62.15;
    Iin = 15.24;            
elseif temp > 18
    Vin = 61.6;
    Iin = 15.25;                
end

delta_t = 0.001;
duty_cycle = 0.000125:0.000125:1;

L=zeros(size(duty_cycle));
C=zeros(size(duty_cycle));
R_load=zeros(size(duty_cycle));

for i=1:size(duty_cycle)
    L(i)=(Vin*duty_cycle(i)*delta_t)/(Iin*ripple);
    C(i)=(duty_cycle(i)*delta_t*Iin*(1-duty_cycle(i))^2)/(Vin*ripple);
    Vout(i) = Vin/duty_cycle(i);
    Iout(i)=Vin*Iin/Vout;
    R_load(i)=(Vout/Iout);
end

figure(1)
plot(duty_cycle, L);
title('Inductance over duty cycle');
xlabel('Duty Cycle (%)');
xlim([0 0.01]);
ylabel('Inductance [mH]');

figure(2)
plot(duty_cycle, C*1000000);
title('Capacitance over duty cycle');
xlabel('Duty Cycle (%)');
ylabel('Capacitance [uF]');

fprintf('L>%1.16f mH    C>%.16f uF    R=%f \n', max(L)*1000,max(C)*1000000,mean(R_load));

