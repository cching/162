%% Model Parameters 
M1 = 6000; M2 = 50; M3 = 50; M4 = 50; M5 = 50; M6 = 50; M7 = 50; M8 = 50; M9 = 50; M10 = 6000; alfa = 3.0;

%% Step Test VL
VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

sim('open_loop')

%% Find VL params

[taup_VL, kp_VL, theta_VL] = FODT(VL_out.signals.values, VL_out.time);

%% Step Test VS

VL_steptime = 0;
VS_steptime = 100;
VL_final = 0;
VS_final = 1;

sim('open_loop')


%% Find VS Params

[taup_VS, kp_VS, theta_VS] = FODT(VS_out.signals.values, VS_out.time);



%% Run PI params VL (IMC)

VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

lambda_VL = 500;
kc_VL = (taup_VL + 0.5*theta_VL)/(kp_VL*lambda_VL);
tau_i = taup_VL + 0.5*theta_VL;

num_VL = [kc_VL*tau_i kc_VL];
den_VL = [tau_i 0];

sim('closed_pi_VL')


%% Run PI params VS (IMC)


VL_steptime = 0;
VS_steptime = 100;
VL_final = 0;
VS_final = 1;

lambda_VS =1500;
kc_VS = (taup_VS + 0.5*theta_VS)/(kp_VS*lambda_VS);
tau_i = taup_VS + 0.5*theta_VS;

num_VS = [kc_VS*tau_i kc_VS];
den_VS = [tau_i 0];
sim('closed_pi_VS')



%% Problem 7


%% Find VL params


VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;


sim('closed_pi_VL')

%% 6i

[taup_VL_6i, kp_VL_6i, theta_VL_6i] = FODT(QT_XD.signals.values, QT_XD.time);


%%

VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

lambda_VL = 500;
kc_VL = (taup_VL_6i + 0.5*theta_VL_6i)/(kp_VL*lambda_VL);
tau_i = taup_VL_6i + 0.5*theta_VL_6i;

num_VL_6i = [kc_VL*tau_i kc_VL];
den_VL_6i = [tau_i 0];

sim('closed_closed_pi_pi_VL')



%% Find VS params


VL_steptime = 0;
VS_steptime = 100;
VL_final = 0;
VS_final = 1;


sim('closed_pi_VS')

%% 6i
[taup_VS_6i, kp_VS_6i, theta_VS_6i] = FODT(QT_XB.signals.values, QT_XB.time);


VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

lambda_VS = 100000000;
kc_VS = (taup_VS_6i + 0.5*theta_VS_6i)/(kp_VL*lambda_VS);
tau_i = taup_VS_6i + 0.5*theta_VS_6i;

num_VS_6i = [kc_VS*tau_i kc_VS];
den_VS_6i = [tau_i 0];

sim('closed_closed_pi_pi_VS')





