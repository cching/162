function [taup, Kp, theta] = FODT(x,t)

k = 1;
for i = 1:length(x)
    if x(1) == x(i)
        k = k + 1;
    else
        break
    end
end

delay = k;

theta = t(delay); % check if time is right

xc = x(delay:end); % clean concentration

val = (1 -exp(-1))*( xc(end)-xc(1) ) + xc(1);
% convert to deviation, and find value of first time constant

dx = abs(xc - val);

[nothing ,I] = min(dx);

tc = t(delay:end) - t(delay); % clean time

taup = tc(I);
Kp = xc(end);