% Passive Parameter Variables
L = 0.01;
C_eq = 500e-6;
R = 20;
R_L = 0.10;
R_s=0.29304;
R_sh=120.6455;
R_m=0.38;
V_d=0.8;
R_c=0.0001;

% Additional variables
duty = 0.000874370313024986;
Vd = 0.6;

% Define State-space matrix
A1=[(-R_L/L) 0; 0 -1/(C_eq*(R+R_c))];
A2=[(-R_L/L-((R*R_c)/(L*(R+R_c)))) (-R/(L*(R+R_c))); R/(C_eq*(R+R_c)) -1/(C_eq*(R+R_c))];
A=A1*duty+A2*(1-duty);
B=[1/L;0];
%H=[-(1-duty)/L; 0];
C_state =  [1 0; ((1-duty)*(R*R_c)/(R+R_c)) R/(R+R_c)];
D=[0;0];

poly=charpoly(A);
[num,den]=ss2tf(A,B,C_state,D);

% Check Controllability. Rank must be 2!
[num,den]=ss2tf(A,B,C_state,D);
Wr = [B A*B];
rank(Wr)
eigs=[(-55+3*i) (-55-3*i)];

% Check Observability. Rank must be 2!
obs=obsv(A,C_state);
rank(obs)
defs=eig(A)

% Define Gains using place() function - https://www.mathworks.com/help/control/ref/place.html
K=place(A,B,eigs);
K_r=-1/([((1-duty)*(R*R_c)/(R+R_c)) R/(R+R_c)]*inv(A-B*K)*B);

% Step response of control variables
figure(1)
num1=[num(1,2) num(1,3)];
sys1=tf(num1,den);
step(sys1);
inf1=stepinfo(sys1);
title('Inductor Current Step Response');

figure(2)
num2=[num(2,2) num(2,3)];
sys2=tf(num2,den);
step(sys2);
inf2=stepinfo(sys2);
title('Capacitor Voltage Step Response');

% Frequency response of control variables
figure(3)
bode(sys1);
title('Inductor Current Bode Plot');
figure(4)
bode(sys2);
title('Capacitor Voltage Bode Plot');

% Step response of control variables with applied gain
figure(5)
ss2=ss(A-B*K,B,C_state,D);
step(ss2);
inf_fin=stepinfo(ss2);
final_dampened_response=damp(ss2);