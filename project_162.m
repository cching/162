%% Model Parameters 
M1 = 6000; M2 = 50; M3 = 50; M4 = 50; M5 = 50; M6 = 50; M7 = 50; M8 = 50; M9 = 50; M10 = 6000; alfa = 3.0;

%% Step Test VL
VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

sim('open_loop')

%% Find VL params

Td = VL_out.time;
Xd = VL_out.signals.values;

% either write code to find delay or go through array

%dxdt_d = diff(Xd)./diff(Td);
%[Md, Dd] = max(abs(dxdt_d));

Dd = 720; % find index of time delay

theta_VL = 1032.47989069241; % check if time is right

XdC = Xd(Dd:end); % clean concentration

val = (1 -exp(-1))*(XdC(end)-XdC(1))+XdC(1);
diff_d = abs(XdC - val);
[min_d,Id] = min(diff_d);

TdC = Td(Dd:end) - Td(Dd); % clean time

taup_VL = TdC(Id);
kp_VL = XdC(end);

%% Step Test VS

VL_steptime = 0;
VS_steptime = 100;
VL_final = 0;
VS_final = 1;

sim('open_loop')


%% Find VS Params

Tb = VS_out.time;
Xb = VS_out.signals.values;

% either write code to find delay or go through array
%dxdt_b = diff(Xb)./diff(Tb);
%[Mb, Db] = max(abs(dxdt_b));

Db = 781; % find index of time delay

theta_VS = Tb(Db); % check if time is right

XbC = Xb(Db:end); % clean concentration

valb = (1 -exp(-1))*(XbC(end)-XbC(1))+XbC(1);
diff_b = abs(XbC - valb);
[min_b,Ib] = min(diff_b);

TbC = Tb(Db:end) - Tb(Db); % clean time

taup_VS = TbC(Ib);
kp_VS = XbC(end);

%% Bode Plot Analysis

Yd = tf([kp_VL],[taup_VL 1], 'InputDelay', theta_VL);
figure
bode(Yd)

Yb = tf([kp_VS],[taup_VS 1], 'InputDelay', theta_VS);
figure
bode(Yb)


%% Run PI params VL (Ziegler-Nichols)

VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

num_VL = [0.45*2.03*(1/0.000323/1.2) 0.45*2.03];
dem_VL = [(1/0.0003232/1.2) 0];

sim('project_pi_VL')


%% Run PI params VS (???)

VL_steptime = 0;
VS_steptime = 1000;
VL_final = 0;
VS_final = 1;

tauc_VS = 500;
taui_VS = taup_VS + 0.5*theta_VS;
kc_VS = (taup_VS)/(kp_VS*(theta_VS + tauc_VS));

num_VS = [kc_VS*taui_VS kc_VS];
dem_VS = [taui_VS 0];

sim('project_pi_VS')


%% Extranneous

% IMC

%                 tauc_VS = 1;
%                 kc_VS = (taup_VS)/(kp_VS*(theta_VS + tauc_VS));
%                 taui_VS = taup_VS + 0.5*theta_VS;
% 
%                 tauc_VL = 1;
%                 kc_VL = (taup_VL)/(kp_VL*(theta_VL + tauc_VL));
%                 taui_VL = taup_VL + 0.5*theta_VL;
%                 
% 
%                 num_VL = [kc_VL*taui_VL kc_VL];
%                 dem_VL = [taui_VL 0];
%                 num_VS = [kc_VS*taui_VS kc_VS];
%                 dem_VS = [taui_VS 0];
%     



%% find lambda












