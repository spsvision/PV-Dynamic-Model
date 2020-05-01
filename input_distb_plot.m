irr=[100 400 550 700 700 800 800 750 600 500 400 200 200];
temp=[10 11 14 16 18 20 20 19 17 15 14 10 8];
time=[0 10 20 30 40 50 60 70 80 90 100 110 120];
figure(4)
hold on
title('Example Input Distributions for Victoria Spring Day')
xlabel('Time');
yyaxis left
plot(time,irr,'LineWidth',2);
ylim([0 1000]);
ylabel('Irradiance [W/m^2]');
yyaxis right
plot(time, temp,'LineWidth',2);
ylabel('Temperature [\circ C]');
ylim([0 21]);
hold off