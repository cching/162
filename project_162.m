%% #5

%% Model Parameters 
M1 = 6000; M2 = 50; M3 = 50; M4 = 50; M5 = 50; M6 = 50; M7 = 50; M8 = 50; M9 = 50; M10 = 6000; alfa = 3.0;

%% Step Test VL
VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

sim('open_loop') % outputs VL_oout

% Find VL params
[taup_VL, kp_VL, theta_VL] = FODT(VL_out.signals.values, VL_out.time);

% Run PI params VL (IMC)

lambda_VL = 150;
kc_VL = (taup_VL + 0.5*theta_VL)/(kp_VL*lambda_VL);
tau_i = taup_VL + 0.5*theta_VL;

num_VL = [kc_VL*tau_i kc_VL];
den_VL = [tau_i 0];

sim('closed_pi_VL') % Run closed-loop PI controller for VL
plot(QT_XD)

%% Step Test VS

VL_steptime = 0;
VS_steptime = 100;
VL_final = 0;
VS_final = 1;

sim('open_loop') % outputs VS_out

% Find VS Params

[taup_VS, kp_VS, theta_VS] = FODT(VS_out.signals.values, VS_out.time);

% Run PI params VS (IMC)

lambda_VS =1500;
kc_VS = (taup_VS + 0.5*theta_VS)/(kp_VS*lambda_VS);
tau_i = taup_VS + 0.5*theta_VS;

num_VS = [kc_VS*tau_i kc_VS];
den_VS = [tau_i 0];

sim('closed_pi_VS') % Run closed loop PI controller for VS

%% Problem 6

%% Find VL params

VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

sim('closed_pi_VL') % outputs QT_XD
%% 6i

[taup_VL_6i, kp_VL_6i, theta_VL_6i] = FODT(QT_XD.signals.values, QT_XD.time);

lambda_VL = 550;
kc_VL = (taup_VL_6i + 0.5*theta_VL_6i)/(kp_VL_6i*lambda_VL);
tau_i = taup_VL_6i + 0.5*theta_VL_6i;

num_VL_6i = [kc_VL*tau_i kc_VL];
den_VL_6i = [tau_i 0];

sim('closed_closed_pi_pi_VL') % Outputs QT_XD_cascade, run cascade controller for PI/PI for VL
plot(pv_change)


%% 6ii PID for VL

VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

[taup_VL_6ii, kp_VL_6ii, theta_VL_6ii] = FODT(QT_XD_cascade.signals.values, QT_XD_cascade.time);

lambda_VL_6ii = 500; 
alpha_VL = 10;
kc_VL = ((taup_VL_6ii + 0.5*theta_VL_6ii)/(lambda_VL_6ii + 0.5*theta_VL_6ii))/kp_VL_6ii;
tau_i = taup_VL_6ii + 0.5*theta_VL_6ii;
tau_d = (taup_VL_6ii*theta_VL_6ii)/(2*taup_VL_6ii + theta_VL_6ii);

num_VL_6ii = kc_VL*conv([tau_i 1],[tau_d 1]);
den_VL_6ii = [tau_d*tau_i*alpha_VL tau_i 0];

sim('closed_closed_pi_pid_VL') % Outputs result, run cascade controller for PI/PID for VL

plot(sp_change)


%% 6 c

%% 0.5% SP change in PI
VL_steptime = 100;
VS_steptime = 0;
VL_final = 0.98*0.005;
VS_final = 0;

[taup_VL_6i, kp_VL_6i, theta_VL_6i] = FODT(QT_XD.signals.values, QT_XD.time);

lambda_VL = 7.01; %frequency analysis
kc_VL = (taup_VL_6i + 0.5*theta_VL_6i)/(kp_VL_6i*lambda_VL);
tau_i = taup_VL_6i + 0.5*theta_VL_6i;

num_VL_6i = [kc_VL*tau_i kc_VL];
den_VL_6i = [tau_i 0];

sim('closed_closed_pi_pi_VL') % Outputs QT_CD_cascade, run cascade controller for PI/PI for VL

plot(sp_change)
title('Setpoint for a 0.5% Setpoint Change')
xlabel('Time (s)')
ylabel('Molar Flowrate')

figure
plot(pv_change)
title('Process Variable for a 0.5% Setpoint Change')
xlabel('Time (s)')
ylabel('Mole Fraction x_D')

figure
plot(mv_change)
title('Manipulated Variable for a 0.5% Setpoint Change')
xlabel('Time (s)')
ylabel('Molar Flowrate')

%% 0.5% SP Change in PID

VL_steptime = 100;
VS_steptime = 0;
VL_final = 0.98*0.005;
VS_final = 0;

[taup_VL_6ii, kp_VL_6ii, theta_VL_6ii] = FODT(QT_XD_cascade.signals.values, QT_XD_cascade.time);

% kc_VL = ((taup_VL_6ii + 0.5*theta_VL_6ii)/(lambda_VL_6ii + 0.5*theta_VL_6ii))/kp_VL_6ii;
% tau_i = taup_VL_6ii + 0.5*theta_VL_6ii;
% tau_d = (taup_VL_6ii*theta_VL_6ii)/(2*taup_VL_6ii + theta_VL_6ii);

[GcPIDn, GcPIDd] = IMCPIDFODT(taup_VL_6ii, kp_VL_6ii,theta_VL_6ii,1000,100);

num_VL_6ii = GcPIDn;
den_VL_6ii = GcPIDd;

sim('closed_closed_pi_pid_VL') % Outputs result, run cascade controller for PI/PID for VL

plot(sp_change)
title('Setpoint for a 0.5% Setpoint Change')
xlabel('Time (s)')
ylabel('Molar Flowrate')

figure
plot(pv_change)
title('Process Variable for a 0.5% Setpoint Change')
xlabel('Time (s)')
ylabel('Mole Fraction x_D')

figure
plot(mv_change)
title('Manipulated Variable for a 0.5% Setpoint Change')
xlabel('Time (s)')
ylabel('Molar Flowrate')








