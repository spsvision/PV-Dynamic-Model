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

A1=[(-R_L/L) 0; 0 -1/(C_eq*(R+R_c))];
A2=[(-R_L/L-((R*R_c)/(L*(R+R_c)))) (-R/(L*(R+R_c))); R/(C_eq*(R+R_c)) -1/(C_eq*(R+R_c))];
A=A1*duty+A2*(1-duty);
B=[1/L;0];
%H=[-(1-d)/L; 0];
C_state =  [1 0; ((1-duty)*(R*R_c)/(R+R_c)) R/(R+R_c)];
D=[0;0];

poly=charpoly(A);

% Monitoring controllability and tuning model
Wr = [B A*B];
rank(Wr)
Wr_tilde=inv([1 poly(2) poly(3); 0 1 poly(2); 0 0 1]);

% LQR parameter setup
% Linear Quadratic Regulator - https://www.mathworks.com/help/control/ref/lqr.html
q1=1;
q2=1;
Q=[[q1 0 0];[0 q2 0];[0 0 1]];
rho=10;
R=rho;

% Define Gains using LQR() function
[K,S,E]=lqr(A,B,Q,R)
K_r=-1/([1 0 0]*inv(A-B*K)*B)