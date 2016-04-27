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

k = 1;
for i = 1:length(Xd)
    if Xd(1) == Xd(i)
        k = k + 1;
    else
        break
    end
end

Dd = k;

theta_VL = Tb(Dd); % check if time is right

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

m = 1;
for j = 1:length(Xb)
    Xb(1) - Xb(j)
    if Xb(1) == Xb(j)
        m = m + 1;
    else
        break
    end
end

Db = m;

theta_VS = Tb(Db); % check if time is right

XbC = Xb(Db:end); % clean concentration

valb = (1 -exp(-1))*(XbC(end)-XbC(1))+XbC(1);
diff_b = abs(XbC - valb);
[min_b,Ib] = min(diff_b);

TbC = Tb(Db:end) - Tb(Db); % clean time

taup_VS = TbC(Ib);
kp_VS = XbC(end);


%% Run PI params VL (Ziegler-Nichols)

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


%% Problem 7
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
VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

num_VL = [0.45*2.03*(1/0.000323/1.2) 0.45*2.03];
den_VL = [(1/0.000323/1.2) 0];

sim('closed_closed_pi_VL')









