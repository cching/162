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

theta_VL = Td(Dd); % check if time is right

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
Td = QT_XD.time;
Xd = QT_XD.signals.values;

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

VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

lambda_VL = 500;
kc_VL = (taup_VL + 0.5*theta_VL)/(kp_VL*lambda_VL);
tau_i = taup_VL + 0.5*theta_VL;

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
Td = QT_XB.time;
Xd = QT_XB.signals.values;

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

VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;

lambda_VL = 100000000;
kc_VL = (taup_VL + 0.5*theta_VL)/(kp_VL*lambda_VL);
tau_i = taup_VL + 0.5*theta_VL;

num_VS_6i = [kc_VL*tau_i kc_VL];
den_VS_6i = [tau_i 0];

sim('closed_closed_pi_pi_VS')





