%% Find VL/L Step
M1 = 6000; M2 = 50; M3 = 50; M4 = 50; M5 = 50; M6 = 50; M7 = 50; M8 = 50; M9 = 50; M10 = 6000; alfa = 3.0;
VL_steptime = 100;
VS_steptime = 0;
VL_final = 1;
VS_final = 0;
tau_i1 = 1956.2;
Kc1 = 0.45/0.736;
tau_i2 = 1000;
Kc2 = .1;
sim('closed_loop_pi')


%% Find VS/S Step
% xB end =     0.0274
% xD end =    0.9895


VL_steptime = 0;
VS_steptime = 100;
VL_final = 0;
VS_final = 1;
tau_i1 = 1956.2;
Kc1 = 0.45/0.736;
tau_i2 = 1/.000336/1.2;
Kc2 = 3;
sim('closed_loop_pi')

%%  blah

VL_out.time
VL_out.signals.values

Xd = VL_out.signals.values;


clean = VL_out.signals.values(127:end)
clean_time = VL_out.time(127:end) - 900;
plot(clean,VL_out.time(127:end))
plot(VL_out.time(127:end),clean)
plot(VL_out.time(127:end)-900,(clean-clean(1))/clean(end)+1)

mark1 = log(1 - clean./clean(end))


y = @(x) 1 -exp(-x./(335.0924))
plot(VL_out.time, y(VL_out.time)-clean(1))


%% blah 2


VS_out.time
VS_out.signals.values

Xd = VS_out.signals.values;

clean_end = VS_out.time(782:end);

clean = VS_out.signals.values(782:end)
clean_time = clean_end - 1036.6;



plot(clean,clean_end)
plot(clean_end,clean)
plot(clean_end-900,(clean-clean(1))/clean(end)+1)

mark1 = log(1 - clean./clean(end))


y = @(x) 1 -exp(-x./(335.0924))
plot(VS_out.time, y(VS_out.time)-clean(1))


0.632*(clean(end)-clean(1))

ans =

   -0.0142

clean(1)+ans

ans =

    0.0356

clean_time(68)

ans =

  815.2520

val = (1 -exp(-1))*(clean(end)-clean(1))+clean(1)
diff = abs(clean - val);
[M,I] = min(diff)

taup2 = clean_time(I)

find(diff == min(diff))


Y = tf([clean(end)],[taup2 1],'InputDelay', 1036.6);
bode(Y)










