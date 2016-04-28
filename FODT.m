function [taup, Kp, theta] = FODT(x,t)
% this function find the parameters of a FODT process 

k = 1;
for i = 1:length(x)
    if x(1) == x(i)
        k = k + 1;
    else
        break
    end
end


xc = x(k:end); % concentration without time delay

val = (1 -exp(-1))*( xc(end)-xc(1) ) + xc(1);
% convert to deviation, and find value of first time constant

dx = abs(xc - val);
[n ,I] = min(dx);
% find index of time constant

tc = t(k:end) - t(k); % clean time

theta = t(k); % gets value of time delay
taup = tc(I); % process time constant (based off of clean time)
Kp = xc(end); % process gain